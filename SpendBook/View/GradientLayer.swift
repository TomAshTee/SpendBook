//
//  GradientLayer.swift
//  SpendBook
//
//  Created by Tomasz Jaeschke on 10.02.2018.
//  Copyright © 2018 Tomasz Jaeschke. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorTwo.cgColor , colorOne.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
