
import Foundation
import UIKit
import CoreData

class recordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    private var dataArray = [String]()
    //private var dataArray = ["test1","test2","test3"]
    private var tableView: UITableView!
    
    private var addButton: UIButton!
    let diameter: CGFloat = 40
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 2)
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
        
        let hStatusBar: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let hNavBar: CGFloat = self.navigationController!.navigationBar.frame.size.height
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.view.frame.height - hStatusBar))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "dataCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        addButton = UIButton()
        let bw: CGFloat = diameter
        let bh: CGFloat = diameter
        let posX: CGFloat = self.view.frame.width/2 - bw/2
        let posY: CGFloat = self.view.frame.height/2 - bh/2
        
        addButton.frame = CGRect(x: posX, y: posY, width: bw, height: bh)
        addButton.layer.masksToBounds = true
        addButton.layer.cornerRadius = diameter/2.0
        let addImage = UIImage.imageFromSystemBarButton(.add).withRenderingMode(.alwaysTemplate)
        addButton.setImage(addImage, for: .normal)
        addButton.tintColor = UIColor.init(red: 0, green: 122/255.0, blue: 255/255.0, alpha: 1.0)
        //addButton.setBackgroundImage(<#T##image: UIImage?##UIImage?#>, for: .highlighted)
        addButton.addTarget(self, action: #selector(recordViewController.onClickAddButton(sender:)), for: .touchUpInside)

        let addNavButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(recordViewController.onClickAddButton(sender:)))
        
        // setting for navigation bar
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let dateString = dateFormatter.string(from: Date())
        self.navigationItem.title = dateString
        
        self.navigationItem.rightBarButtonItem = addNavButton
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.view.addSubview(tableView)
        //self.view.addSubview(addButton)
        //let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let viewContext = self.appDelegate.persistentContainer.viewContext
        //let weightdata = NSEntityDescription.entity(forEntityName: "WeightData", in: viewContext)
        let dietdata = NSEntityDescription.entity(forEntityName: "DietData", in: viewContext)
        let fetchRequest: NSFetchRequest<DietData> = DietData.fetchRequest()
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
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
        
        // fetch record
        do {
            let results = try viewContext.fetch(fetchRequest)
            dataArray.removeAll()
            for i in 0 ..< results.count {
                dataArray.append(results[i].name!)
            }
            /*
            for result in results {
                dataArray.append(result.name!)
                print("date   :\(dateFormatter.string(from: result.date as! Date))")
                print("name   :\(result.name!)")
                print("calorie:\(result.calorie)")
            }
            */
        } catch {
            //
        }
        
        /*
         // update record
         do {
         let results = try viewContext.fetch(fetchRequest)
         for result in results {
         let record = result
         record.setValue(Date(), forKey: "date")
         }
         try viewContext.save()
         } catch {
         //
         }
         */
        
        /*
        // delete record
        do {
            let results = try viewContext.fetch(fetchRequest)
            for result in results {
                let record = result
                viewContext.delete(record)
                try viewContext.save()
            }
        } catch {
            //
        }
        */
        
        tableView.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // NavigationBarを表示したい場合
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(dataArray[indexPath.row])")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("dataArray.count: \(dataArray.count)")
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath)
        cell.textLabel!.text = "\(dataArray[indexPath.row])"
        print("cell.textLabel!.text: \(cell.textLabel!.text)")
        
        return cell
    }

    
    internal func onClickAddButton(sender: UIButton){

        let destinationViewController: UIViewController = inputDataViewController()
        destinationViewController.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(destinationViewController, animated: true)
        
    }
    
}
