//
//  Routine.swift
//  EntrenaTecTab
//
//  Created by Alex De la Rosa on 04/04/16.
//  Copyright © 2016 Alejandro Henkel. All rights reserved.
//

import Foundation
import RealmSwift

class Routine: Object
{
    dynamic var intRoutineID = 0
    dynamic var boolCompleted = false
    dynamic var dateStart = NSDate()
    dynamic var dateLast: NSDate? = nil
    dynamic var dateEnd: NSDate? = nil
    let exercises = List<Exercise>()
}