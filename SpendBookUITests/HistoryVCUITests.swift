//
//  HistoryVCUITests.swift
//  SpendBookUITests
//
//  Created by Tomasz Jaeschke on 07/01/2021.
//  Copyright © 2021 Tomasz Jaeschke. All rights reserved.
//

import XCTest

class HistoryVCUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSummaryValueOfHistoryTransaction() throws {

        let app = XCUIApplication()
        app.tabBars["Tab Bar"].buttons["History"].tap()
        app.textFields["From date"].tap()
        app.datePickers.pickerWheels["2021"].adjust(toPickerWheelValue: "2019")
        app.tables.cells.firstMatch.tap()
        
        print("Number of cell \(app.tables.cells.allElementsBoundByIndex.count)")
        
        let tableCells = app.tables.cells.allElementsBoundByIndex
        var summaryValueOfCell: Int = 0
        
        for cell in tableCells {
            var cellValue = cell.staticTexts["History value of transaction"].label
            cellValue.remove(at: cellValue.startIndex)
            summaryValueOfCell += Int(cellValue)!
        }
        
        var summaryOfHistoryTransaction = app.staticTexts["Summary of history transaction"].label
        summaryOfHistoryTransaction.remove(at: summaryOfHistoryTransaction.startIndex)
        let summaryOfHistoryTransactionInt = Int(summaryOfHistoryTransaction)!
        
        XCTAssertEqual(summaryOfHistoryTransactionInt, summaryValueOfCell)
    }
    
    func testInvalideDateRangeWarning() throws {
        
        let app = XCUIApplication()
        app.tabBars["Tab Bar"].buttons["History"].tap()
        app.textFields["To date"].tap()
        app.datePickers.pickerWheels["2021"].adjust(toPickerWheelValue: "2019")
        app.alerts["Hint"].scrollViews.otherElements.buttons["Ok"].tap()
        
        //ToDo: - Check date correction
        
    }
}
