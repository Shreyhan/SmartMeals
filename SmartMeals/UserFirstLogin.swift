//
//  UserFirstLogin.swift
//  SmartMeals
//
//  Created by Shreyhan Lakhina on 10/30/24.
//

import SwiftUI
import AuthenticationServices
import SwiftData

/**
 For testing purposes:
 If the user has already given their apple id to the app, it will not be able to request for this information again
 to fix, go into settings, click your name, go to sign in with apple, and delete the app from it right now, then it will act as a new sign in!
 */

struct UserFirstLogin: View {
    @Environment(\.modelContext) private var context
    @State private var signUpComplete: Bool = false
    @Query private var users: [User]
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    
    var body: some View {
        NavigationView {
            if let _: User = users.first {
                ContentView()
            } else {
                ZStack(alignment: .bottom) {
                    GeometryReader {
                        let size = $0.size
                        
                        Image(.signupbg)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .offset(x: 120)
                            .frame(width: size.width, height: size.height)
                    }
                    .mask {
                        Rectangle()
                            .fill(.linearGradient(
                                colors: [
                                    .white,
                                    .white,
                                    .white,
                                    .white,
                                    .white.opacity(0.9),
                                    .white.opacity(0.6),
                                    .white.opacity(0.2),
                                    .clear,
                                    .clear
                                ],
                                startPoint: .top,
                                endPoint: .bottom))
                    }
                    .ignoresSafeArea()
                    
                    VStack(alignment: .leading) {
                        Text("Welcome to SmartMeals! \nPlease sign in to continue.")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        SignInWithAppleButton(
                            onRequest: { request in
                                request.requestedScopes = [.fullName]
                            },
                            onCompletion: { result in
                                switch result {
                                case .success(let authorization):
                                    if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                                        if let fullName = appleIDCredential.fullName {
                                            firstName = fullName.givenName ?? "First"
                                            lastName = fullName.familyName ?? "Last"
                                        }
                                    }
                                    
                                    let user = User(firstName: firstName, lastName: lastName)
                                    context.insert(user)
                                    do {
                                        try context.save()
                                        signUpComplete = true
                                    } catch {
                                        print("Failed to save user profile: \(error)")
                                    }
                                    break
                                case .failure(let error):
                                    print("Authorization failed: \(error.localizedDescription)")
                                    break
                                }
                            }
                        )
                        .frame(height: 45)
                        .clipShape(.capsule)
                    }
                    .padding(30)
                }
                .background(Color.white)
            }

        }
    }
    
}

#Preview {
    UserFirstLogin()
}
