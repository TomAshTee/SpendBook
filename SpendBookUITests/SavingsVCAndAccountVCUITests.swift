//
//  SavingsVCAndAccountVCUITests.swift
//  SpendBookUITests
//
//  Created by Tomasz Jaeschke on 10/02/2021.
//  Copyright © 2021 Tomasz Jaeschke. All rights reserved.
//

import XCTest

class SavingsVCAndAccountVCUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    var savingsSummaryBaseString: String = ""
    var savingsSummaryBaseInt: Int = 0

    //Savings summary
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        //Read a base value
//        app.launch()
//
//        savingsSummaryBaseString = app.staticTexts.element(matching: .any, identifier: "Savings summary").label
//        savingsSummaryBaseString.remove(at: savingsSummaryBaseString.startIndex)
//        savingsSummaryBaseInt = Int(savingsSummaryBaseString)!

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddNewAccount() throws {
        
        app.launch()
        app.tabBars["Tab Bar"].buttons["Savings"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Manage"]/*[[".buttons[\"Manage\"].staticTexts[\"Manage\"]",".staticTexts[\"Manage\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["+Add acct."]/*[[".buttons[\"+Add acct.\"].staticTexts[\"+Add acct.\"]",".staticTexts[\"+Add acct.\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts["Add new Account"].scrollViews.otherElements.collectionViews/*@START_MENU_TOKEN@*/.textFields["Account name"]/*[[".cells.textFields[\"Account name\"]",".textFields[\"Account name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.typeText("Test")
        app.alerts["Add new Account"].scrollViews.otherElements.buttons["Save"].tap()
    }
    
    func testAddPartToAccount() throws {
        
        app.launch()
        app.tabBars["Tab Bar"].buttons["Savings"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Manage"]/*[[".buttons[\"Manage\"].staticTexts[\"Manage\"]",".staticTexts[\"Manage\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.pickerWheels.firstMatch.adjust(toPickerWheelValue: "Test")
        app.buttons["Icon plus"].tap()
        app.alerts["Operation"].scrollViews.otherElements.collectionViews/*@START_MENU_TOKEN@*/.textFields["Operation value"]/*[[".cells.textFields[\"Operation value\"]",".textFields[\"Operation value\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.typeText("10")
        app.alerts["Operation"].scrollViews.otherElements.buttons["Add"].tap()
    }
    
    func testDeleteAccount() throws {
        
        app.launch()
        app.tabBars["Tab Bar"].buttons["Savings"].tap()
        
        let tablesQuery = XCUIApplication().tables
        tablesQuery.cells.containing(.staticText, identifier: "Test").firstMatch.swipeLeft()
        tablesQuery.buttons["DELETE"].tap()

        app.alerts["Delete"].scrollViews.otherElements.buttons["Yes"].tap()
    }
}
