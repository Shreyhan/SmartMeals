//
//  DataModel.swift
//  SmartMeals
//
//  Created by Shreyhan Lakhina on 10/30/24.
//

import Foundation
import SwiftData

@Model
class User {
    var firstName: String
    var lastName: String
    var picture: String
    var numRoommates: Int
    var budget: Double
    var groceryList: [GroceryItem]
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
        self.groceryList = []
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
