//
//  SavingsCell.swift
//  SpendBook
//
//  Created by Tomasz Jaeschke on 23/01/2019.
//  Copyright © 2019 Tomasz Jaeschke. All rights reserved.
//

import UIKit

class SavingsCell: UITableViewCell {

    @IBOutlet weak var accountNameLbl: UILabel!
    @IBOutlet weak var valueLbl: UILabel!
    
    func configureCell(_ saving: Saving){
        
        accountNameLbl.text = saving.name
        
        if saving.value >= 0 {
            valueLbl.textColor = #colorLiteral(red: 0.2673969567, green: 0.8492315412, blue: 0.8062124848, alpha: 1)
            valueLbl.text = "$" + String(saving.value)
        } else {
            valueLbl.textColor = #colorLiteral(red: 0.9647058824, green: 0.4666666667, blue: 0.6901960784, alpha: 1)
            valueLbl.text = "$" + String(saving.value)
        }
    }
}
