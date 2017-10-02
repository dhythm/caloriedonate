//
//  DietData+CoreDataProperties.swift
//  caloriedonate
//
//  Created by Yuta Okada on 2017/10/02.
//  Copyright © 2017年 Yuta Okada. All rights reserved.
//

import Foundation
import CoreData


extension DietData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DietData> {
        return NSFetchRequest<DietData>(entityName: "DietData");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var name: String?
    @NSManaged public var calorie: Float
    @NSManaged public var timezone: Int16

}
