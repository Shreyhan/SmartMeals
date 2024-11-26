//
//  WeeklyMealPlanView.swift
//  SmartMeals
//
//  Created by Shravani on 10/27/24.
//

import SwiftUI
import SwiftData
//let sampleWeekData: [Day] = [
//    Day(
//        name: "Monday",
//        meals: [
//            Meal(type: "Breakfast", name: "Pancakes", imageName: "Pancake Image"),
//            Meal(type: "Lunch", name: "Pasta"),
//            Meal(type: "Dinner", name: "Chicken")
//        ]),
//    Day(name: "Tuesday", meals: [
//        Meal(type: "Breakfast", name: "Pancakes", imageName: "Pancake Image"),
//        Meal(type: "Lunch", name: "Pasta"),
//        Meal(type: "Dinner", name: "Chicken")
//    ]),
//    Day(name: "Wednesday", meals : [
//        Meal(type: "Breakfast", name: "Pancakes", imageName: "Pancake Image"),
//        Meal(type: "Lunch", name: "Pasta"),
//        Meal(type: "Dinner", name: "Chicken")
//    ]),
//    Day(name: "Thursday", meals : [
//        Meal(type: "Breakfast", name: "Pancakes", imageName: "Pancake Image"),
//        Meal(type: "Lunch", name: "Pasta"),
//        Meal(type: "Dinner", name: "Chicken")
//    ]),
//    Day(name: "Friday", meals : [
//        Meal(type: "Breakfast", name: "Pancakes", imageName: "Pancake Image"),
//        Meal(type: "Lunch", name: "Pasta"),
//        Meal(type: "Dinner", name: "Chicken")
//    ]),
//    Day(name: "Saturday", meals : [
//        Meal(type: "Breakfast", name: "Pancakes", imageName: "Pancake Image"),
//        Meal(type: "Lunch", name: "Pasta"),
//        Meal(type: "Dinner", name: "Chicken")
//    ]),
//    Day(name: "Sunday", meals : [
//        Meal(type: "Breakfast", name: "Pancakes", imageName: "Pancake Image"),
//        Meal(type: "Lunch", name: "Pasta"),
//        Meal(type: "Dinner", name: "Chicken")
//    ])
//];

struct WeeklyMealPlanView: View {
    //use to track changes in User model
    @Query private var users: [User]
    @Query private var plan: [MealPlan]
    @Query private var recipes: [Recipe]
    @Environment(\.modelContext) private var context
  
//    @EnvironmentObject var user: User
  
    //list of type Day
    //var weekData: [Day]
    var body: some View {
        //let first: User = users.first!
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Weekly Meal Plan")
                        .font(.largeTitle)
                        .padding()
                        .fontWeight(.bold)
                }
                //for each day in meal plan, display recipes for each meal time
                ForEach(plan.first!.days.sorted(by: { $0.order < $1.order }), id: \.name) { day in
                    VStack(alignment: .leading, spacing: 10){
                        HStack {
                            Text(day.name)
                                .font(.title2)
                                .fontWeight(.bold)
                            Spacer()
                            //create navigation link to EditMealPlan View and make day a parameter
                            NavigationLink(destination: {
                                EditMealPlanView()
                            }, label: {
                                Text("Modify")
                                    .font(.caption)
                                    .padding(5)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(5)
                            })
                        }
                    }
                    ForEach(day.meals.sorted(by: mealSortingOrder), id: \.self) { meal in
                        HStack {
                            //load image if exists
                            if let imageData = meal.recipe.image, let uiImage = UIImage(data: imageData) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                            //ensure image fills circle
                                            .aspectRatio(contentMode: .fill)
                                            //ensures images are circular icons
//                                            .clipShape(Circle())
                                }
                            NavigationLink(destination: RecipeView(showButtons: false, recipe: meal.recipe)) {
                                Text("\(meal.type): \(meal.recipe.name)")
                                    .foregroundColor(Color.black)
                                    .padding(.vertical, 2)
                            }
//                            Text("\(meal.type): \(meal.recipe.name)")
//                                .padding(.vertical, 2)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                        
                    Divider()
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                }
            
            Button (action: {
                context.delete(plan.first!)
                let emptyPlan = MealPlan()
                context.insert(emptyPlan)
                }) {
                    Text("Reset Meal Plan")
                        .frame(maxWidth: .infinity)
                        .frame(height: 20)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding([.leading, .trailing], 20)
                }
            }
            .padding()
        }
    
    func mealSortingOrder(meal1: Meal, meal2: Meal) -> Bool {
        let order = ["Breakfast", "Lunch", "Dinner"]
        return order.firstIndex(of: meal1.type) ?? Int.max < order.firstIndex(of: meal2.type) ?? Int.max
    }
}

#Preview {
    WeeklyMealPlanView()
}
