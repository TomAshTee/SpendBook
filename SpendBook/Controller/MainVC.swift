//
//  MainVC.swift
//  SpendBook
//
//  Created by Tomasz Jaeschke on 09.02.2018.
//  Copyright © 2018 Tomasz Jaeschke. All rights reserved.
//

import UIKit
import Charts

class MainVC: UIViewController {

    // Outlets
    @IBOutlet weak var lineChartView: LineChartView!
    
    
    
    var months: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Data from CoreData
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        setChart(dataPoints: months, values: unitsSold)

        // Do any additional setup after loading the view.
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        lineChartView.noDataText = "There is no enought data"
        
        var chartEntry = [ChartDataEntry]()
        
        for i in 0..<values.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i], data: dataPoints[i] as AnyObject)
            chartEntry.append(dataEntry)
        }
        
        let dataSet = LineChartDataSet(values: chartEntry, label: "My chart")
        dataSet.drawValuesEnabled = false
        let lineChart = LineChartData(dataSet: dataSet)
        lineChartView.data = lineChart
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        lineChartView.xAxis.granularity = 1
        lineChartView.chartDescription?.text = ""
    }
}










