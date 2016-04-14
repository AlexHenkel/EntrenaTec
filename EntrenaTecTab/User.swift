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
    dynamic var strName = ""
    dynamic var strPassword = ""
    dynamic var strLevel = "Principiante"
    dynamic var intFlex1 = 0
    dynamic var intFlex2 = 0
    dynamic var intAbs1 = 0
    dynamic var intAbs2 = 0
    dynamic var intPushups1 = 0
    dynamic var intPushups2 = 0
    dynamic var doubleCooper1: Double = 0.0
    dynamic var doubleCooper2: Double = 0.0
    let routines = List<Routine>()
}
