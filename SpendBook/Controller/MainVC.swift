//
//  MainVC.swift
//  SpendBook
//
//  Created by Tomasz Jaeschke on 09.02.2018.
//  Copyright © 2018 Tomasz Jaeschke. All rights reserved.
//

import UIKit
import Charts
import ChameleonFramework

class MainVC: UIViewController {

    // Outlets
    
    @IBOutlet weak var summaryPieChartView: PieChartView!
    
    
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var withdrawBtn: UIButton!
    // Test data
    let categories = ["Food", "Rent", "Health", "Clothing","Travels"]
    let valueOfCategories = [340.0, 204.0, 30.0, 122.0, 263.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setChart(dataPoints: categories, values: valueOfCategories)

        // Do any additional setup after loading the view.
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        var dataEntries = [PieChartDataEntry]()
        
        // Set a dataEntries
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i])
            dataEntries.append(dataEntry)
        }
        
        // Set color
        var randomColors = [UIColor]()
        for i in 0..<dataPoints.count {
            let randomColor = UIColor.randomFlat()
            randomColors.append(randomColor!)
        }
        
        // Set up summaryPieChart
        let summaryPieChartDataSet = PieChartDataSet(values: dataEntries, label: "Summary")
        summaryPieChartDataSet.colors = randomColors
        let summaryPieChartData = PieChartData(dataSet: summaryPieChartDataSet)
        summaryPieChartView.data = summaryPieChartData
        summaryPieChartView.chartDescription?.text = ""
        summaryPieChartView.holeColor = UIColor.clear
        //summaryPieChartView.legend.enabled = false
        summaryPieChartView.animate(yAxisDuration: 1.0)
        
        
        
    }
}










