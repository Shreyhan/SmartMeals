//
//  UserSignUpView.swift
//  SmartMeals
//
//  Created by Shreyhan Lakhina on 10/23/24.
//

import SwiftUI

struct UserSignUpView: View {
    var body: some View {
            VStack {
                // NEED TO MAKE THIS LOOK LESS UGLY
                // im too lazy to make the rest of the views... imma do those later lmao 
                Text("Sign In")
                    .font(.largeTitle)
                Button(action: {
                    // NEED TO PUT GOOGLE SIGN UP THING HERE
                }) {
                    Text("Sign in with Google")
                }
            }
            .padding()
        }
}

#Preview {
    UserSignUpView()
}
