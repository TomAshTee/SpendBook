//
//  SavingsManager.swift
//  SpendBook
//
//  Created by Tomasz Jaeschke on 22/12/2018.
//  Copyright © 2018 Tomasz Jaeschke. All rights reserved.
//

import Foundation
import CoreData


class SavingsManager {
    
    static let instance = SavingsManager()
    
    private var _savingsList = [Saving]()
    
    public func setList(_ ofSavings: [Saving]){
        _savingsList = ofSavings
    }
    public func getAllSavings() -> [Saving] {
        return _savingsList
    }
    public func countAccount() -> Int {
        return _savingsList.count
    }
    
    public func getAccountNameList() -> [String] {
        var accountNameList: [String] = []
        for saving in _savingsList {
            guard let accountName = saving.name else {continue}
            accountNameList.append(accountName)
        }
        return accountNameList
    }
    
    public func getSummaryOfSavings() -> Int {
        var summaryOfSavings: Int32 = 0
        for saving in _savingsList {
            summaryOfSavings += saving.value
        }
        return Int(summaryOfSavings)
    }
    
    public func todayDate(_ forSaving: Saving){
        let date = Date()
        let formater = DateFormatter()
        
        formater.dateFormat = "yyyy-MM-dd HH:mm"
        forSaving.date = formater.string(from: date)
    }
    
    public func fetchFromCoreData(completion: (_ complete: Bool) -> ()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Saving")
        
        do {
            try SavingsManager.instance.setList(managedContext.fetch(fetchRequest) as! [Saving])
            print("Successfull fetched Saving from CoreData.")
            completion(true)
        } catch {
            debugPrint("Could not fetch Saving from CoreData: \(error.localizedDescription)")
            completion(false )
        }
    }
}
