//
//  SmartMealsApp.swift
//  SmartMeals
//
//  Created by Shreyhan Lakhina on 10/23/24.
//

import SwiftUI

@main
struct SmartMealsApp: App {
    var body: some Scene {
        WindowGroup {
            CreateRecipeView()
        }
    }
}
//define a meal structure
struct Meal {
    //specify Breakfast, Lunch, or Dinner
    var type: String
    var name: String
    var imageName: String?
}
//define day structure
struct Day {
    var name: String
    var meals: [Meal] = []
    var notes: String? //optional dietary notes for day
}
