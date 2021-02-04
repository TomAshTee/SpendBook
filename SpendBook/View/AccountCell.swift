//
//  AccountCell.swift
//  SpendBook
//
//  Created by Tomasz Jaeschke on 02/02/2021.
//  Copyright © 2021 Tomasz Jaeschke. All rights reserved.
//

import UIKit

class AccountCell: UITableViewCell {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var valueLbl: UILabel!
    
    
    func configureCell(_ value: Int) {
        if value >= 0 {
            valueLbl.textColor = #colorLiteral(red: 0.2673969567, green: 0.8492315412, blue: 0.8062124848, alpha: 1)
            valueLbl.text = "$" + String(value)
            
            dateLbl.text = "Income"
            dateLbl.textColor = #colorLiteral(red: 0.2673969567, green: 0.8492315412, blue: 0.8062124848, alpha: 1)
        } else {
            valueLbl.textColor = #colorLiteral(red: 0.9647058824, green: 0.4666666667, blue: 0.6901960784, alpha: 1)
            valueLbl.text = "$" + String(value)
            
            dateLbl.text = "Expense"
            dateLbl.textColor = #colorLiteral(red: 0.9647058824, green: 0.4666666667, blue: 0.6901960784, alpha: 1)
        }
    }
}
