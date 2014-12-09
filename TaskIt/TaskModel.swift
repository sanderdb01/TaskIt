//
//  TaskModel.swift
//  TaskIt
//
//  Created by David Sanders on 12/9/14.
//  Copyright (c) 2014 Bitfountain.io. All rights reserved.
//

import Foundation
import CoreData

class TaskModel: NSManagedObject {

    @NSManaged var date: NSDate
    @NSManaged var isCompleted: NSNumber
    @NSManaged var subtask: String
    @NSManaged var task: String

}
