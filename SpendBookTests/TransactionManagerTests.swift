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
        let date = Date()
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
            
            transaction.date = formater.string(from: date)
            
            print(transaction.year)
                
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
        XCTAssertEqual(returnedListOfTransactions, sampleListOfTransaction)
    }
    
    func testGetTodayTransactionOfIndexNumberOne() throws {
        
        let returnedTransaction = TransactionManager.instance.getToday(1)
        XCTAssertEqual(returnedTransaction, sampleListOfTransaction[1])
        
    }
    
    func testGetOneFromAllTransaction() throws {
        
        let returnedTransaction = TransactionManager.instance.getFromAll(1)
        XCTAssertEqual(returnedTransaction, sampleListOfTransaction[1])
        
    }
    
    func testGetSummaryValueOfAllTransaction() throws {
        
        let returnedValue = TransactionManager.instance.getSummaryValue()
        XCTAssertEqual(returnedValue, 15)
    }
    
    
}
