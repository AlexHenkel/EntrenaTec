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
    dynamic var strRoutineID = ""
    dynamic var strLevel = ""
    dynamic var dateStart = NSDate()
    dynamic var dateEnd: NSDate? = nil
    dynamic var intCompleted = 0
}