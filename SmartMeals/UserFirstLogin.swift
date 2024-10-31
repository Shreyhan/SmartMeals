//
//  UserFirstLogin.swift
//  SmartMeals
//
//  Created by Shreyhan Lakhina on 10/30/24.
//

/**
 NEED TO BE A PART OF THE APPLE DEVELOPER PROGRAM TO
 */

import SwiftUI
import AuthenticationServices
import SwiftData


struct UserFirstLogin: View {
    @Environment(\.modelContext) private var context
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    
    var body: some View {
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
                    .foregroundColor(.white)
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
                            } catch {
                                print("Failed to save user profile")
                            }
                            
                            
                            break
                        case .failure(let error):
                            print(error)
                            // PRINT ERROR HERRE
                            break
                        }
                    }
                )
                .frame(height: 45)
                .clipShape(.capsule)
                .colorInvert()
                
            }
            .padding(30)
        }
        .background(Color.black)
    }
    
}

#Preview {
    UserFirstLogin()
}
