//
//  EditMealPlanView.swift
//  SmartMeals
//
//  Created by Shreyhan Lakhina on 10/27/24.
//

import SwiftUI
import SwiftData

struct EditMealPlanView: View {
    @Environment(\.modelContext) private var context
    //use to dismiss and return to previous view
    @Environment(\.dismiss) var dismiss
    //array of custom recipe objects
//    @State var recipesold = [Recipeee]()
    //fetch recipes from SwiftData
    @Query private var recipes: [Recipe]
    @Query private var users: [User]
    private var user: User { users.first! }
    //the specific day being edited
//    var day: Day
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
                List {
                    ForEach(recipes.filter { recipe in
                        (search.isEmpty || recipe.name.localizedCaseInsensitiveContains(search)) &&
                        (user.vegan ? recipe.dietaryRestrictions[0] : true) &&
                        (user.vegetarian ? (recipe.dietaryRestrictions[1] || recipe.dietaryRestrictions[0]) : true) &&
                        (user.glutenFree ? recipe.dietaryRestrictions[2] : true) &&
                        (user.nutAllergy ? recipe.dietaryRestrictions[3] : true)
                    }, id: \.name) { recipe in
                        HStack {
                            if let imageData = recipe.image, let uiImage = UIImage(data: imageData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .shadow(radius: 5)
                            }
                            //navigates to RecipeView when click on recipe
                            NavigationLink(destination: {
                                RecipeView(showButtons: true, recipe: recipe)
                            }, label: {
                                Text(recipe.name)
                                    .font(.headline)
                            })
                        }
                    }
                    .onDelete { offsets in
                        for index in offsets {
                            let recipe = recipes[index]
                            context.delete(recipe)
                            do {
                                try context.save()
                            } catch {
                                print("Failed to delete recipe: \(error)")
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
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

                    NavigationLink(destination: {
                        CreateRecipeView()
                    }, label: {
                        Text("Create Recipe")
                            .frame(maxWidth: .infinity)
                            .frame(height: 20)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding([.leading, .trailing], 10)
                    }).id(UUID())
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
//    EditMealPlanView(recipesold: [Recipeee(name: "Pasta", imageName: "pasta_icon", ingredients: ["Ingredient 1", "Ingredient 2", "Ingredient 3"], instructions: ["Step one", "Step two", "Step three"], time: "10 min"),
//                               Recipeee(name: "Pizza", imageName: "pizza_icon", ingredients: ["Ingredient 1", "Ingredient 2", "Ingredient 3"], instructions: ["Step one", "Step two", "Step three"], time: "10 min"),
//                                  Recipeee(name: "Chicken soup", imageName: "soup_icon", ingredients: ["Ingredient 1", "Ingredient 2", "Ingredient 3"], instructions: ["Step one", "Step two", "Step three"], time: "10 min")], day: Day(
//                                    name: "Monday",
//                                    meals: [
//                                        Meal(type: "Breakfast", name: "Pancakes", imageName: "pancake_icon"),
//                                        Meal(type: "Lunch", name: "Pasta"),
//                                        Meal(type: "Dinner", name: "Chicken")
//                                    ]
//                                ))
    EditMealPlanView()
}
