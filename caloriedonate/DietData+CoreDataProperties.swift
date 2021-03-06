//
//  DietData+CoreDataProperties.swift
//  caloriedonate
//
//  Created by Yuta Okada on 2017/10/30.
//  Copyright © 2017年 Yuta Okada. All rights reserved.
//

import Foundation
import CoreData


extension DietData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DietData> {
        return NSFetchRequest<DietData>(entityName: "DietData");
    }

    @NSManaged public var calorie: Float
    @NSManaged public var created_at: NSDate?
    @NSManaged public var date: String?
    @NSManaged public var name: String?
    @NSManaged public var timezone: Int16
    @NSManaged public var updated_at: NSDate?
    @NSManaged public var uuid: String?

}
