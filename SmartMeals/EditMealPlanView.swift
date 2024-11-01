//
//  EditMealPlanView.swift
//  SmartMeals
//
//  Created by Shreyhan Lakhina on 10/27/24.
//

import SwiftUI

struct EditMealPlanView: View {
    @State var recipes = [Recipeee]()
    var body: some View {
        @State var search: String = ""
        NavigationView {
            VStack(spacing: 0) {
                TextField("Search for a specific recipe", text: $search)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                List(recipes, id:\.name) { recipe in
                    HStack {
                        Image(recipe.imageName)
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                        Button(action: {
                            // DO STUFF HERE
                        }) {
                            Text(recipe.name)
                                .font(.headline)
                        }
                    }
                }
                .onAppear() {
                    // get info from database
                }
                .onChange(of: search) { oldValue, newValue in
                    // insert code to edit search
                }
                Button(action: {
                    // GO TO NEW RECIPE VIEW HEREEE
                }) {
                    Text("Create New Recipe")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding([.leading, .trailing], 20)
                }
                Spacer()
            }
            .navigationTitle("Edit Meal Plan")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}



#Preview {
    EditMealPlanView(recipes: [Recipeee(name: "Pasta", imageName: "pasta_icon", ingredients: ["Ingredient 1", "Ingredient 2", "Ingredient 3"], instructions: ["Step one", "Step two", "Step three"], time: "10 min"),
                               Recipeee(name: "Pizza", imageName: "pizza_icon", ingredients: ["Ingredient 1", "Ingredient 2", "Ingredient 3"], instructions: ["Step one", "Step two", "Step three"], time: "10 min"),
                               Recipeee(name: "Chicken soup", imageName: "soup_icon", ingredients: ["Ingredient 1", "Ingredient 2", "Ingredient 3"], instructions: ["Step one", "Step two", "Step three"], time: "10 min")])
}
