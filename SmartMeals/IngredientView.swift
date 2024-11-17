//
//  IngredientView.swift
//  SmartMeals
//
//  Created by Shravani on 10/27/24.
//

import SwiftUI

struct IngredientView: View {
    @State private var itemName: String = ""
    @State private var quantity: String = ""
    @State private var price: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Add Item")
                .font(.largeTitle)
                .padding(.bottom)
                .fontWeight(.bold)
            
                //enter item name
                Text("Item Name")
                    .font(.headline)
                //updates itemName variable automatically using user input
                //$ creates binding to itemName state variable
                TextField("Enter item name", text: $itemName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom)
            
                //enter item quantity
                Text("Quantity")
                    .font(.headline)
                //input and store quantity
                TextField("Enter quantity(whole numbers)", text: $quantity)
                    //shows numeric keypad
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom)
            
                //enter items price
                Text("Price per Item")
                    .font(.headline)
                //input and store quantity
                TextField("Enter total price(decimal)", text: $price)
                    //shows decimal keypad for price
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom)
                    
                //use to push buttons to bottom of screen
                Spacer()
                
                // Buttons at the bottom
                HStack {
                    Button(action: {
                        // Action for Go Back button
                        print("Go Back clicked")
                    }) {
                        Text("Cancel")
                            .fontWeight(.bold)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
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
    IngredientView()
}
