//
//  ContentView.swift
//  SmartMeals
//
//  Created by Shreyhan Lakhina on 10/23/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var users: [User]
    @Query private var currentRecipes: [Recipe]
    @Environment(\.modelContext) private var context
//    let sampleWeekData: [Day] = [
//        Day(
//            name: "Monday",
//            meals: [
//                Meal(type: "Breakfast", name: "Pancakes", imageName: "Pancake Image"),
//                Meal(type: "Lunch", name: "Pasta"),
//                Meal(type: "Dinner", name: "Chicken")
//            ]),
//        Day(name: "Tuesday", meals: [
//            Meal(type: "Breakfast", name: "Pancakes", imageName: "Pancake Image"),
//            Meal(type: "Lunch", name: "Pasta"),
//            Meal(type: "Dinner", name: "Chicken")
//        ]),
//        Day(name: "Wednesday", meals : [
//            Meal(type: "Breakfast", name: "Pancakes", imageName: "Pancake Image"),
//            Meal(type: "Lunch", name: "Pasta"),
//            Meal(type: "Dinner", name: "Chicken")
//        ]),
//        Day(name: "Thursday", meals : [
//            Meal(type: "Breakfast", name: "Pancakes", imageName: "Pancake Image"),
//            Meal(type: "Lunch", name: "Pasta"),
//            Meal(type: "Dinner", name: "Chicken")
//        ]),
//        Day(name: "Friday", meals : [
//            Meal(type: "Breakfast", name: "Pancakes", imageName: "Pancake Image"),
//            Meal(type: "Lunch", name: "Pasta"),
//            Meal(type: "Dinner", name: "Chicken")
//        ]),
//        Day(name: "Saturday", meals : [
//            Meal(type: "Breakfast", name: "Pancakes", imageName: "Pancake Image"),
//            Meal(type: "Lunch", name: "Pasta"),
//            Meal(type: "Dinner", name: "Chicken")
//        ]),
//        Day(name: "Sunday", meals : [
//            Meal(type: "Breakfast", name: "Pancakes", imageName: "Pancake Image"),
//            Meal(type: "Lunch", name: "Pasta"),
//            Meal(type: "Dinner", name: "Chicken")
//        ])
//    ];
    
    var body: some View {
        VStack {
            if let _: User = users.first {
                TabView {
                    WeeklyMealPlanView()
                        .tabItem() {
                            Image(systemName: "fork.knife")
                            Text("Meal Plan")
                        }
                    GroceryListView()
                        .tabItem() {
                            Image(systemName: "cart")
                            Text("Grocery List")
                        }
                    BudgetTrackingView()
                        .tabItem() {
                            Image(systemName: "dollarsign.square")
                            Text("Budget Tracking")
                        }
                    
                    UserProfileView()
                        .tabItem() {
                            Image(systemName: "person.fill")
                            Text("User Info")
                        }
                }
            } else {
                UserFirstLogin()
            }
        }
        .onAppear {
            // TO TEST SO THAT LOGIN SCREEN DOESNT SHOW UP WHILE TESTING!
            let user = User(firstName: "firstName", lastName: "lastName")
            context.insert(user)
            
            // pre loaded recipes only 5
            
            if currentRecipes.isEmpty {
                let recipes = [
                    Recipe(name: "Classic Margherita Pizza",
                           image: UIImage(named: "Classic-Margherita")?.pngData(),
                           ingredients: ["1 pizza dough",
                                        "1/2 cup pizza sauce",
                                        "2 cups shredded mozzarella cheese",
                                        "Fresh basil leaves",
                                         "Olive oil",
                                        ],
                           instructions: ["Preheat the oven to 475°F (245°C).",
                                          "Roll out the pizza dough and place it on a baking sheet.",
                                          "Spread the pizza sauce evenly over the dough.",
                                          "Top with mozzarella cheese and fresh basil leaves.",
                                          "Drizzle olive oil over the pizza and bake for 10-12 minutes.",
                                         ],
                           time: "15 Minute(s)",
                           servings: 2,
                           dietaryRestrictions: [false, true, false, false]),
                    Recipe(name: "Vegan Buddha Bowl",
                           image: UIImage(named: "Vegan-Buddha-Bowl")?.pngData(),
                           ingredients: ["1 cup quinoa",
                                         "1 cup roasted chickpeas",
                                         "1 avocado, sliced",
                                         "1/2 cup shredded carrots",
                                         "1/2 cup steamed broccoli",
                                         "Tahini dressing",
                                        ],
                           instructions: ["Cook quinoa according to package instructions.",
                                          "Arrange quinoa, chickpeas, avocado, carrots, and broccoli in a bowl.",
                                          "Drizzle tahini dressing on top and serve."
                                         ],
                           time: "20 Minute(s)",
                           servings: 1,
                           dietaryRestrictions: [true, true, true, false]),
                    Recipe(name: "Gluten-Free Pancakes",
                           image: UIImage(named: "Pancake")?.pngData(),
                           ingredients: ["1 cup gluten-free flour",
                                         "1 tbsp sugar",
                                         "1 tsp baking powder",
                                         "1 egg",
                                         "3/4 cup milk",
                                         "1 tbsp butter, melted",
                                        ],
                           instructions: ["In a bowl, mix the flour, sugar, and baking powder.",
                                          "Add the egg, milk, and melted butter; whisk until smooth.",
                                          "Heat a skillet and pour 1/4 cup of batter for each pancake.",
                                          "Cook until bubbles form, then flip and cook until golden.",
                                         ],
                           time: "15 Minute(s)",
                           servings: 4,
                           dietaryRestrictions: [false, false, true, false]),
                    Recipe(name: "Chicken Caesar Salad",
                           image: UIImage(named: "Chicken-Salad")?.pngData(),
                           ingredients: ["2 cups romaine lettuce, chopped",
                                         "1 grilled chicken breast, sliced",
                                         "1/4 cup Caesar dressing",
                                         "1/4 cup grated Parmesan cheese",
                                         "Croutons",
                                        ],
                           instructions: ["Arrange lettuce in a bowl.",
                                          "Top with sliced chicken, Caesar dressing, Parmesan, and croutons.",
                                          "Toss lightly before serving.",
                                         ],
                           time: "10 Minute(s)",
                           servings: 2,
                           dietaryRestrictions: [false, false, false, false]),
                    Recipe(name: "Spaghetti Aglio e Olio",
                           image: UIImage(named: "Spaghetti-Aglio-e-Olio")?.pngData(),
                           ingredients: ["200g spaghetti",
                                         "1/4 cup olive oil",
                                         "4 garlic cloves, thinly sliced",
                                         "1 tsp red pepper flakes",
                                         "2 tbsp parsley, chopped",
                                         "Parmesan cheese (optional)",
                                        ],
                           instructions: ["Cook spaghetti according to package instructions.",
                                          "Heat olive oil in a pan and sauté garlic and red pepper flakes until fragrant.",
                                          "Toss the cooked spaghetti in the pan.",
                                          "Garnish with parsley and Parmesan cheese if desired.",
                                         ],
                           time: "20 Minute(s)",
                           servings: 2,
                           dietaryRestrictions: [false, true, false, false]),
                ]
                for recipe in recipes {
                    context.insert(recipe)
                }
            }
            
            let plan = MealPlan()
            context.insert(plan)
            
            do {
                try context.save()
            } catch {
                print("Failed to delete recipe: \(error)")
            }
        }
    }
    
}

#Preview {
    ContentView()
}
