//
//  CreateRecipeView.swift
//  SmartMeals
//
//  Created by Shravani on 10/27/24.
//

import SwiftUI
import SwiftData
import PhotosUI

struct CreateRecipeView: View {
    @Environment(\.modelContext) private var context
    @Query private var recipes: [Recipe]
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
    @State private var recipeName: String = ""
    @State private var ingredientsString: String = ""
    @State private var stepsString: String = ""
    @State private var prepTime: String = "Minute(s)"
    @State private var prepNum: Int = 1
    @State private var servings: Int = 1
    @State private var image: UIImage?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Create Recipe")
                    .font(.largeTitle)
                    .padding(.bottom)
                    .fontWeight(.bold)
                
                //enter recipe name
                VStack (alignment: .leading) {
                    Text("Recipe Name")
                        .font(.headline)
                    //updates recipeName variable automatically using user input
                    //$ creates binding to recipeName state variable
                    TextField("Enter recipe name", text: $recipeName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .border(Color.gray, width: 1)
                        .padding(.bottom)
                }
                
                //enter ingredients
                VStack (alignment: .leading) {
                    Text("Ingredients")
                        .font(.headline)
                    TextEditor(text: $ingredientsString)
                        .frame(height: 100)
                        .border(Color.gray, width: 1)
                        .padding(.bottom)
                }
                
                //enter steps
                VStack (alignment: .leading) {
                    Text("Steps")
                        .font(.headline)
                    TextEditor(text: $stepsString)
                        .frame(height: 100)
                        .border(Color.gray, width: 1)
                        .padding(.bottom)
                }
                
                HStack {
                    Text("Prep time")
                        .font(.headline)
                    Spacer()
                    Stepper(value: $prepNum, in: 1...200) {
                        Text(String(prepNum))
                    }
                    .fixedSize()
                    Picker(selection: $prepTime, label: Text("Picker")) {
                        Text("Minute(s)").tag("Minute(s)")
                        Text("Hour(s)").tag("Hour(s)")
                        Text("Day(s)").tag("Day(s)")
                    }
                    .fixedSize()
                    .pickerStyle(.automatic)
                    .tint(.black)
                }
                
                //enter servings
                HStack {
                    Text("Serving size")
                        .font(.headline)
                    Spacer()
                    Stepper(value: $servings, in: 1...10) {
                        Text(String(servings))
                    }
                    .fixedSize()
                }
                
                HStack {
                    Text("Upload Image")
                        .font(.headline)
                    Spacer()
                    PhotosPicker(
                        selection: $selectedItem,
                        matching: .images,
                        photoLibrary: .shared()) {
                            HStack {
                                Image(systemName: "photo.badge.plus")
                                Text("Select a photo")
                            }
                            .frame(minWidth: 40, maxHeight: 10)
                            .padding()
                            .background(Color.yellow)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                        }
                }
                .onChange(of: selectedItem) { oldItem, newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            selectedImageData = data
                            if let data = selectedImageData, let uiImage = UIImage(data: data) {
                                image = uiImage
                            }
                        }
                    }
                }
                
                if let image = image {
                    HStack {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .cornerRadius(10)
                            .padding(.bottom)
                        Spacer()
                    }
                }
            }
            .padding()
        }
        
        HStack {
            Button(action: {
                // CODE TO GO BACK TO CONTENT VIEW HERE!!!!
            }) {
                Text("Cancel")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding([.leading], 15)
            }
            
            Button(action: {
                let ingredients: [String] = ingredientsString.split(separator: "\n").map { String($0) }
                let steps: [String] = stepsString.split(separator: "\n").map { String($0) }
                let prep: String = String(prepNum) + " " + prepTime
                let imageData = image?.pngData() ?? Data()
                let recipe: Recipe = Recipe(name: recipeName, imageData: imageData, ingredients: ingredients, instructions: steps, time: prep)
                
                context.insert(recipe)
                do {
                    try context.save()
                } catch {
                    print("Failed to save recipe: \(error)")
                }
                print(recipes)
            }) {
                Text("Create recipe")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding([.leading, .trailing], 15)
            }
        }
    }
}

#Preview {
    CreateRecipeView()
}
