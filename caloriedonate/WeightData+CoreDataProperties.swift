//
//  WeightData+CoreDataProperties.swift
//  caloriedonate
//
//  Created by Yuta Okada on 2017/10/30.
//  Copyright © 2017年 Yuta Okada. All rights reserved.
//

import Foundation
import CoreData


extension WeightData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeightData> {
        return NSFetchRequest<WeightData>(entityName: "WeightData");
    }

    @NSManaged public var created_at: NSDate?
    @NSManaged public var date: String?
    @NSManaged public var updated_at: NSDate?
    @NSManaged public var uuid: String?
    @NSManaged public var weight: Float

}
