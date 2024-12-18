//
//  UserSignUpView.swift
//  SmartMeals
//
//  Created by Shravani on 10/27/24.
//

import SwiftUI

struct UserSignUpView: View {
//    @Environment(\.modelContext) private var context
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to SmartMeals!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Button(action: {
//                    createAccount()
                }) {
                    Text("Sign In with Google")
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding()
        }
    }
    
//    func createAccount() {
//        let user = User(firstName: "Lisa", lastName: "White")
//        context.insert(user)
//        do {
//            try context.save()
//        } catch {
//            print("Failed to save user profile")
//        }
//    }
}

#Preview {
    UserSignUpView()
}
