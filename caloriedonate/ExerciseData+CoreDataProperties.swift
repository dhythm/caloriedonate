//
//  ExerciseData+CoreDataProperties.swift
//  caloriedonate
//
//  Created by Yuta Okada on 2017/10/02.
//  Copyright © 2017年 Yuta Okada. All rights reserved.
//

import Foundation
import CoreData


extension ExerciseData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExerciseData> {
        return NSFetchRequest<ExerciseData>(entityName: "ExerciseData");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var name: String?
    @NSManaged public var calorie: Float
    @NSManaged public var time: Int16

}