//
//  SpendBookUITests.swift
//  SpendBookUITests
//
//  Created by Tomasz Jaeschke on 03/01/2021.
//  Copyright © 2021 Tomasz Jaeschke. All rights reserved.
//

import XCTest

class MainVCAndAddTransactionVCUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddAndDeleteCosts() throws {
        
        app.launch()
        
        //Read a base value
        var dailyBalnaceBaseString = app.staticTexts.element(matching: .any, identifier: "Daily balance").label
        dailyBalnaceBaseString.remove(at: dailyBalnaceBaseString.startIndex)
        let dailyBalanceBaseInt = Int(dailyBalnaceBaseString)!
        
        var totalBalanceBaseString = app.staticTexts.element(matching: .any, identifier: "Total balance").label
        totalBalanceBaseString.remove(at: totalBalanceBaseString.startIndex)
        let totalBalanceBaseInt = Int(totalBalanceBaseString)!
        
        var monthlyBalanceBaseString = app.staticTexts.element(matching: .any, identifier: "Monthly balance").label
        monthlyBalanceBaseString.remove(at: monthlyBalanceBaseString.startIndex)
        let monthlyBalanceBaseInt = Int(monthlyBalanceBaseString)!
        
        //Add trensaction
        app.buttons["Icon minus"].tap()
        app/*@START_MENU_TOKEN@*/.pickerWheels["Car"]/*[[".pickers.pickerWheels[\"Car\"]",".pickerWheels[\"Car\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.adjust(toPickerWheelValue: "Food")
        app.textFields["Value of Food"].tap()
        let key = app/*@START_MENU_TOKEN@*/.keys["2"]/*[[".keyboards.keys[\"2\"]",".keys[\"2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key.tap()

        let key2 = app/*@START_MENU_TOKEN@*/.keys["5"]/*[[".keyboards.keys[\"5\"]",".keys[\"5\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key2.tap()

        let key3 = app.keys["7"]
        key3.tap()
        app.buttons["Set transaction"].tap()
        app.tables.cells.containing(.staticText, identifier:"$-257").staticTexts["Food"].firstMatch.tap()

        //Check current changes
        var dailyBalanceString = app.staticTexts.element(matching: .any, identifier: "Daily balance").label
        dailyBalanceString.remove(at: dailyBalanceString.startIndex)
        let dailyBalanceInt = Int(dailyBalanceString)!
        XCTAssertEqual((dailyBalanceInt - dailyBalanceBaseInt), -257)
        
        //Delete transaction
        let tablesQuery = XCUIApplication().tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["$-257"]/*[[".cells.staticTexts[\"$-257\"]",".staticTexts[\"$-257\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch.swipeLeft()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["DELETE"]/*[[".cells.buttons[\"DELETE\"]",".buttons[\"DELETE\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        
    }

    func testAddAndDeleteIncomes() throws {
        
        let app = XCUIApplication()
        app.launch()
        app.buttons["Icon plus"].tap()
        app/*@START_MENU_TOKEN@*/.pickerWheels["Car"]/*[[".pickers.pickerWheels[\"Car\"]",".pickerWheels[\"Car\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.adjust(toPickerWheelValue: "Income")
        app.textFields["Value of Income"].tap()
        
        let key = app/*@START_MENU_TOKEN@*/.keys["1"]/*[[".keyboards.keys[\"1\"]",".keys[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key.tap()
        
        let key2 = app/*@START_MENU_TOKEN@*/.keys["8"]/*[[".keyboards.keys[\"8\"]",".keys[\"8\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key2.tap()
        
        let key3 = app/*@START_MENU_TOKEN@*/.keys["9"]/*[[".keyboards.keys[\"9\"]",".keys[\"9\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key3.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Set transaction"]/*[[".buttons[\"Set transaction\"].staticTexts[\"Set transaction\"]",".staticTexts[\"Set transaction\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables.cells.containing(.staticText, identifier:"$189").staticTexts["Income"].firstMatch.tap()
        
        let tablesQuery = XCUIApplication().tables
        tablesQuery.staticTexts["$189"].firstMatch.swipeLeft()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["DELETE"]/*[[".cells.buttons[\"DELETE\"]",".buttons[\"DELETE\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
