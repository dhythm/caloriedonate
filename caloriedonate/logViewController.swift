
import Foundation
import UIKit
import CoreData

import Charts
import SwiftyJSON

class logViewController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    var chartView: LineChartView!
    
    // Height of StatusBar
    let sbHeight: CGFloat = UIApplication.shared.statusBarFrame.height
    // Height of ChartView
    let cHeight: CGFloat = 200

    let days   = ["10/01","10/02","10/03","10/04","10/05"]
    let weight = [72.0,71.2,71.6,70.2,70.4]
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 3)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting for background
        let bgColor: UIColor = UIColor.init(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1.0)
        self.view.backgroundColor = bgColor

        chartView = LineChartView(frame: CGRect(x: 0, y: sbHeight, width: UIScreen.main.bounds.width, height: cHeight))

        //
        chartView.backgroundColor = UIColor.white
        chartView.leftAxis.axisMinimum = weight.min()! * 0.85
        chartView.leftAxis.axisMaximum = weight.max()! * 1.15
        
        //
        chartView.legend.enabled = false
        chartView.pinchZoomEnabled = false
        chartView.doubleTapToZoomEnabled = false
        chartView.dragEnabled = false
        chartView.drawBordersEnabled = true
        
        //
        //chartView.leftAxis.drawLabelsEnabled     = false
        chartView.rightAxis.drawLabelsEnabled    = false
        //chartView.leftAxis.drawGridLinesEnabled  = false
        chartView.rightAxis.drawGridLinesEnabled = false
        chartView.xAxis.drawGridLinesEnabled     = false
        chartView.xAxis.labelPosition = .bottom

        // title of graph
        chartView.chartDescription?.text = ""
        // padding of graph
        chartView.extraTopOffset    =  0.0
        chartView.extraRightOffset  = 20.0
        chartView.extraBottomOffset = 10.0
        chartView.extraLeftOffset   =  0.0

        // set values to x-axis
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: days)
        chartView.xAxis.granularity = 1
        // set values to y-axis
        var entries: [ChartDataEntry] = []
        for (i, d) in weight.enumerated() {
            entries.append(ChartDataEntry(x: Double(i), y: d))
        }
        let dataset = LineChartDataSet(values: entries, label: "Data")
        // hide the values over points
        dataset.drawValuesEnabled = false
        dataset.drawCircleHoleEnabled = false
        dataset.circleColors = [UIColor.black]
        dataset.circleRadius = 4.0
        dataset.colors = [UIColor.black]
        chartView.data = LineChartData(dataSet: dataset)

        self.view.addSubview(chartView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //self.chartView.reloadInputViews()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
