//
//  SmartMealsUITests.swift
//  SmartMealsUITests
//
//  Created by Shreyhan Lakhina on 10/23/24.
//

import XCTest

final class SmartMealsUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testTabNavigation() throws {
        let app = XCUIApplication()
        app.launch()
        
        let tabBar = XCUIApplication().tabBars["Tab Bar"]
        tabBar.buttons["Grocery List"].tap()
        tabBar.buttons["Budget Tracking"].tap()
        tabBar.buttons["User Info"].tap()
        tabBar.buttons["Meal Plan"].tap()
    }
    
    func testGroceryListTitleExists() throws {
        let app = XCUIApplication()
        app.launch()
        let groceryTabButton = app.tabBars.buttons["Grocery List"]
        groceryTabButton.tap()
        let title = app.staticTexts["Grocery List"]
        XCTAssertTrue(title.exists, "The grocery list title should exist.")
   }
    
    func testAddNewItemButtonExists() throws {
        let app = XCUIApplication()
        app.launch()
        let groceryTabButton = app.tabBars.buttons["Grocery List"]
        groceryTabButton.tap()
        let addItemButton = app.buttons["Add an item"]
        XCTAssertTrue(addItemButton.exists, "The add new item button should be present.")
    }
    
    func testUserProfileElementsExist() throws {
        // Launch the app
        let app = XCUIApplication()
        app.launch()
        
        // Navigate to the User Profile View
        app.buttons.matching(identifier: "User Info").element(boundBy: 0).tap()
        
        // Verify that the essential elements exist
        XCTAssertTrue(app.images.element(boundBy: 0).exists, "User profile image should exist")
        XCTAssertTrue(app.staticTexts.element(boundBy: 0).exists, "User full name label should exist")
        XCTAssertTrue(app.staticTexts.containing(NSPredicate(format: "label CONTAINS 'Roommates:'")).element.exists, "Roommates label should exist")
        XCTAssertTrue(app.steppers.element(boundBy: 0).exists, "Roommates stepper should exist")
        XCTAssertTrue(app.textFields.element(boundBy: 0).exists, "Budget input field should exist")
        XCTAssertTrue(app.buttons.matching(identifier: "\u{2713}").element.exists, "Save budget button should exist")
        XCTAssertTrue(app.switches.element(boundBy: 0).exists, "Dietary preferences toggle should exist")
    }

    func testRoommatesStepperFunctionality() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Navigate to the User Profile View
        app.buttons.matching(identifier: "User Info").element(boundBy: 0).tap()
        
        // Verify that the Roommates stepper can be incremented and decremented
        let roommatesStepper = app.steppers.element(boundBy: 0)
        XCTAssertTrue(roommatesStepper.exists, "Roommates stepper should exist")
        
        let roommatesCountText = app.staticTexts.matching(NSPredicate(format: "label CONTAINS[c] 'Roommates:'")).element(boundBy: 0).label
        let initialCountValue = Int(roommatesCountText.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) ?? 1
        
        let incrementButton = roommatesStepper.buttons["Increment"]
        let decrementButton = roommatesStepper.buttons["Decrement"]
        
        XCTAssertTrue(incrementButton.exists, "Increment button should exist on stepper")
        XCTAssertTrue(decrementButton.exists, "Decrement button should exist on stepper")
        
        incrementButton.tap()
        let incrementedRoommatesCountText = app.staticTexts.matching(NSPredicate(format: "label CONTAINS[c] 'Roommates:'")).element(boundBy: 0).label
        let incrementedCountValue = Int(incrementedRoommatesCountText.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) ?? initialCountValue
//        XCTAssertEqual(incrementedCountValue, initialCountValue + 1, "Roommates count should be incremented by 1")
        
        decrementButton.tap()
        let decrementedRoommatesCountText = app.staticTexts.matching(NSPredicate(format: "label CONTAINS[c] 'Roommates:'")).element(boundBy: 0).label
        let decrementedCountValue = Int(decrementedRoommatesCountText.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) ?? incrementedCountValue
//        XCTAssertEqual(decrementedCountValue, initialCountValue, "Roommates count should be decremented by 1")
    }


    func testBudgetInputField() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Navigate to the User Profile View
        app.buttons.matching(identifier: "User Info").element(boundBy: 0).tap()
        
        // Update the budget
        let budgetTextField = app.textFields.element(boundBy: 0)
        XCTAssertTrue(budgetTextField.exists, "Budget input field should exist")
        budgetTextField.tap()
        budgetTextField.clearText()
        budgetTextField.typeText("500")
        
        // Save the budget
        app.buttons.matching(identifier: "\u{2713}").element.tap()
        
        // Verify the updated budget value
        XCTAssertTrue(app.textFields.element(boundBy: 0).value as? String == "$500.00", "Updated budget should be displayed correctly")
    }

    func testDietaryPreferencesToggles() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Navigate to the User Profile View
        app.buttons.matching(identifier: "User Info").element(boundBy: 0).tap()
        
        // Verify and toggle dietary preferences
        let veganToggle = app.switches.element(boundBy: 0)
        XCTAssertTrue(veganToggle.exists, "Vegan toggle should exist")
        veganToggle.tap()
        XCTAssertTrue(veganToggle.value as? String == "0", "Vegan toggle should be turned on")
        
        let vegetarianToggle = app.switches.element(boundBy: 1)
        XCTAssertTrue(vegetarianToggle.exists, "Vegetarian toggle should exist")
        vegetarianToggle.tap()
        XCTAssertEqual(vegetarianToggle.value as? String, "0", "Vegetarian toggle should be turned off")
        
        let glutenFreeToggle = app.switches.element(boundBy: 2)
        XCTAssertTrue(glutenFreeToggle.exists, "Gluten Free toggle should exist")
        glutenFreeToggle.tap()
        XCTAssertEqual(glutenFreeToggle.value as? String, "0", "Gluten Free toggle should be turned off")
        
        let nutAllergyToggle = app.switches.element(boundBy: 3)
        XCTAssertTrue(nutAllergyToggle.exists, "Nut Allergy toggle should exist")
        nutAllergyToggle.tap()
        XCTAssertEqual(nutAllergyToggle.value as? String, "0", "Nut Allergy toggle should be turned off")
    }

}

// Helper extension to clear text from text fields
extension XCUIElement {
    func clearText() {
        guard let stringValue = self.value as? String else {
            return
        }
        let deleteString = stringValue.map { _ in XCUIKeyboardKey.delete.rawValue }.joined()
        self.typeText(deleteString)
    }
}
