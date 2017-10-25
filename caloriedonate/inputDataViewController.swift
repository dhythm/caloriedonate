
import Foundation
import UIKit
import CoreData

class inputDataViewController: UIViewController, UIPickerViewDelegate {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    let wDisplay = UIScreen.main.bounds.width
    let hDisplay = UIScreen.main.bounds.height

    private var tfDate: UITextField!
    private var dpToolBar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let hStatusBar: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let hNavBar: CGFloat = self.navigationController!.navigationBar.frame.size.height

        
        // setting for background
        let bgColor: UIColor = UIColor.init(red: 245, green: 245, blue: 245, alpha: 1.0)
        self.view.backgroundColor = bgColor

        
        let xTimeZone = self.view.frame.width/2
        let yTimeZone = hStatusBar + hNavBar + 40
        let tzArray = ["朝食","昼食","夕食","間食"]
        let tzSegmentedControl: UISegmentedControl = UISegmentedControl(items: tzArray as [AnyObject])
        tzSegmentedControl.center = CGPoint(x: xTimeZone, y: yTimeZone)
        tzSegmentedControl.backgroundColor = UIColor.white
        tzSegmentedControl.tintColor = UIColor.init(red: 0, green: 122/255.0, blue: 255/255.0, alpha: 1.0)
        tzSegmentedControl.selectedSegmentIndex = 0
        tzSegmentedControl.addTarget(self, action: #selector(inputDataViewController.onDidSegmentedControlChanged(sc:)), for: UIControlEvents.valueChanged)


        let wDiet: CGFloat = wDisplay - 50
        let hDiet: CGFloat =  40
        let xDiet = (wDisplay - wDiet)/2
        let yDiet = yTimeZone + hDiet + 0
        let tfDiet: UITextField = UITextField(frame: CGRect(x: xDiet, y: yDiet, width: wDiet, height: hDiet))
        tfDiet.placeholder = "食事内容"
        tfDiet.borderStyle = .roundedRect
        tfDiet.clearButtonMode = .whileEditing

        
        let wCal: CGFloat = wDisplay - 50
        let hCal: CGFloat =  40
        let xCal = (wDisplay - wCal)/2
        let yCal = yDiet + hCal + 10
        let tfCal: UITextField = UITextField(frame: CGRect(x: xCal, y: yCal, width: wCal, height: hCal))
        tfCal.placeholder = "摂取カロリー"
        tfCal.borderStyle = .roundedRect
        tfCal.clearButtonMode = .whileEditing
        tfCal.keyboardType = .numberPad

        let datePicker: UIDatePicker = UIDatePicker()
        let hDatePicker: CGFloat = 150
        datePicker.frame = CGRect(x: 0.0, y: hDisplay - hDatePicker, width: wDisplay, height: hDatePicker)
        datePicker.datePickerMode = UIDatePickerMode.date
        datePicker.timeZone = NSTimeZone.local
        datePicker.layer.cornerRadius = 3.0
        let today = Calendar.current
        datePicker.minimumDate = today.date(byAdding: .year, value: -1, to: today.startOfDay(for: Date()))
        datePicker.maximumDate = Date()
        datePicker.addTarget(self, action: #selector(inputDataViewController.onDidChangeDate(sender:)), for: .valueChanged)
        dpToolBar = UIToolbar()
        dpToolBar.sizeToFit()
        let toolBarButton = UIBarButtonItem(title: "閉じる", style: .plain, target: self, action: "closeDatePickerButton")
        dpToolBar.items = [toolBarButton]
        let wDate: CGFloat = wDisplay - 50
        let hDate: CGFloat =  40
        let xDate = (wDisplay - wDate)/2
        let yDate = yCal + hDate + 10
        tfDate = UITextField(frame: CGRect(x: xDate, y: yDate, width: wDate, height: hDate))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let dateString = dateFormatter.string(from: Date())
        tfDate.text = dateString
        tfDate.placeholder = "yyyy/mm/dd"
        tfDate.borderStyle = .roundedRect
        tfDate.clearButtonMode = .whileEditing
        tfDate.inputView = datePicker
        tfDate.inputAccessoryView = dpToolBar
        

        self.view.addSubview(tzSegmentedControl)
        self.view.addSubview(tfDiet)
        self.view.addSubview(tfCal)
        //self.view.addSubview(datePicker)
        self.view.addSubview(tfDate)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tabBar.hidden = true
        // NavigationBarを表示したい場合
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
     */

    /*
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
     */
    
    internal func onDidSegmentedControlChanged(sc: UISegmentedControl){
        switch sc.selectedSegmentIndex {
        case 0:
            break
        case 1:
            break
        case 2:
            break
        case 3:
            break
        default:
            print("Error")
        }
    }
    
    internal func onDidChangeDate(sender: UIDatePicker){
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        let selectedDate: NSString = dateFormatter.string(from: sender.date) as NSString
        tfDate.text = selectedDate as String
    }
    
    internal func closeDatePickerButton() {
        //self.view.endEditing(true)
        tfDate.resignFirstResponder()
    }
    
    
}
