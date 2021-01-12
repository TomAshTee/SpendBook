//
//  TransactionManagerTests.swift
//  SpendBookTests
//
//  Created by Tomasz Jaeschke on 10/01/2021.
//  Copyright © 2021 Tomasz Jaeschke. All rights reserved.
//

import XCTest
import CoreData
@testable import SpendBook

class TransactionManagerTests: XCTestCase {
    
    var sampleListOfTransaction: [Transaction] = []
    let testNumberOfTransaction = 5
    var persistentStoreDescription: NSPersistentStoreDescription!
    var container: NSPersistentContainer!
    var managedContext: NSManagedObjectContext!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        //Seting up dummy store
        persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        
        container = NSPersistentContainer(name: "SpendBook")
        
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        let managedContext = container.viewContext
        
        // Setup component for Date
        var date = Date()
        let calendar = Calendar.current
        let formater = DateFormatter()
        
    
        for i in 1...testNumberOfTransaction {
            let transaction = Transaction(context: managedContext)
            
            
            
            //Feel entity with data
            transaction.type = "Other"
            transaction.value = Int32(i)
            transaction.sign = "+"
            
            transaction.day = Int16(calendar.component(.day, from: date))
            transaction.month = Int16(calendar.component(.month, from: date))
            transaction.year = Int16(calendar.component(.year, from: date))
            
            if i == testNumberOfTransaction {
                transaction.year -= 1
            }
            
            transaction.hour = Int16(calendar.component(.hour, from: date))
            transaction.minute = Int16(calendar.component(.minute, from: date))
            
            formater.dateFormat = "yyyy-MM-dd HH:mm"
            
            if i == testNumberOfTransaction {
                date = calendar.date(byAdding: .year, value: -1, to: date)!
            }
            transaction.date = formater.string(from: date)
            
            print(transaction.date)
                
            sampleListOfTransaction.append(transaction)
        }
        
        TransactionManager.instance.setList(sampleListOfTransaction)
    }

    override func tearDownWithError() throws {
        sampleListOfTransaction = []
        persistentStoreDescription = nil
        container = nil
        managedContext = nil
    }

    func testGetTransactionFromDateRange() throws {
        
        let fromDate = Date()
        let toDate = Date()
        let returnedListOfTransactions = TransactionManager.instance.getTransaction(fromDate, toDate)
        XCTAssertEqual(returnedListOfTransactions.count, 4)
    }
    
    func testGetTodayTransactionOfIndexNumberOne() throws {
        
        let returnedTransaction = TransactionManager.instance.getToday(0)
        XCTAssertEqual(returnedTransaction, sampleListOfTransaction[0])
        
    }
    
    func testGetOneFromAllTransaction() throws {
        
        let returnedTransaction = TransactionManager.instance.getFromAll(0)
        XCTAssertEqual(returnedTransaction, sampleListOfTransaction[0])
        
    }
    
    func testGetSummaryValueOfAllTransaction() throws {
        
        let returnedValue = TransactionManager.instance.getSummaryValue()
        XCTAssertEqual(returnedValue, 15)
    }
    
    func testGetMonthlyValueOfTransaction() throws {
        
        let returnedValue = TransactionManager.instance.getMonthlyValue()
        XCTAssertEqual(returnedValue, 10)
    }

    func testGetTodayValueOfTransaction() throws {
        
        let returnedValue = TransactionManager.instance.getTodayValue()
        XCTAssertEqual(returnedValue, 10)
    }
    
    func testCountTodayNumberOfTransaction() throws {
        
        let returnedValue = TransactionManager.instance.countToday()
        XCTAssertEqual(returnedValue, 4)
    }
    
    func testSetupDateForTodayTransaction() throws {
    
        sampleListOfTransaction[4].date = nil
        sampleListOfTransaction[4].day = 0
        sampleListOfTransaction[4].month = 0
        sampleListOfTransaction[4].year = 0
        sampleListOfTransaction[4].hour = 99
        sampleListOfTransaction[4].minute = 99
        
        XCTAssertNotEqual(sampleListOfTransaction[4].date, sampleListOfTransaction[3].date)
        
        TransactionManager.todayDate(sampleListOfTransaction[4])
        
        XCTAssertEqual(sampleListOfTransaction[4].date, sampleListOfTransaction[3].date)
        XCTAssertEqual(sampleListOfTransaction[4].day, sampleListOfTransaction[3].day)
        XCTAssertEqual(sampleListOfTransaction[4].month, sampleListOfTransaction[3].month)
        XCTAssertEqual(sampleListOfTransaction[4].year, sampleListOfTransaction[3].year)
        XCTAssertEqual(sampleListOfTransaction[4].hour, sampleListOfTransaction[3].hour)
        XCTAssertEqual(sampleListOfTransaction[4].minute, sampleListOfTransaction[3].minute)
    }
    
}
