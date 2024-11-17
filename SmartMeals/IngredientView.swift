//
//  IngredientView.swift
//  SmartMeals
//
//  Created by Shravani on 10/27/24.
//

import SwiftUI

struct IngredientView: View {
    @State private var itemName: String = ""
    @State private var quantity: Int = 1
    @State private var price: Double = 0.1
    @FocusState private var priceFocused: Bool
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Add Item")
                    .font(.largeTitle)
                    .padding(.bottom)
                    .fontWeight(.bold)
                
                VStack {
                    HStack {
                        //enter item name
                        Text("Item Name")
                            .font(.headline)
                        Spacer()
                        //updates itemName variable automatically using user input
                        //$ creates binding to itemName state variable
                        TextField("Enter item name", text: $itemName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.bottom)
                    }
                    HStack {
                        Text("Quantity")
                            .font(.headline)
                        Spacer()
                        Stepper(value: $quantity, in: 1...200) {
                            Text(String(quantity))
                        }
                    }
                    HStack {
                        var newPrice: Double = price
                        Text("Price per item:")
                            .font(.headline)
                        Spacer()
                        TextField("Budget", value: Binding(
                            get: { price },
                            set: { newPrice = $0 }),
                            format: .currency(code: "USD")
                        )
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                        .frame(width: 100)
                        .submitLabel(.done)
                        .focused($priceFocused)
                        Button(action: {
                            priceFocused = false
                            price = newPrice
                        }) {
                            Text("\u{2713}")
                        }
                    }
                }
                .padding()
                        
                    //use to push buttons to bottom of screen
                    Spacer()
                    
                    // Buttons at the bottom
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
                        // INSERT CODE TO ADD ITEM TO GROCERY LIST VIEW HERE
                        dismiss()
                    }) {
                        Text("Add to list")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding([.leading, .trailing], 15)
                    }
                }
                }
                .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    IngredientView()
}
