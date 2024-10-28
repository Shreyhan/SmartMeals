//
//  RecipeView.swift
//  SmartMeals
//
//  Created by Shreyhan Lakhina on 10/27/24.
//

import SwiftUI

struct RecipeView: View {
    var recipe: Recipe
    var body: some View {
        VStack {
            HStack {
                Image(recipe.imageName)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                Text(recipe.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            
            Text("Cook time :")
                .font(.headline)
            Text(recipe.time + "\n")
            
            
            Text("Ingredients :")
                .font(.headline)
            List {
                ForEach(recipe.ingredients, id: \.self) { ingredient in
                    Text("-  " + ingredient)
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
            }
            .listStyle(PlainListStyle())
//            .scrollContentBackground(.hidden)
            
            
            Text("Instructions :")
                .font(.headline)
            List {
                ForEach(recipe.instructions.indices, id: \.self) { index in
                    Text("\(index + 1). \(recipe.instructions[index])")
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
            }
            .listStyle(PlainListStyle())
//            .scrollContentBackground(.hidden)
            
            
            HStack {
                Button(action: {
                    // Insert action here
                }) {
                    Text("Cancel")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding([.leading, .trailing], 5)
                }

                
                Button(action: {
                    // Insert action here
                }) {
                    Text("Add to plan")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding([.leading, .trailing], 5)
                }
            }
        }
        .padding()
        .navigationTitle("Recipe View")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    RecipeView(recipe: Recipe(name: "Pasta", imageName: "pasta_icon", ingredients: ["Ingredient 1", "Ingredient 2", "Ingredient 3", "Ingredient 4", "Ingredient 5", "Ingredient 6", "Ingredient 7", "Ingredient 8", "Ingredient 9", "Ingredient 10"], instructions: ["Step one", "Step two", "Step three", "Step three", "Step four", "Step five", "Step six", "Step seven", "Step eight", "Step nine", "Step ten"], time: "10 min"))
}
