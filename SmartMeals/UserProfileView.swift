//
//  UserProfileView.swift
//  SmartMeals
//
//  Created by Shreyhan Lakhina on 10/27/24.
//

import SwiftUI
import SwiftData

struct UserProfileView: View {
    @Environment(\.modelContext) private var context
    @Query private var users: [User]
    @FocusState private var budgetFocused: Bool
    var body: some View {
    let user: User = users.first!
        VStack {
            Image(user.picture)
                .resizable()
                .frame(width: 100, height: 100)
                .padding()
            
            Text(user.firstName + " " + user.lastName)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
            
            HStack {
                Text("Roommates:")
                    .font(.headline)
                Stepper(value: Binding(
                    get: { user.numRoommates },
                    set: { user.numRoommates = $0 }),
                    in: 1...10) {
                    Text(String(user.numRoommates))
                }
            }
            .padding([.leading, .trailing], 80)
            
            HStack {
                var newBudget: Double = user.budget
                Text("Budget:")
                    .font(.headline)
                TextField("Budget", value: Binding(
                    get: { user.budget },
                    set: { newBudget = $0 }),
                    format: .currency(code: "USD")
                )
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                .frame(width: 100)
                .submitLabel(.done)
                .focused($budgetFocused)
                Button(action: {
                    budgetFocused = false
                    user.budget = newBudget
                    printUserDetails(u: user)
                }) {
                    Text("\u{2713}")
                }
            }
            
            VStack(alignment: .leading) {
                Text("Dietary Preferences:")
                    .font(.headline)
                    .padding(.top)
                
                Toggle("Vegan", isOn: Binding(
                    get: { user.vegan },
                    set: { newValue in user.vegan = newValue }))
                    .padding(.vertical, 5)
                Toggle("Vegetarian", isOn: Binding(
                    get: { user.vegetarian },
                    set: { newValue in user.vegetarian = newValue }))
                    .padding(.vertical, 5)
                Toggle("Gluten Free", isOn: Binding(
                    get: { user.glutenFree },
                    set: { newValue in user.glutenFree = newValue }))
                    .padding(.vertical, 5)
                Toggle("Nut Allergy", isOn: Binding(
                    get: { user.nutAllergy },
                    set: { newValue in user.nutAllergy = newValue }))
                    .padding(.vertical, 5)
            }
            .padding([.leading, .trailing], 20)
        }
    }
    
    // to test ensuring that details are all being updated as expected!
    func printUserDetails(u: User) {
        print(u)
        print(u.firstName + " " + u.lastName)
        print(u.numRoommates)
        print(u.budget)
        print(u.vegan)
        print(u.vegetarian)
        print(u.glutenFree)
        print(u.nutAllergy)
    }
}

#Preview("UserProfileView") {
    UserProfileView()
}

