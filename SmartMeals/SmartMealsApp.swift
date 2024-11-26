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
