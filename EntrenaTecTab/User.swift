//
//  User.swift
//  EntrenaTecTab
//
//  Created by Alex De la Rosa on 04/04/16.
//  Copyright © 2016 Alejandro Henkel. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object
{
    dynamic var strStudentID = ""
    dynamic var strPassword = ""
    dynamic var intMaxWeightArm = 0
    dynamic var intMaxWeightChest = 0
    dynamic var intMaxWeightShoulder = 0
    dynamic var intMaxWeightLeg = 0
    dynamic var intCrunches = 0
    dynamic var intPushups = 0
}
