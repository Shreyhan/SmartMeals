//
//  MealPlanUITests.swift
//  SmartMeals
//
//  Created by Shravani on 12/4/24.
//

import XCTest

final class MealPlanUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testWeeklyMealPlanViewElements() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Verify main title exists
        let title = app.staticTexts["Weekly Meal Plan"]
        XCTAssertTrue(title.exists, "Weekly Meal Plan title should exist")
        
        // Verify Reset button exists
        let resetButton = app.buttons["Reset Meal Plan"]
        XCTAssertTrue(resetButton.exists, "Reset Meal Plan button should exist")
    }
    
    func testModifyButtonNavigation() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Navigate to first day's modify button
        let modifyButton = app.buttons["Modify"].firstMatch
        XCTAssertTrue(modifyButton.exists, "Modify button should exist")
        
        // Tap modify button
        modifyButton.tap()
        
        // Verify navigation to EditMealPlanView
        let searchField = app.textFields["Search for a specific recipe"]
        XCTAssertTrue(searchField.exists, "Should navigate to EditMealPlanView with search field")
    }
    
    func testResetMealPlanFunctionality() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Tap reset button
        let resetButton = app.buttons["Reset Meal Plan"]
        XCTAssertTrue(resetButton.exists, "Reset Meal Plan button should exist")
        resetButton.tap()
        
        // Wait briefly for the UI to update
        sleep(1)
        
        // Check that each day has no meals listed
        let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
        
        for day in days {
            let dayText = app.staticTexts[day]
            XCTAssertTrue(dayText.exists, "\(day) label should still exist after reset")
            
            // Verify no meal types are shown for this day
            let mealTypes = ["Breakfast:", "Lunch:", "Dinner:"]
            for mealType in mealTypes {
                let mealTypeExists = app.staticTexts.containing(NSPredicate(format: "label CONTAINS %@", mealType)).element.exists
                XCTAssertFalse(mealTypeExists, "Meal \(mealType) should not exist after reset for \(day)")
            }
        }
    }
    
    func testWeeklyMealPlanScrolling() throws {
        let app = XCUIApplication()
        app.launch()
        
        let scrollView = app.scrollViews.firstMatch
        
        // Scroll to bottom
        scrollView.swipeUp()
        
        // Verify last day is visible
        let sunday = app.staticTexts["Sunday"]
        XCTAssertTrue(sunday.exists, "Should be able to scroll to Sunday")
        
        // Scroll back to top
        scrollView.swipeDown()
        
        // Verify first day is visible
        let monday = app.staticTexts["Monday"]
        XCTAssertTrue(monday.exists, "Should be able to scroll back to Monday")
    }
    
}

//    func addtoWeeklyMealPlanToggles() throws {
//        let app = XCUIApplication()
//        app.launch()
//        app.tabBars["Tab Bar"].buttons["Meal Plan"].tap()
//        app.scrollViews.otherElements.containing(.staticText, identifier:"Weekly Meal Plan").children(matching: .button).matching(identifier: "Modify").element(boundBy: 0).tap()
//        app.collectionViews.children(matching: .cell).element(boundBy: 0).buttons["Gluten-Free Pancakes"].tap()
//        app.buttons["Add to Plan"].tap()
//    }


