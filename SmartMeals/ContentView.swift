//
//  ContentView.swift
//  SmartMeals
//
//  Created by Shreyhan Lakhina on 10/23/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var users: [User] 
    var body: some View {
        if users.isEmpty {
            UserFirstLogin()
                .onAppear {
                    print(users)
                }
        } else {
            UserProfileView()
                .onAppear {
                    print(users)
                    print(users.first!.firstName)
                }
        }
    }
}

#Preview {
    ContentView()
}
