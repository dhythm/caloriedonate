
import Foundation
import UIKit
import CoreData

class recordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    private var dateArray = [String]()
    private var uuidArray = [[String]]()
    private var nameArray = [[String]]()
    private var calorieArray  = [[Float]]()
    private var tzArray = [[Int16]]()

    private var tableView: UITableView!

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
        
        // fetch 処理
        do {
            
            let results = try viewContext.fetch(fetchRequest)

            // 初期化
            var previous = ""
            var index = 0

            dateArray.removeAll()
            uuidArray.removeAll()
            nameArray.removeAll()
            calorieArray.removeAll()
            tzArray.removeAll()

            uuidArray.append([String]())
            nameArray.append([String]())
            calorieArray.append([Float]())
            tzArray.append([Int16]())

            
            // fetch したデータを多次元配列に格納
            for i in 0 ..< results.count {
                if previous != results[i].date! as String {
                    dateArray.append(results[i].date! as String)
                    if i != 0 {
                        uuidArray.append([String]())
                        nameArray.append([String]())
                        calorieArray.append([Float]())
                        tzArray.append([Int16]())
                        index += 1
                    }
                }
                uuidArray[index].append(results[i].uuid! as String)
                nameArray[index].append(results[i].name!)
                calorieArray[index].append(results[i].calorie)
                tzArray[index].append(results[i].timezone)
                previous = results[i].date! as String
            }
        } catch {
            //
        }
        
        tableView.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // NavigationBar を表示したい場合
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // セクションの数を返却
    func numberOfSections(in tableView: UITableView) -> Int {
        return dateArray.count
    }
    // セクションのタイトルを設定
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        //let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width, height: 10))
        label.text = dateArray[section]
        label.backgroundColor = UIColor.init(red: 247/255.0, green: 247/255.0, blue: 247/255.0, alpha: 1.0)
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 16, weight: UIFontWeightRegular)
        return label
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dateArray[section]
    }
 
    // セルが選択された際の設定
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
    // セクション内のセル数を返却
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray[section].count
    }
    // セルの値を設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath) as! customCell
        
        cell.name.text    = "\(nameArray[indexPath.section][indexPath.row])"
        cell.calorie.text = "\(calorieArray[indexPath.section][indexPath.row])"
        cell.calorie.font = UIFont.monospacedDigitSystemFont(ofSize: 16, weight: UIFontWeightRegular)
        
        return cell
    }
    // セルをスワイプで削除した際の処理
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            var index = 0
            let uuid = uuidArray[indexPath.section][indexPath.row]
            
            uuidArray[indexPath.section].remove(at: indexPath.row)
            nameArray[indexPath.section].remove(at: indexPath.row)
            calorieArray[indexPath.section].remove(at: indexPath.row)
            tzArray[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            // セクションの全てのセルがなくなった場合の処理
            if nameArray[indexPath.section].count == 0 {
                dateArray.remove(at: indexPath.section)
                uuidArray.remove(at: indexPath.section)
                nameArray.remove(at: indexPath.section)
                calorieArray.remove(at: indexPath.section)
                tzArray.remove(at: indexPath.section)
                tableView.deleteSections(IndexSet(integer: indexPath.section), with: .fade)
            }
            
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
