//
//  GroceryListUITests.swift
//  SmartMealsUITests
//
//  Created by Shreyhan Lakhina on 12/4/24.
//

import XCTest

final class GroceryListUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-reset")
        app.launch()
        
        // Navigate to Grocery List view
        if !app.staticTexts["Grocery List"].exists {
            app.buttons["Grocery List"].tap()
        }
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func testAddNewItemToGroceryList() throws {
        // Navigate to Add Item screen
        app.buttons["Add an item"].tap()
        
        // Input item details
        let itemNameTextField = app.textFields["Enter item name"]
        itemNameTextField.tap()
        itemNameTextField.typeText("Tomatoes")
        
        let priceTextField = app.textFields["Budget"]
        priceTextField.tap()
        priceTextField.typeText("1.50")
        
        let quantityStepper = app.steppers.element(boundBy: 0)
        quantityStepper.buttons["Increment"].tap()
        quantityStepper.buttons["Increment"].tap()
        
        // Tap on Add to list
        app.buttons["Add to list"].tap()
        
        // Verify if the item was added
        let addedItem = app.staticTexts["Tomatoes"]
        XCTAssertTrue(addedItem.exists, "The item should be added to the grocery list.")
    }
    
    func testClearGroceryList() throws {
        // Add an item first
        try testAddNewItemToGroceryList()
        
        // Clear the list
        app.buttons["Clear list"].tap()
        
        // Verify that the list is empty
        let addedItem = app.staticTexts["Tomatoes"]
        XCTAssertFalse(addedItem.exists, "The grocery list should be empty.")
    }
    
    func testMarkItemAsChecked() throws {
        // Add an item first
        try testAddNewItemToGroceryList()
        
        // Mark item as checked
        let checkmarkButton = app.buttons.matching(identifier: "square").firstMatch
        checkmarkButton.tap()
        
        // Verify that the item is marked as checked
        let checkedItem = app.buttons["checkmark.square.fill"]
        XCTAssertTrue(checkedItem.exists, "The item should be marked as checked.")
    }

}
