//
//  SavingsManager.swift
//  SpendBook
//
//  Created by Tomasz Jaeschke on 22/12/2018.
//  Copyright © 2018 Tomasz Jaeschke. All rights reserved.
//

import Foundation

class SavingsManager {
    
    static let instance = SavingsManager()
    
    private var _savingsList = [Savings]()
    
    public func setList(_ ofSavings: [Savings]){
        _savingsList = ofSavings
    }
    public func getAllSavings() -> [Savings] {
        return _savingsList
    }
    public func countSavings() -> Int {
        return _savingsList.count
    }
    
    public func getSummaryOfSavings() -> Int {
        var summaryOfSavings: Int32 = 0
        for saving in _savingsList {
            summaryOfSavings += saving.value
        }
        return Int(summaryOfSavings)
    }
    
    public func todayDate(_ forSaving: Savings){
        let date = Date()
        let formater = DateFormatter()
        
        formater.dateFormat = "yyyy-MM-dd HH:mm"
        forSaving.date = formater.string(from: date)
    }
    
}
