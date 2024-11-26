//
//  AddRecipeView.swift
//  SmartMeals
//
//  Created by Shravani on 10/27/24.
//

import SwiftUI
import SwiftData

struct AddRecipeView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
//    @Binding var user: User
    @State private var recipeName: String = ""
    @State private var image: UIImage?
    @State private var day: String = "Monday"
    @State private var mealType: String = "Breakfast"
    @Query private var plan: [MealPlan]
    //array for days dropdown
    let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    //array for mealTypes dropdown
    let mealTypes = ["Breakfast", "Lunch", "Dinner"]
    var recipe: Recipe
    
//    var sampleMeal = Meal(type: "Breakfast", name: "Pancakes", imageName: "Pancake Image")
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20){
                HStack {
                    //recipe icon/image
    //                if let imageName = .imageName, let uiImage = UIImage(named: imageName) {
    //                    Image(uiImage: uiImage)
    //                        .resizable()
    //                        .scaledToFit()
    //                        .frame(height: 50)
    //                        .cornerRadius(10)
    //                }
    //                //if no image saved for recipe
    //                else {
    //                    Text("No image available")
    //                        .foregroundColor(.gray)
    //                }
                    //recipe name
                    Text(recipe.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                
                // Spacer to push dropdowns to middle of screen
                Spacer()
                
                HStack {
                    Text("Select Day")
                        .font(.headline)
                    Picker("Select a Day", selection: $day) {
                        ForEach(days, id: \.self) { day in
                            Text(day).tag(day)
                        }
                    }
                }
                .padding(.bottom)
                .font(.system(size: 18))
                .frame(height: 50)
                
                HStack {
                    Text("Select Meal Type")
                        .font(.headline)
                    Picker("Select a Day", selection: $mealType) {
                        ForEach(mealTypes, id: \.self) { day in
                            Text(day).tag(day)
                        }
                    }
                }
                .padding(.bottom)
                .font(.system(size: 18))
                .frame(height: 50)
                
                // Spacer to push buttons to the bottom
                Spacer()

                // Buttons at the bottom
                HStack {
                    Button(action: {
                       dismiss()
                    }) {
                        Text("Cancel")
                            .frame(maxWidth: .infinity)
                            .frame(height: 20)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding([.leading, .trailing], 10)
                    }
                    
                    // Space between buttons
                    Spacer()
                    
                    Button(action: {
                        saveMeal()
                        dismiss()
                    }) {
                        Text("Add to Plan")
                            .frame(maxWidth: .infinity)
                            .frame(height: 20)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding([.leading, .trailing], 10)
                    }

                }
                
            }
            .padding()
        }
        .navigationBarHidden(true)
        
    }
    
    private func saveMeal() {
        let mealPlan = plan.first!
        let newMeal = Meal(type: mealType, recipe: recipe)
        // Find the index of the day to update
        if let dayIndex = mealPlan.days.firstIndex(where: { $0.name == day }) {
            if let mealIndex = mealPlan.days[dayIndex].meals.firstIndex(where: { $0.type == mealType}) {
                mealPlan.days[dayIndex].meals[mealIndex] = newMeal
            } else {
                mealPlan.days[dayIndex].meals.append(newMeal)
            }
        } else {
            print("Invalid day selected")
        }
        
        // Save to persistent store
        do {
            try context.save()
        } catch {
            print("Failed to save meal: \(error.localizedDescription)")
        }
    }
}

#Preview {
    AddRecipeView(recipe: Recipe(name: "Pasta", ingredients: ["Ingredient 1", "Ingredient 2", "Ingredient 3"], instructions: ["Step one", "Step two", "Step three"], time: "10 min"))
}
