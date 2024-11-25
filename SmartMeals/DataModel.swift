//
//  DataModel.swift
//  SmartMeals
//
//  Created by Shreyhan Lakhina on 10/30/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class User: ObservableObject{
    var firstName: String
    var lastName: String
    var picture: String
    var numRoommates: Int
    var budget: Double
    var vegan: Bool
    var vegetarian: Bool
    var glutenFree: Bool
    var nutAllergy: Bool
    
    init(firstName: String = "First", lastName: String = "Last", picture: String = "defaultUser", numRoommates: Int = 1, budget: Double = 0.0, vegan: Bool = false, vegetarian: Bool = false, glutenFree: Bool = false, nutAllergy: Bool = false) {
        self.firstName = firstName
        self.lastName = lastName
        self.picture = picture
        self.numRoommates = numRoommates
        self.budget = budget
        self.vegan = vegan
        self.vegetarian = vegetarian
        self.glutenFree = glutenFree
        self.nutAllergy = nutAllergy
    }
}

@Model
class GroceryItem: Identifiable {
    var id: UUID
    var name: String
    var imageName: String
    var price: Double
    var quantity: Int
    var isChecked: Bool
    
    init(id: UUID, name: String, imageName: String = "defaultGrocery.png", price: Double = 0.0, quantity: Int = 1, isChecked: Bool = false) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.price = price
        self.quantity = quantity
        self.isChecked = isChecked
    }
}

@Model
class Recipe {
    var name: String
//    var imageData: Data
    @Attribute(.externalStorage) var image: Data?
    var ingredients: [String]
    var instructions: [String]
    var time: String
    
    init(name: String, image: Data? = UIImage(systemName: "fork.knife")?.pngData(), ingredients: [String], instructions: [String], time: String) {
        self.name = name
        self.image = image
        self.ingredients = ingredients
        self.instructions = instructions
        self.time = time
    }
}

// New data model for the Day (to store meals for each day)
@Model
class Day {
    var name: String
    var meals: [Meal]
    var order: Int
    
    init(name: String, meals: [Meal], order: Int) {
        self.name = name
        self.meals = meals
        self.order = order
    }
}

// New data model for the Meal (to store meal details like type and associated recipe)
@Model
class Meal {
    var type: String //breakfast, lunch, dinner
    var recipe: Recipe
    
    init(type: String, recipe: Recipe) {
        self.type = type
        self.recipe = recipe
    }
}

//New data model for user's MealPlan(stores meals for each day of week)
@Model
class MealPlan {
    var days: [Day]
    
    init() {
        self.days = [
            Day(name: "Monday", meals: [], order: 1),
            Day(name: "Tuesday", meals: [], order: 2),
            Day(name: "Wednesday", meals: [], order: 3),
            Day(name: "Thursday", meals: [], order: 4),
            Day(name: "Friday", meals: [], order: 5),
            Day(name: "Saturday", meals: [], order: 6),
            Day(name: "Sunday", meals: [], order: 7)
        ]
    }
}
