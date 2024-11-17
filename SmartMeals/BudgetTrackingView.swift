//
//  BudgetTrackingView.swift
//  SmartMeals
//
//  Created by Shreyhan Lakhina on 10/27/24.
//

import SwiftUI
import SwiftData

struct BudgetTrackingView: View {
    @Environment(\.modelContext) private var context
    @Query private var users: [User]
    @State var totalGroceryCost: Double = 0.0
    
    
    var body: some View {
        let user = users.first!
        NavigationView {
            VStack {
                Text("Budget Tracker")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
                Text("For this week")
                    .font(.headline)
                    .fontWeight(.light)
                    .foregroundColor(.gray)
                    .padding(.bottom)
                Spacer()
                HStack {
                    Spacer()
                    Text("Remaining Budget:")
                        .font(.headline)
                    Spacer()
                    Text(String(format: "$%.2f", user.budget-totalGroceryCost))
                        .font(.headline)
                        .padding()
                        .background(user.budget-totalGroceryCost > 0 ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
                        .cornerRadius(10)
                    Spacer()
                }
                .padding(10)
                
                HStack {
                    Spacer()
                    Text("Total Grocery Cost:")
                        .font(.headline)
                    Spacer()
                    Text(String(format: "$%.2f", totalGroceryCost))
                        .font(.headline)
                        .padding()
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(10)
                    Spacer()
                }
                .padding(10)
                
                HStack {
                    Spacer()
                    Text("Money Owed per Roommate:")
                        .font(.headline)
                    Spacer()
                    Text(String(format: "$%.2f", totalGroceryCost/Double(user.numRoommates)))
                        .font(.headline)
                        .padding()
                        .background(Color.orange.opacity(0.2))
                        .cornerRadius(10)
                    Spacer()
                }
                .padding(10)

                
                Spacer()
                Spacer()
            }
        }
        .onAppear {
            calculateTotalGroceryCost(for: user)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func calculateTotalGroceryCost(for user: User) {
            var totalCost = 0.0
            for item in user.groceryList {
                totalCost += item.price * Double(item.quantity)
            }
            totalGroceryCost = totalCost
        }
}

#Preview {
//    BudgetTrackingView(user: UserProfile(firstName: "Lisa", lastName: "White", picture: "lisa_white", numRoommates: 4, budget: 100, groceryList: [GroceryItem(name: "Tomatoes", imageName: "pasta_icon", price: 0.50, quantity: 7, isChecked: false), GroceryItem(name: "Pickles", imageName: "image_here", price: 1.00, quantity: 7, isChecked: true)], vegan: true, vegetarian: false, glutenFree: false, nutAllergy: false))
    BudgetTrackingView()
}

