
import Foundation
import UIKit
import CoreData

class mainViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let today: [[String: String]] = []
    //let iconcamera: UIimage? = UIImage(named: "")

    var total: Int?
    var goal: Int?
    var donate: Int?
    
    var todayCal: Float = 0.0
    
    let cX: CGFloat = UIScreen.main.bounds.width/2
    let cY: CGFloat = UIScreen.main.bounds.height/2.5
    
    var viewContext: NSManagedObjectContext!
    var dietdata: NSEntityDescription!
    var fetchRequest: NSFetchRequest<DietData>!
    
    var totalCalories: UILabel!
    var goalCalories: UILabel!
    var unit: UILabel!
    var circleView: UIView!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        //self.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        self.tabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "icons8-home-60"), tag: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewContext = self.appDelegate.persistentContainer.viewContext
        dietdata = NSEntityDescription.entity(forEntityName: "DietData", in: viewContext)
        
        // setting for background
        let bgColor: UIColor = UIColor.init(red: 245, green: 245, blue: 245, alpha: 1.0)
        self.view.backgroundColor = bgColor
        
        let lWidth: CGFloat = 150
        let lHeight: CGFloat = 50
        
        let posX: CGFloat = cX - lWidth/2
        let posY: CGFloat = cY - lHeight/2
        
        //circleView = drawCircleView(frame: CGRect(x: 0, y: 0, width: cX*2, height: cY*2))
        //circleView.backgroundColor = UIColor.init(red: 255, green: 255, blue: 255, alpha: 1)
        //self.view.addSubview(circleView)
        
        unit = UILabel(frame: CGRect(x: posX, y: posY, width: lWidth, height: lHeight))
        unit.text = "kcal"
        unit.font = UIFont(name: "HiraKakuProN-W6",size: 12)
        unit.textAlignment = NSTextAlignment.center
        //self.view.addSubview(unit)
        
        totalCalories = UILabel(frame: CGRect(x: posX - lWidth/3, y: posY - lHeight/2, width: lWidth, height: lHeight))
        goalCalories = UILabel(frame: CGRect(x: posX + lWidth/3 , y: posY + lHeight/2, width: lWidth, height: lHeight))
        
        totalCalories.font = UIFont(name: "HiraKakuProN-W6",size: 32)
        totalCalories.textAlignment = NSTextAlignment.center
        
        goalCalories.font = UIFont(name: "HiraKakuProN-W6",size: 32)
        goalCalories.textAlignment = NSTextAlignment.center
        
        //self.view.addSubview(totalCalories)
        //self.view.addSubview(goalCalories)

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchRequest = DietData.fetchRequest()

        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        //dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy/MM/dd", options: 0, locale: Locale(identifier: "ja_JP"))
        //dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy/MM/dd", options: 0, locale: Locale.current)
        
        let today = dateFormatter.string(from: Date())
        
        todayCal = 0.0
        
        do {
            fetchRequest.predicate = NSPredicate(format: "date = '\(today)'")
            let results = try viewContext.fetch(fetchRequest)
            for i in 0 ..< results.count {
                todayCal += results[i].calorie
            }
        } catch {
            //
        }

        total = Int(todayCal)
        self.appDelegate._total = total
        
        goal  = self.appDelegate._goal

        totalCalories.text = String(describing: total!)
        goalCalories.text = String(describing: goal!)
        
        circleView = drawCircleView(frame: CGRect(x: 0, y: 0, width: cX*2, height: cY*2))
        circleView.backgroundColor = UIColor.init(red: 255, green: 255, blue: 255, alpha: 1)
        
        self.view.addSubview(circleView)
        self.view.addSubview(unit)
        self.view.addSubview(totalCalories)
        self.view.addSubview(goalCalories)

    }
    
}
