//
//  ExerciseData+CoreDataClass.swift
//  caloriedonate
//
//  Created by Yuta Okada on 2017/10/02.
//  Copyright © 2017年 Yuta Okada. All rights reserved.
//

import Foundation
import CoreData

@objc(ExerciseData)
public class ExerciseData: NSManagedObject {

    override public func awakeFromInsert() {
        super.awakeFromInsert()
        self.created_at = NSDate()
        self.updated_at = NSDate()
    }
    
}
