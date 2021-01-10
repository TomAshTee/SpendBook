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
        
//        for i in 0...3 {
//            var transaction = Transaction(context: managedContext)
//            transaction.date = "Test"
//            sampleListOfTransaction.append(transaction)
//        }
//        for transaction in sampleListOfTransaction {
//            print("MESAGE: \(transaction.date)")
//        }
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
