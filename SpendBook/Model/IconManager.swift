//
//  IconManager.swift
//  SpendBook
//
//  Created by Tomasz Jaeschke on 14.02.2018.
//  Copyright © 2018 Tomasz Jaeschke. All rights reserved.
//

import Foundation

class IconManager {
    static let instance = IconManager()
    
    init() {
        // In future download form CoreData
        _isIconEnable = false
    }
    
    // Const (in future download form some list)
    private let _iconList = ["Food", "Sport", "Home", "Study", "Game", "Travel", "Rent",
                             "Receipt", "Health", "Hygiene", "Cosmetic", "Car", "Transport",
                             "Other"]
    // Var
    private var _isIconEnable: Bool
    
    // Func
    func countIcon() -> Int {
        return _iconList.count
    }
    func getIconList() -> [String] {
        return _iconList
    }
    func isIconEnable() -> Bool {
        return _isIconEnable
    }
    func setIconEnable(_ isEnable: Bool) {
        self._isIconEnable = isEnable
    }
}
