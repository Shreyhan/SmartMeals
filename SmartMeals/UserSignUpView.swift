//
//  UserSignUpView.swift
//  SmartMeals
//
//  Created by Shravani on 10/27/24.
//

import SwiftUI

struct UserSignUpView: View {
    var body: some View {
        VStack {
            Text("Welcome to SmartMeals!")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Button(action: {
                // Action for Add button
                print("Sign In")
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

#Preview {
    UserSignUpView()
}
