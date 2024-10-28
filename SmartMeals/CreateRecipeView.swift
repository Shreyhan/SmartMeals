//
//  CreateRecipeView.swift
//  SmartMeals
//
//  Created by Shravani on 10/27/24.
//

import SwiftUI

struct CreateRecipeView: View {
    @State private var recipeName: String = ""
    @State private var ingredients: String = ""
    @State private var steps: String = ""
    @State private var prepTime: String = ""
    @State private var servings: String = ""
    @State private var image: UIImage?
    var body: some View {
        ScrollView {
            //create stack for each of the properties of recipe
            VStack(alignment: .leading, spacing: 20) {
                Text("Create Recipe")
                    .font(.largeTitle)
                    .padding(.bottom)
                    .fontWeight(.bold)
                //enter recipe name
                Text("Recipe Name")
                    .font(.headline)
                //updates recipeName variable automatically using user input
                //$ creates binding to recipeName state variable
                TextField("Enter recipe name", text: $recipeName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom)
                
                //enter ingredients
                Text("Ingredients")
                    .font(.headline)
                TextEditor(text: $ingredients)
                    .frame(height: 100)
                    .border(Color.gray, width: 1)
                    .padding(.bottom)
                
                //enter steps
                Text("Steps")
                    .font(.headline)
                TextEditor(text: $steps)
                    .frame(height: 100)
                    .border(Color.gray, width: 1)
                    .padding(.bottom)
                
                //enter prep time
                Text("Prep Time(whole number)")
                    .font(.headline)
                TextField("Enter preparation time", text: $prepTime)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom)
                
                //enter servings
                Text("Servings(whole number)")
                    .font(.headline)
                TextField("Enter number of servings", text: $servings)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom)
                
                //upload image
                Text("Upload Image")
                    .font(.headline)
                
                Button(action: {
                    print("Image upload")
                }) {
                    Text("Select Image")
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
            }
            .padding(.bottom)
        }
        }
        .padding()
    }
}

#Preview {
    CreateRecipeView()
}
