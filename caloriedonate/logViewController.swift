
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

    var days   = [String]()
    var weight = [Double]()
    
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

        self.view.addSubview(chartView)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // fetch record
        let viewContext = self.appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<WeightData> = WeightData.fetchRequest()
        do {
            days.removeAll()
            weight.removeAll()
            let results = try viewContext.fetch(fetchRequest)
            for i in 0 ..< results.count {
                let df = DateFormatter()
                df.dateFormat = "MM/dd"
                //days.append(df.string(from: results[i].date! as Date))
                weight.append(Double(results[i].weight))
            }
        } catch {
            fatalError("Failed to fetch data: \(error)")
        }

        //
        chartView.backgroundColor = UIColor.white
        if weight.count > 0 {
            chartView.leftAxis.axisMinimum = weight.min()! * 0.85
            chartView.leftAxis.axisMaximum = weight.max()! * 1.15
        }
            
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
        
        /*
         // create record
         for i in 1 ..< 6 {
         let newRecord = NSManagedObject(entity: weightdata!, insertInto: viewContext)
         newRecord.setValue(Date(timeInterval: 86400 * Double(i), since: Date()), forKey: "date")
         newRecord.setValue(70.1, forKey: "weight")
         do {
         try viewContext.save()
         } catch {
         //
         }
         }
         */

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
