
import Foundation
import UIKit
import CoreData

class UseCoreData {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    /*
    let viewContext = self.appDelegate.persistentContainer.viewContext
    let weightdata = NSEntityDescription.entity(forEntityName: "WeightData", in: viewContext)
    
    // create record
    let newRecord = NSManagedObject(entity: weightdata!, insertInto: viewContext)
    newRecord.setValue(Date(), forKey: "date")
    newRecord.setValue(70.1, forKey: "weight")
    do {
        try viewContext.save()
    } catch {
        //
    }
    
    // fetch record
    let fetchRequest: NSFetchRequest<WeightData> = WeightData.fetchRequest()
    do {
        let results = try viewContext.fetch(fetchRequest)
        for result in results {
            print("\(result.date!)")
            print("\(result.weight)")
        }
    } catch {
        //
    }
    
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
 
    // delete record
    do {
        let results = try viewContext.fetch(fetchRequest)
        for result in results {
            let record = result
            if result.date! as Date > Date(timeInterval: -60, since: Date()) {
                //
            } else {
                viewContext.delete(record)
            }
            try viewContext.save()
        }
    } catch {
        //
    }
     */

}
