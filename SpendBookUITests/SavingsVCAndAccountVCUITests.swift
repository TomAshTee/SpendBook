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
    
    var accountBalanceBaseString: String = ""
    var accountBalanceBaseInt: Int = 0

    //Savings summary
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app.launch()
        app.tabBars["Tab Bar"].buttons["Savings"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Manage"]/*[[".buttons[\"Manage\"].staticTexts[\"Manage\"]",".staticTexts[\"Manage\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["+Add acct."]/*[[".buttons[\"+Add acct.\"].staticTexts[\"+Add acct.\"]",".staticTexts[\"+Add acct.\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts["Add new Account"].scrollViews.otherElements.collectionViews/*@START_MENU_TOKEN@*/.textFields["Account name"]/*[[".cells.textFields[\"Account name\"]",".textFields[\"Account name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.typeText("Test")
        app.alerts["Add new Account"].scrollViews.otherElements.buttons["Save"].tap()
        app.buttons["Icon back"].tap()
        
        XCTAssert(app.tables.staticTexts["Test"].exists)
        
    }

    override func tearDownWithError() throws {
        app.tabBars["Tab Bar"].buttons["Savings"].tap()
        
        let tablesQuery = XCUIApplication().tables
        tablesQuery.cells.containing(.staticText, identifier: "Test").firstMatch.swipeLeft()
        tablesQuery.buttons["DELETE"].tap()

        app.alerts["Delete"].scrollViews.otherElements.buttons["Yes"].tap()
    }
    
    func testAddPlusPartToAccount() throws {
        
        app.tabBars["Tab Bar"].buttons["Savings"].tap()
        
        //Read value of SavingsBalnce
        savingsSummaryBaseString = app.staticTexts.element(matching: .any, identifier: "Savings summary").label
        savingsSummaryBaseString.remove(at: savingsSummaryBaseString.startIndex)
        savingsSummaryBaseInt = Int(savingsSummaryBaseString)!
        
        app/*@START_MENU_TOKEN@*/.staticTexts["Manage"]/*[[".buttons[\"Manage\"].staticTexts[\"Manage\"]",".staticTexts[\"Manage\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.pickerWheels.firstMatch.adjust(toPickerWheelValue: "Test")
        
        //Read value of Accountbalance
        accountBalanceBaseString = app.staticTexts.element(matching: .any, identifier: "Account balance").label
        accountBalanceBaseString.remove(at: accountBalanceBaseString.startIndex)
        accountBalanceBaseInt = Int(accountBalanceBaseString)!
        
        app.buttons["Icon plus"].tap()
        app.alerts["Operation"].scrollViews.otherElements.collectionViews/*@START_MENU_TOKEN@*/.textFields["Operation value"]/*[[".cells.textFields[\"Operation value\"]",".textFields[\"Operation value\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.typeText("21")
        app.alerts["Operation"].scrollViews.otherElements.buttons["Add"].tap()
        
        XCTAssert(app.tables.staticTexts["$21"].exists)
        
        //Check Balance value
        var accountBalanceString = app.staticTexts.element(matching: .any, identifier: "Account balance").label
        accountBalanceString.remove(at: accountBalanceString.startIndex)
        let accountBalanceInt = Int(accountBalanceString)!
        
        XCTAssertEqual((accountBalanceInt - accountBalanceBaseInt), 21)
        
        app.buttons["Icon back"].tap()
        var savingsSummaryString = app.staticTexts.element(matching: .any, identifier: "Savings summary").label
        savingsSummaryString.remove(at: savingsSummaryString.startIndex)
        let savingsSummaryInt = Int(savingsSummaryString)!
        
        XCTAssertEqual((savingsSummaryInt - savingsSummaryBaseInt), 21)
    }
    
    func testAddMinusPartToAccount() throws {
        
        app.tabBars["Tab Bar"].buttons["Savings"].tap()
        
        //Read value of SavingsBalnce
        savingsSummaryBaseString = app.staticTexts.element(matching: .any, identifier: "Savings summary").label
        savingsSummaryBaseString.remove(at: savingsSummaryBaseString.startIndex)
        savingsSummaryBaseInt = Int(savingsSummaryBaseString)!
        
        app/*@START_MENU_TOKEN@*/.staticTexts["Manage"]/*[[".buttons[\"Manage\"].staticTexts[\"Manage\"]",".staticTexts[\"Manage\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.pickerWheels.firstMatch.adjust(toPickerWheelValue: "Test")
        
        //Read value of Accountbalance
        accountBalanceBaseString = app.staticTexts.element(matching: .any, identifier: "Account balance").label
        accountBalanceBaseString.remove(at: accountBalanceBaseString.startIndex)
        accountBalanceBaseInt = Int(accountBalanceBaseString)!
        
        app.buttons["Icon minus"].tap()
        app.alerts["Operation"].scrollViews.otherElements.collectionViews/*@START_MENU_TOKEN@*/.textFields["Operation value"]/*[[".cells.textFields[\"Operation value\"]",".textFields[\"Operation value\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.typeText("20")
        app.alerts["Operation"].scrollViews.otherElements.buttons["Substract"].tap()
        
        XCTAssert(app.tables.staticTexts["$-20"].exists)
        
        //Check Balance value
        var accountBalanceString = app.staticTexts.element(matching: .any, identifier: "Account balance").label
        accountBalanceString.remove(at: accountBalanceString.startIndex)
        let accountBalanceInt = Int(accountBalanceString)!
        
        XCTAssertEqual((accountBalanceInt - accountBalanceBaseInt), -20)
        
        app.buttons["Icon back"].tap()
        var savingsSummaryString = app.staticTexts.element(matching: .any, identifier: "Savings summary").label
        savingsSummaryString.remove(at: savingsSummaryString.startIndex)
        let savingsSummaryInt = Int(savingsSummaryString)!
        
        XCTAssertEqual((savingsSummaryInt - savingsSummaryBaseInt), -20)
    }
    
}
