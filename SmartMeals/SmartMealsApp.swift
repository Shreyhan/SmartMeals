//
//  SmartMealsApp.swift
//  SmartMeals
//
//  Created by Shreyhan Lakhina on 10/23/24.
//

import SwiftUI
import SwiftData

@main
struct SmartMealsApp: App {
    @StateObject private var user = User() // Initialize the User object here

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(user) // Pass the User object to the environment
                .modelContainer(for: [User.self, GroceryItem.self, Recipe.self, Day.self, Meal.self, MealPlan.self])
        }
    }
}

////define a meal structure
//struct Meal {
//    //specify Breakfast, Lunch, or Dinner
//    var type: String
//    var name: String
//    var imageName: String?
//}
////define day structure
//struct Day {
//    var name: String
//    var meals: [Meal]
//    var notes: String? //optional dietary notes for day
//}

struct Recipeee {
    let name: String
    let imageName: String
    let ingredients: [String]
    let instructions: [String]
    let time: String
}
//
//struct GroceryItem {
//    var id = UUID()
//    var name: String
//    var imageName : String
//    var price: Double
//    var quantity: Int
//    var isChecked: Bool
//}
//
//struct UserProfile {
//    var firstName: String
//    var lastName: String
//    var picture: String
//    var numRoommates: Int
//    var budget: Double
//    var groceryList: [GroceryItem]
//    var vegan: Bool
//    var vegetarian: Bool
//    var glutenFree: Bool
//    var nutAllergy: Bool
//}
