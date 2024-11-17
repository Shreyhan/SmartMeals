//
//  WeeklyMealPlanView.swift
//  SmartMeals
//
//  Created by Shravani on 10/27/24.
//

import SwiftUI
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

struct WeeklyMealPlanView: View {
    //list of type Day
    var weekData: [Day]
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Weekly Meal Plan")
                        .font(.largeTitle)
                        .padding()
                        .fontWeight(.bold)
                }
                
                ForEach(weekData, id: \.name) { day in
                    VStack(alignment: .leading, spacing: 10){
                        HStack {
                            Text(day.name)
                                .font(.title2)
                                .fontWeight(.bold)
                            Spacer()
                            //create navigation link to EditMealPlan View and make day a parameter
                            NavigationLink(destination: EditMealPlanView(day: day)) {
                                Text("Modify")
                                    .font(.caption)
                                    .padding(5)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(5)
                            }
                        }
                        //adds first meal for each type for each day
                        //$0 represents each meal in array
                        //if no meal for that type, empty string
                        HStack {
                            Image(day.meals.first(where: { $0.type == "Breakfast" })?.imageName ?? "image") // Use a placeholder if no image exists
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            Text("Breakfast: \(day.meals.first(where: { $0.type == "Breakfast" })?.name ?? "")")
                                .padding(.vertical, 2)
                        }
                        HStack {
                            Image(day.meals.first(where: { $0.type == "Lunch" })?.imageName ?? "image") // Use a placeholder if no image exists
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            Text("Lunch: \(day.meals.first(where: { $0.type == "Lunch" })?.name ?? "")")
                                .padding(.vertical, 2)
                        }
                        HStack {
                            Image(day.meals.first(where: { $0.type == "Dinner" })?.imageName ?? "image") // Use a placeholder if no image exists
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            Text("Dinner: \(day.meals.first(where: { $0.type == "Dinner" })?.name ?? "")")
                                .padding(.vertical, 2)
                        }
                        Divider()
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                }
            }
                .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    WeeklyMealPlanView(weekData: sampleWeekData)
}
