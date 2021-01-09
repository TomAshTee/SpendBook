//
//  IconManagerTests.swift
//  SpendBookTests
//
//  Created by Tomasz Jaeschke on 09/01/2021.
//  Copyright © 2021 Tomasz Jaeschke. All rights reserved.
//

import XCTest
@testable import SpendBook

class IconManagerTests: XCTestCase {
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIsIconEnebleDefaultFase() throws {
        XCTAssertFalse(IconManager.instance.isIconEnable())
    }
    func testIsThereCorrectNumberOfIcons() throws {
        XCTAssertEqual(IconManager.instance.countIcon(), 15)
    }
    func testReceiveIconStringList() throws {
        let numberOfIcon = IconManager.instance.countIcon()
        let iconList = IconManager.instance.getIconList()
        
        XCTAssertEqual(iconList.count, numberOfIcon)
        
        for icon in iconList {
            
            guard let isNameOfIconAString = icon as? String else {
                XCTFail("Failed casting actual object: \(icon) to String.")
                return
            }
        }
    }
    func testSetIconEnableFalse() throws {
        IconManager.instance.setIconEnable(false)
        XCTAssertFalse(IconManager.instance.isIconEnable())
    }

    func testSetIconEnableTrue() throws {
        IconManager.instance.setIconEnable(true)
        XCTAssertTrue(IconManager.instance.isIconEnable())
    }
}
