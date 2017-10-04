
import Foundation
import UIKit

class mainViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let today: [[String: String]] = []
    //let iconcamera: UIimage? = UIImage(named: "")

    var total: Int?
    var goal: Int?
    var donate: Int?
    
    let cX: CGFloat = UIScreen.main.bounds.width/2
    let cY: CGFloat = UIScreen.main.bounds.height/2.5
    
    func displayValue() {
        
        total = self.appDelegate._total
        goal  = self.appDelegate._goal
        
        let lWidth: CGFloat = 150
        let lHeight: CGFloat = 50
        
        let posX: CGFloat = cX - lWidth/2
        let posY: CGFloat = cY - lHeight/2

        let circleView: UIView = drawCircleView(frame: CGRect(x: 0, y: 0, width: cX*2, height: cY*2))
        circleView.backgroundColor = UIColor.init(red: 255, green: 255, blue: 255, alpha: 1)
        self.view.addSubview(circleView)
        
        /*
        donate = total! - goal! > 0 ? total! - goal! : 0
        let donateAmount: UILabel = UILabel(frame: CGRect(x: cX/2 - 60, y: cY/2 - lHeight/2, width: 120, height: lHeight/2))
        donateAmount.text = String(describing: donate!) + "円"
        donateAmount.font = UIFont(name: "HiraKakuProN-W6",size: 22)
        donateAmount.textAlignment =  NSTextAlignment.center
        donateAmount.textColor = UIColor.cyan
        self.view.addSubview(donateAmount)
         */
 
        let unit: UILabel = UILabel(frame: CGRect(x: posX, y: posY, width: lWidth, height: lHeight))
        unit.text = "kcal"
        unit.font = UIFont(name: "HiraKakuProN-W6",size: 12)
        unit.textAlignment = NSTextAlignment.center
        self.view.addSubview(unit)
        
        let totalCalories: UILabel = UILabel(frame: CGRect(x: posX - lWidth/3, y: posY - lHeight/2, width: lWidth, height: lHeight))
        let goalCalories: UILabel = UILabel(frame: CGRect(x: posX + lWidth/3 , y: posY + lHeight/2, width: lWidth, height: lHeight))
        
        totalCalories.text = String(describing: total!)
        totalCalories.font = UIFont(name: "HiraKakuProN-W6",size: 32)
        totalCalories.textAlignment = NSTextAlignment.center

        goalCalories.text = String(describing: goal!)
        goalCalories.font = UIFont(name: "HiraKakuProN-W6",size: 32)
        goalCalories.textAlignment = NSTextAlignment.center

        self.view.addSubview(totalCalories)
        self.view.addSubview(goalCalories)

        
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
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
        let bgColor: UIColor = UIColor.init(red: 245, green: 245, blue: 245, alpha: 1.0)
        self.view.backgroundColor = bgColor
        
        displayValue()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
