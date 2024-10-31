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
//    @State var user: User = User()
//    @State var user: UserProfile
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
                Stepper(value: Binding(
                    get: { user.numRoommates },
                    set: { user.numRoommates = $0 }),
                    in: 1...10) {
                    Text(String(user.numRoommates))
                        .font(.headline)
                }
            }
            .padding([.leading, .trailing], 80)
            
            HStack {
                Text("Budget:")
                    .font(.headline)
                TextField("Budget", value: Binding(
                    get: { user.budget },
                    set: {
                        user.budget = $0
                        do {
                            try context.save()
                        } catch {
                            print("Failed to save updated budget: \(error)")
                        }
                    }),
                    format: .currency(code: "USD")
                )
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                .frame(width: 100)
            }
            
            VStack(alignment: .leading) {
                Text("Dietary Preferences:")
                    .font(.headline)
                    .padding(.top)
                
                Toggle("Vegan", isOn: Binding(get: { user.vegan }, set: { newValue in user.vegan = newValue }))
                    .padding(.vertical, 5)
                Toggle("Vegetarian", isOn: Binding(get: { user.vegetarian }, set: { newValue in user.vegetarian = newValue }))
                    .padding(.vertical, 5)
                Toggle("Gluten Free", isOn: Binding(get: { user.glutenFree }, set: { newValue in user.glutenFree = newValue }))
                    .padding(.vertical, 5)
                Toggle("Nut Allergy", isOn: Binding(get: { user.nutAllergy }, set: { newValue in user.nutAllergy = newValue }))
                    .padding(.vertical, 5)
            }
            .padding([.leading, .trailing], 20)
        }
    }
}

#Preview {
//    UserProfileView(user: UserProfile(firstName: "Lisa", lastName: "White", picture: "lisa_white", numRoommates: 4, budget: 100, groceryList: [GroceryItem(name: "Tomatoes", imageName: "pasta_icon", price: 0.50, quantity: 7, isChecked: false), GroceryItem(name: "Pickles", imageName: "image_here", price: 1.00, quantity: 7, isChecked: true)], vegan: true, vegetarian: false, glutenFree: false, nutAllergy: false))
    UserProfileView()
}
