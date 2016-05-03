//
//  AddTableViewController.swift
//  EntrenaTecTab
//
//  Created by Alex De la Rosa on 14/04/16.
//  Copyright © 2016 Alejandro Henkel. All rights reserved.
//

import UIKit
import RealmSwift


protocol RoutineProtocol
{
    func popView()
}

class AddTableViewController: UITableViewController
{
    //------------------------------------------------------------------------------------------------------------------
    // Guarda todos los ejercicios que se cargan de la base de datos.
    var arrExercises = [ExercisesList]()
    // Guarda los ejercicios seleccionados, para luego crear la rutina.
    var dicSelectedExercises = [String: ExercisesList]()
    var delegado: RoutineProtocol!
    
    //------------------------------------------------------------------------------------------------------------------
    @IBAction func actAddDone(sender: AnyObject)
    {
        // Busca si el usuario tiene una rutina activa y la termina.
        let defaults = NSUserDefaults.standardUserDefaults()
        let user = defaults.stringForKey("studentId")!
        
        let realm = try! Realm()
        
        let student = realm.objects(User).filter("strStudentID == %@", user).first
        
        var intId = 0
        
        if student != nil
        {
            let routines = student!.routines
            let activeRoutine = routines.filter("boolCompleted == %@", false).first
            if activeRoutine != nil
            {
                intId = activeRoutine!.intRoutineID + 1
                try! realm.write
                {
                    activeRoutine!.boolCompleted = true
                    activeRoutine!.dateEnd = NSDate()
                }
            }
            
            let newRoutine = Routine()
            newRoutine.intRoutineID = intId
            
            let arrExercises = List<Exercise>()
            
            for exercise in dicSelectedExercises.values
            {
                let exerciseToAdd = Exercise()
                exerciseToAdd.strExerciseID = exercise.strExerciseID
                exerciseToAdd.strName = exercise.strName
                exerciseToAdd.strDescription = exercise.strDescription
                exerciseToAdd.strImageName = exercise.strImageName
                exerciseToAdd.strMuscleGroup = exercise.strMuscleGroup
                
                arrExercises.append(exerciseToAdd)
            }
            
            newRoutine.exercises.appendContentsOf(arrExercises)
            
            try! realm.write
            {
                realm.add(newRoutine)
                student!.routines.append(newRoutine)
            }
        }
        
        delegado.popView()
    }
    
    //------------------------------------------------------------------------------------------------------------------
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Carga los datos de los ejercicios, los ordena por grupo muscular y lo guarda en un arreglo.
        let realm = try! Realm()
        let exercises = realm.objects(ExercisesList).sorted("strMuscleGroup")
        self.arrExercises = Array(exercises)
    }

    //------------------------------------------------------------------------------------------------------------------
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    //==================================================================================================================
    // MARK: - Table view
    
    //------------------------------------------------------------------------------------------------------------------
    // TODO: Generar una sección por cada grupo muscular.
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        // Regresa el número de secciones que va a tener la tabla.
        return 1
    }
    
    //------------------------------------------------------------------------------------------------------------------
    // TODO: Al cambiar número de secciones cambiar número de rows.
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // Indica a la tabla cuantos row tiene cada sección.
        return self.arrExercises.count
    }
    
    //------------------------------------------------------------------------------------------------------------------
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        // Pone los datos de la celda que corresponde para cada row. Quita el checkmark a los elementos no seleccionados.
        //      (Esto sucede porque reutiliza las celdas y deja los checkmarks).
        
        let cell = tableView.dequeueReusableCellWithIdentifier("addCell", forIndexPath: indexPath)

        cell.textLabel?.text = self.arrExercises[indexPath.row].strDescription.uppercaseString
        cell.detailTextLabel?.text = self.arrExercises[indexPath.row].strMuscleGroup.uppercaseString
        
        if self.dicSelectedExercises["\(self.arrExercises[indexPath.row].strName)"] != nil
        {
            cell.accessoryType = .Checkmark
        }
        else
        {
            cell.accessoryType = .None
        }
        
        cell.selectionStyle = .None

        return cell
    }
    
    //------------------------------------------------------------------------------------------------------------------
    override func tableView(tableView:UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        // Selección de un elemento de la tabla. Si no estaba seleccionado, pone el checkmark y lo mete al dicionario de
        //      ejercicios. Si si, quita el checkmark y quita el ejercicio del diccionario.
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)!
        
        if cell.accessoryType == .Checkmark
        {
            cell.accessoryType = .None
            self.dicSelectedExercises.removeValueForKey("\(self.arrExercises[indexPath.row].strName)")
        }
        
        else if cell.accessoryType == .None
        {
            cell.accessoryType = .Checkmark
            self.dicSelectedExercises["\(self.arrExercises[indexPath.row].strName)"] = self.arrExercises[indexPath.row]
        }
    }
}
