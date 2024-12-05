# SmartMeals

**Version 1.0**  
**Developers**: Shreyhan Lakhina & Shravani Suram  
**Date**: December 2024

---

## Overview

SmartMeals is an iOS application designed to help users simplify weekly meal planning, generate grocery lists, and track food expenses. This is particularly useful for college students or individuals living in shared environments, where managing dietary restrictions and budgets can be challenging. SmartMeals provides an all-in-one solution for weekly meal planning, grocery cost splitting.

### Features

- **User Profile Management**: Allows users to set up profiles, manage dietary preferences, budget constraints, and food inventory.
- **Weekly Meal Planning**: Enables users to create and customize meal plans by adding recipes to specific days and mealtimes. Users can filter based on dietary restrictions.
- **Grocery List Generation**: Automatically generates grocery lists based on the selected meals for the week, including quantities and price estimates.
- **Budget Tracking and Cost Splitting**: Helps track grocery expenses and split costs among roommates, with built-in reminders for cost-sharing.

## Getting Started

### Requirements

- **Operating System**: iOS 18 or later
- **Development Frameworks**: SwiftUI, SwiftData
- **Running the app through XCode**: To run this app in an iOS simulator, you must have an apple developer account so you can use apple sign in.

### Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/SmartMeals/SmartMealsApp.git
   ```
2. Open the project in Xcode.
3. Build and run the application using a compatible iOS simulator or device.

### User Flow

1. **User Sign-up/Login**: Users can sign in using their Apple ID to create a unique profile.
2. **Setting Preferences**: Set dietary restrictions, budget, and roommate details during the initial setup.
3. **Meal Planning**: Use the "Weekly Meal Plan" tab to add recipes for each day of the week.
4. **Grocery List**: Create a grocery list based on your meal plan by manually adding/removing items.
5. **Budget Tracking**: Track your grocery spending and split costs among roommates via the "Budget Tracking" tab.

## Testing
Since testing this code requires a user to exist, before running any tests the code creating the user must exist in the content view
Please add the following code under `.onAppear` in the ContentView.
```sh
      let user = User(firstName: "firstName", lastName: "lastName")
      context.insert(user)
```

## Architecture

- **Client-Side Architecture**: The SmartMeals app uses a client-side architecture with an iOS-based frontend developed using SwiftUI and SwiftData for local data management.
- **SwiftData for Local Storage**: SwiftData is used to store user profiles, grocery lists, and meal plans, ensuring data privacy and offline availability, without any external server communication.

## Contributors

- Shreyhan Lakhina (Lead Developer)
- Shravani Suram (Lead Developer)

## Contact

For any questions or contributions, please email us at sxl1951@case.edu or create an issue on the GitHub repository.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

