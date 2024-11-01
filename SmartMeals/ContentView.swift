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
    let sampleWeekData: [Day] = [
        Day(
            name: "Monday",
            meals: [
                Meal(type: "Breakfast", name: "Pancakes", imageName: "Pancake Image"),
                Meal(type: "Lunch", name: "Pasta"),
                Meal(type: "Dinner", name: "Chicken")
            ]),
        Day(name: "Tuesday", meals: [
            Meal(type: "Breakfast", name: "Pancakes", imageName: "Pancake Image"),
            Meal(type: "Lunch", name: "Pasta"),
            Meal(type: "Dinner", name: "Chicken")
        ]),
        Day(name: "Wednesday", meals : [
            Meal(type: "Breakfast", name: "Pancakes", imageName: "Pancake Image"),
            Meal(type: "Lunch", name: "Pasta"),
            Meal(type: "Dinner", name: "Chicken")
        ]),
        Day(name: "Thursday", meals : [
            Meal(type: "Breakfast", name: "Pancakes", imageName: "Pancake Image"),
            Meal(type: "Lunch", name: "Pasta"),
            Meal(type: "Dinner", name: "Chicken")
        ]),
        Day(name: "Friday", meals : [
            Meal(type: "Breakfast", name: "Pancakes", imageName: "Pancake Image"),
            Meal(type: "Lunch", name: "Pasta"),
            Meal(type: "Dinner", name: "Chicken")
        ]),
        Day(name: "Saturday", meals : [
            Meal(type: "Breakfast", name: "Pancakes", imageName: "Pancake Image"),
            Meal(type: "Lunch", name: "Pasta"),
            Meal(type: "Dinner", name: "Chicken")
        ]),
        Day(name: "Sunday", meals : [
            Meal(type: "Breakfast", name: "Pancakes", imageName: "Pancake Image"),
            Meal(type: "Lunch", name: "Pasta"),
            Meal(type: "Dinner", name: "Chicken")
        ])
    ];
    
    var body: some View {
        
        if let _: User = users.first {
            TabView {
                WeeklyMealPlanView(weekData: sampleWeekData)
                    .tabItem() {
                        Image(systemName: "fork.knife")
                        Text("Meal Plan")
                    }
                GroceryListView()
                    .tabItem() {
                        Image(systemName: "cart")
                        Text("Grocery List")
                    }
                BudgetTrackingView()
                    .tabItem() {
                        Image(systemName: "dollarsign.square")
                        Text("Budget Tracking")
                    }
                
                UserProfileView()
                    .tabItem() {
                        Image(systemName: "person.fill")
                        Text("User Info")
                    }
            }
        } else {
            UserFirstLogin()
        }
    }
}

#Preview {
    ContentView()
}
