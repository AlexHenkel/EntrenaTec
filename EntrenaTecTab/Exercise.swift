//
//  Exercise.swift
//  EntrenaTecTab
//
//  Created by Alex De la Rosa on 04/04/16.
//  Copyright © 2016 Alejandro Henkel. All rights reserved.
//

import Foundation
import RealmSwift

class Exercise: Object
{
    dynamic var strExerciseID = ""
    dynamic var strName = ""
    dynamic var strDescription = ""
    dynamic var strImageName = ""
    dynamic var strMuscleGroup = ""
    dynamic var boolCompletado = false
}