//
//  RoundedButton.swift
//  SpendBook
//
//  Created by Tomasz Jaeschke on 10.02.2018.
//  Copyright © 2018 Tomasz Jaeschke. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton{

    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
            self.setUpView()
        }
    }
    override func awakeFromNib() {
        self.setUpView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setUpView()
    }
    
    func setUpView() {
        self.layer.cornerRadius = cornerRadius
    }

}
