//
//  GroceryListView.swift
//  SmartMeals
//
//  Created by Shreyhan Lakhina on 10/27/24.
//

import SwiftUI
import SwiftData


struct GroceryListView: View {
    @Environment(\.modelContext) private var context
    @Query private var groceryItems: [GroceryItem]
//    @State var groceryItems = [GroceryItem]()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Grocery List")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
                List {
                    ForEach(groceryItems.indices, id: \.self) { index in
                        HStack {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(groceryItems[index].name)
                                        .font(.headline)
                                        .fontWeight(.bold)
                                    Text("$ " + String(format: "%.2f", groceryItems[index].price))
                                        .font(.subheadline)
                                        .fontWeight(.light)
                                }
                                Text("Quantity: " + String(groceryItems[index].quantity))
                                    .font(.subheadline)
                                    .fontWeight(.light)
                            }
                            Spacer()
                            Button(action: {
                                groceryItems[index].isChecked.toggle()
                            }) {
                                Image(systemName: groceryItems[index].isChecked ? "checkmark.square.fill" : "square")
                                    .foregroundColor(groceryItems[index].isChecked ? .green : .gray)
                            }
                        }
                    }
//                    .onDelete { indexSet in
//                        groceryItems.remove(atOffsets: indexSet)
//                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            context.delete(groceryItems[index])
                        }
                    }
                }
                .listStyle(PlainListStyle())
                
                NavigationLink(destination: {
                    IngredientView()
                }, label: {
                    Text("Add an item")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding([.leading, .trailing], 20)
                })
            }
            .listStyle(PlainListStyle())
        }
        
    }
}

#Preview {
//    GroceryListView(groceryItems: [
////            GroceryItem(id: UUID(), name: "Tomatoes", imageName: "pasta_icon", price: 0.50, quantity: 7, isChecked: false),
////            GroceryItem(id: UUID(), name: "Pickles", imageName: "image_here", price: 1.00, quantity: 7, isChecked: true)
//        ])
    GroceryListView()
}
