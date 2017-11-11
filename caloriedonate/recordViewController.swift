
import Foundation
import UIKit
import CoreData

class recordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    private var uuidArray = [String]()
    private var dateArray = [String]()
    private var nameArray = [String]()
    private var calorieArray  = [Float]()
    private var tzArray = [Int16]()

    private var tableView: UITableView!

    private var sectionArray = [String]()
    private var numOfCellInSec = [Int]()
    
    var indexoffset: Int = 0
    
    private var addButton: UIButton!
    let diameter: CGFloat = 40

    var viewContext: NSManagedObjectContext!
    var dietdata: NSEntityDescription!
    var fetchRequest: NSFetchRequest<DietData>!
    
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
        
        viewContext = self.appDelegate.persistentContainer.viewContext
        dietdata = NSEntityDescription.entity(forEntityName: "DietData", in: viewContext)
        
        // setting for background
        let bgColor: UIColor = UIColor.init(red: 245, green: 245, blue: 245, alpha: 1.0)
        self.view.backgroundColor = bgColor
        
        let hStatusBar: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let hNavBar: CGFloat = self.navigationController!.navigationBar.frame.size.height
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.view.frame.height - hStatusBar))
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "dataCell")
        //tableView.register(customCell.self, forCellReuseIdentifier: NSStringFromClass(customCell.self))
        tableView.register(customCell.self, forCellReuseIdentifier: "dataCell")
        tableView.separatorInset = UIEdgeInsets.zero
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
        
        fetchRequest = DietData.fetchRequest()
        
        indexoffset = 0
        
        // order by date
        let sortDescripter = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [sortDescripter]
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        // fetch record
        do {
            let results = try viewContext.fetch(fetchRequest)
            uuidArray.removeAll()
            dateArray.removeAll()
            nameArray.removeAll()
            calorieArray.removeAll()
            tzArray.removeAll()
            for i in 0 ..< results.count {
                uuidArray.append(results[i].uuid! as String)
                dateArray.append(results[i].date! as String)
                nameArray.append(results[i].name!)
                calorieArray.append(results[i].calorie)
                tzArray.append(results[i].timezone)
            }
        } catch {
            //
        }
        
        // set table section
        let orderedSet: NSOrderedSet = NSOrderedSet(array: dateArray)
        sectionArray = orderedSet.array as! [String]
        
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
        
        tableView.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // NavigationBarを表示したい場合
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // Configuration of section
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArray.count
    }
    /*
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let headerLabel = UILabel(frame: CGRect(x: 5, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.text = self.tableView(self.tableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        return headerView

    }
     */
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionArray[section]
    }
    // Called when cell is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
    // Configuration of table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // initialize
        numOfCellInSec.removeAll()
        for i in 0 ..< sectionArray.count {
            numOfCellInSec.append(dateArray.filter{ $0 == sectionArray[i] }.count)
        }
        return numOfCellInSec[section]
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath) as! customCell
        
        // get first index-number for section
        let first = dateArray.index(of: sectionArray[indexPath.section])!

        if indexPath.row < first {
            indexoffset = first
        }
        let index = indexPath.row + indexoffset
        
        print("----- debug(cellForRowAt) ----")
        print("index       : \(index)")
        print("indexPath   : \(indexPath)")
        print("indexoffset : \(indexoffset)")
        cell.name.text = "\(nameArray[index])"
        cell.calorie.text = "\(calorieArray[index])"
        print("----- debug END -----")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var index = 0
            for i in 0 ..< indexPath.section{
                index += numOfCellInSec[i]
            }
            index += indexPath.row
            let uuid = uuidArray[index]
            
            print("----- debug(editingStyle) -----")
            print("index     : \(index)")
            print("indexPath : \(indexPath)")
            uuidArray.remove(at: index)
            dateArray.remove(at: index)
            nameArray.remove(at: index)
            calorieArray.remove(at: index)
            tzArray.remove(at: index)

            // delete rows in section
            tableView.deleteRows(at: [indexPath], with: .fade)
            //numOfCellInSec[indexPath.section] -= 1
            if numOfCellInSec[indexPath.section] == 0 {
                // tableView.deleteSections(indexPath.section, with: .fade)
                //numOfCellInSecArray[indexPath.section] = 0
                print("delete setion : \(indexPath.section)")
            }
            print("----- debug END -----")
            
            // Delete record
            /*
            do {
                fetchRequest.predicate = NSPredicate(format: "uuid = '\(uuid)'")
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
        }
    }

    
    internal func onClickAddButton(sender: UIButton){

        let destinationViewController: UIViewController = inputDataViewController()
        destinationViewController.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(destinationViewController, animated: true)
        
    }
    
}
