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
    @Environment(\.dismiss) var dismiss
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
    
    @State private var isVegan: Bool = false
    @State private var isVegetarian: Bool = false
    @State private var isGlutenFree: Bool = false
    @State private var isNutFree: Bool = false
    
    var body: some View {
        NavigationView {
    
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
                    
                    // dietary preferences
                    VStack(alignment: .leading) {
                        Text("Dietary Restrictions")
                            .font(.headline)
                        Toggle("Vegan", isOn: $isVegan)
                        Toggle("Vegetarian", isOn: $isVegetarian)
                        Toggle("Gluten-Free", isOn: $isGlutenFree)
                        Toggle("Nut-Free", isOn: $isNutFree)
                    }
                    .padding(.bottom)
                    
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
                                    Text("Upload")
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
            
        }
        .navigationBarBackButtonHidden(true)
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
                    .padding([.leading], 15)
            }
            
            Button(action: {
                let ingredients: [String] = ingredientsString.split(separator: "\n").map { String($0) }
                let steps: [String] = stepsString.split(separator: "\n").map { String($0) }
                let prep: String = String(prepNum) + " " + prepTime
                let image: Data = image?.pngData() ?? UIImage(systemName: "fork.knife")!.pngData()!
                let recipe: Recipe = Recipe(name: recipeName, image: image, ingredients: ingredients, instructions: steps, time: prep, servings: servings, dietaryRestrictions: [isVegan, isVegetarian, isGlutenFree, isNutFree])
                context.insert(recipe)
                do {
                    try context.save()
                } catch {
                    print("DID NOT WEORKFailed to save recipe: \(error)")
                }
                dismiss()
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
