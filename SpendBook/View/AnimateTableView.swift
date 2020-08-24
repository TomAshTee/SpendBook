//
//  AnimateTableView.swift
//  SpendBook
//
//  Created by Tomasz Jaeschke on 12.02.2018.
//  Copyright © 2018 Tomasz Jaeschke. All rights reserved.
//

import Foundation
import UIKit

class AnimateTableView {
    
    // Animates the table, the rows of the table appear from the newest to the oldest.
    static func fromBottom(tableView: UITableView) {
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animate(withDuration: 1.0, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIView.AnimationOptions.allowAnimatedContent, animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
            
            index += 1
        }
    }
}
