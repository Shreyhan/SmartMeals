//
//  EditMealPlanView.swift
//  SmartMeals
//
//  Created by Shreyhan Lakhina on 10/27/24.
//

import SwiftUI
import SwiftData

struct EditMealPlanView: View {
    //use to dismiss and return to previous view
    @Environment(\.dismiss) var dismiss
    //array of custom recipe objects
    @State var recipesold = [Recipeee]()
    //fetch recipes from SwiftData
    @Query private var recipes: [Recipe]
    //the specific day being edited
    var day: Day
    //search bar
    @State var search: String = ""
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                //text field for searching recipes
                TextField("Search for a specific recipe", text: $search)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                //list of recipes displayed from recipesold array
                List(recipesold, id:\.name) { recipe in
                    HStack {
                        //recipe image
                        Image(recipe.imageName)
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                        //navigates to RecipeView when click on recipe
                        NavigationLink(destination: RecipeView(recipe: recipe, day: day)) {
                            Text(recipe.name)
                                .font(.headline)
                        }
                        .navigationBarBackButtonHidden(true)
                    }
                }
                .onAppear() {
                    // get info from database
                }
                .onChange(of: search) { oldValue, newValue in
                    // insert code to edit search
                }
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Cancel")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding([.leading, .trailing], 20)
                    }
                }
                Spacer()
            }
            .navigationTitle("Edit Meal Plan")
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationBarBackButtonHidden(true)
    }
}



#Preview {
    EditMealPlanView(recipesold: [Recipeee(name: "Pasta", imageName: "pasta_icon", ingredients: ["Ingredient 1", "Ingredient 2", "Ingredient 3"], instructions: ["Step one", "Step two", "Step three"], time: "10 min"),
                               Recipeee(name: "Pizza", imageName: "pizza_icon", ingredients: ["Ingredient 1", "Ingredient 2", "Ingredient 3"], instructions: ["Step one", "Step two", "Step three"], time: "10 min"),
                                  Recipeee(name: "Chicken soup", imageName: "soup_icon", ingredients: ["Ingredient 1", "Ingredient 2", "Ingredient 3"], instructions: ["Step one", "Step two", "Step three"], time: "10 min")], day: Day(
                                    name: "Monday",
                                    meals: [
                                        Meal(type: "Breakfast", name: "Pancakes", imageName: "pancake_icon"),
                                        Meal(type: "Lunch", name: "Pasta"),
                                        Meal(type: "Dinner", name: "Chicken")
                                    ]
                                ))
}
