//
//  UserSettings.swift
//  SpendBook
//
//  Created by Tomasz Jaeschke on 12.02.2018.
//  Copyright © 2018 Tomasz Jaeschke. All rights reserved.
//

import Foundation

final class UserSettings {
    
    static let instance = UserSettings()
    
    var isHistoryIconEnable: Bool
    
    init() {
        // Download data from CoreData
        isHistoryIconEnable = false
        
    }
}
