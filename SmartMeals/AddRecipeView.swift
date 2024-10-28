//
//  AddRecipeView.swift
//  SmartMeals
//
//  Created by Shravani on 10/27/24.
//

import SwiftUI

struct AddRecipeView: View {
    @State private var recipeName: String = ""
    @State private var image: UIImage?
    @State private var day: String = "Monday"
    @State private var mealType: String = "Breakfast"
    //array for days dropdown
    let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    //array for mealTypes dropdown
    let mealTypes = ["Breakfast", "Lunch", "Dinner"]
    
    var sampleMeal = Meal(type: "Breakfast", name: "Pancakes", imageName: "Pancake Image")
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            HStack {
                //recipe icon/image
                if let imageName = sampleMeal.imageName, let uiImage = UIImage(named: imageName) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                        .cornerRadius(10)
                }
                //if no image saved for recipe
                else {
                    Text("No image available")
                        .foregroundColor(.gray)
                }
                //recipe name
                Text(sampleMeal.name)
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
                    // Action for Go Back button
                    print("Go Back clicked")
                }) {
                    Text("Go Back")
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(10)
                }
                .buttonStyle(PlainButtonStyle())
                
                // Space between buttons
                Spacer()

                Button(action: {
                    // Action for Add button
                    print("Add tapped")
                }) {
                    Text("Add")
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .buttonStyle(PlainButtonStyle())
            }
            
        }
        .padding()
    }
}

#Preview {
    AddRecipeView()
}
