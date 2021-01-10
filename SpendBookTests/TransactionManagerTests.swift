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

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        //Seting up dummy store
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        
        let container = NSPersistentContainer(name: "SpendBook")
        
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
        
    
        for _ in 1...testNumberOfTransaction {
            let transaction = Transaction(context: managedContext)
            
            //Feel entity with data
            transaction.type = "Other"
            transaction.value = Int32.random(in: 0...9999)
            transaction.sign = "+"
            
            transaction.day = Int16(calendar.component(.day, from: date))
            transaction.month = Int16(calendar.component(.month, from: date))
            transaction.year = Int16(calendar.component(.year, from: date))
            transaction.hour = Int16(calendar.component(.hour, from: date))
            transaction.minute = Int16(calendar.component(.minute, from: date))
            
            formater.dateFormat = "yyyy-MM-dd HH:mm"
            
            transaction.date = formater.string(from: date)
                
            sampleListOfTransaction.append(transaction)
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
