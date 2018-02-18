//
//  TransactionManager.swift
//  SpendBook
//
//  Created by Tomasz Jaeschke on 15.02.2018.
//  Copyright © 2018 Tomasz Jaeschke. All rights reserved.
//

import UIKit

class TransactionManager {
    
    static let instance = TransactionManager()
    
    private var _transactionList = [Transaction]()
    
    
    public func setList(_ ofTransaction:[Transaction]){
        _transactionList = ofTransaction
    }
    public func get(_ transactionOfIndex: Int) -> Transaction {
        return _transactionList[transactionOfIndex]
    }
    public func count() -> Int {
        return _transactionList.count
    }
    
    static func date(_ forTransaction: Transaction){
        let date = Date()
        let calendar = Calendar.current
        let formatter = DateFormatter()
        
        forTransaction.day = Int16(calendar.component(.day, from: date))
        forTransaction.month = Int16(calendar.component(.month, from: date))
        forTransaction.year = Int16(calendar.component(.year, from: date))
        forTransaction.hour = Int16(calendar.component(.hour, from: date))
        forTransaction.minute = Int16(calendar.component(.minute, from: date))
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        forTransaction.date = formatter.string(from: date)
        
    }
}
