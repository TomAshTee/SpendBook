//
//  SavingsManagerTests.swift
//  SpendBookTests
//
//  Created by Tomasz Jaeschke on 07/02/2021.
//  Copyright © 2021 Tomasz Jaeschke. All rights reserved.
//

import XCTest
import CoreData
@testable import SpendBook

class SavingsManagerTests: XCTestCase {

    var sampleListOfSavings: [Saving] = []
    let testNumberOfSavings = 5
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
        let formater = DateFormatter()
        
    
        for i in 1...testNumberOfSavings {
            let saving = Saving(context: managedContext)
            
            formater.dateFormat = "yyyy-MM-dd HH:mm"
            saving.date = formater.string(from: date)
            saving.name = "Account nr.\(i)"
            saving.parts = ["1", "2", "10", "-10", "3"]
            saving.value = 5
            
            sampleListOfSavings.append(saving)
        }
        
        SavingsManager.instance.setList(sampleListOfSavings)
    }
    override func tearDownWithError() throws {
        sampleListOfSavings = []
        persistentStoreDescription = nil
        container = nil
        managedContext = nil
    }

    func testGetAllSavingsList() throws {
        let returnedSavings = SavingsManager.instance.getAllSavings()
        XCTAssertEqual(returnedSavings, sampleListOfSavings)
    }
    
    func testCountAllAccountNumber() throws {
        let returnedNumberOfAccount = SavingsManager.instance.countAccount()
        XCTAssertEqual(returnedNumberOfAccount, 5)
    }
    
    func testGetAccountNameList() throws {
        let returnedAccoundNameList = SavingsManager.instance.getAccountNameList()
        XCTAssertEqual(returnedAccoundNameList.count, 5)
        
        var i = 1
        for account in returnedAccoundNameList {
            XCTAssertEqual(account, "Account nr.\(i)")
            i += 1
        }
    }
}
