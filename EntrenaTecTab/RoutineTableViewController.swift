//
//  RoutineTableViewController.swift
//  EntrenaTecTab
//
//  Created by Alex De la Rosa on 05/04/16.
//  Copyright © 2016 Alejandro Henkel. All rights reserved.
//

import UIKit
import RealmSwift

class RoutineTableViewController: UITableViewController, RoutineProtocol
{
    //------------------------------------------------------------------------------------------------------------------
    var listExercises = [Exercise]()
    var originalCenter = CGPoint()
    var deleteOnDragRelease = false
    
    @IBOutlet weak var outletBarra: UINavigationItem!
    @IBOutlet weak var outletEdit: UIBarButtonItem!
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    //------------------------------------------------------------------------------------------------------------------
    // Se encarga de guardar la última fecha donde se realizó la rutina. Se ejecuta al seleccionar el boton de completar
    @IBAction func actionCompletar(sender: AnyObject)
    {
        // Obtiene la rutina actual de la BD.
        let routine = self.getActiveRoutine()
        var exercisesCompleted = true
        
        for exercise in (routine?.exercises)!
        {
            if !exercise.boolCompletado
            {
                exercisesCompleted = false
            }
        }
        
        // Si están completados todos los ejercicios, guarda la fecha y resetea la rutina y vuelve a cargar la vista.
        if exercisesCompleted
        {
            let date = Date()
            let realm = try! Realm()
            try! realm.write
            {
                    routine!.dateLast = NSDate()
                    routine!.days.append(date)
            }
            
            self.restartRoutine()
            self.loadData()
            self.tableView.reloadData()
            
            // Muestra un alert al terminar.
            let alertController = UIAlertController(title: "Rutina Guardada",
                                                    message: "La rutina de Hoy se ha guardado", preferredStyle: .Alert)
            let actionOK = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(actionOK)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
            
        else
        {
            // Muestra un alert de no completado.
            let alertController = UIAlertController(title: "No se puede guardar la rutina",
                                                    message: "La rutina de Hoy no se ha guardado, Termina todos los ejercicios",
                                                    preferredStyle: .Alert)
            
            let actionOK = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(actionOK)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
    }
    
    //------------------------------------------------------------------------------------------------------------------
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Cambia el titulo del View.
        let today = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        let date = dateFormatter.stringFromDate(today)
        self.title = "Rutina \(date)"
        
        // Carga la rutina.
        self.loadData()
    }
    
    //==================================================================================================================
    // MARK: - Carga de Datos
    
    //------------------------------------------------------------------------------------------------------------------
    // Busca si el usuario tiene una rutina activa y la carga.
    func getActiveRoutine() -> Routine?
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        let user = defaults.stringForKey("studentId")!
        
        let realm = try! Realm()
        
        let student = realm.objects(User).filter("strStudentID == %@", user).first
        
        if student != nil
        {
            let routines = student!.routines
            print(student)
            return routines.filter("boolCompleted == %@", false).first
        }
        return nil
    }
    
    //------------------------------------------------------------------------------------------------------------------
    // Metodo que se ejecuta al completar una rutina. Pone el completado de todos los ejercicios en falso.
    func restartRoutine()
    {
        let activeRoutine = self.getActiveRoutine()
        
        let realm = try! Realm()
        if activeRoutine != nil
        {
            for exercise in activeRoutine!.exercises
            {
                try! realm.write
                    {
                        exercise.boolCompletado = false
                }
            }
        }
    }
    
    //------------------------------------------------------------------------------------------------------------------
    // Carga los ejercicios de la base de datos y actualiza el progressBar.
    func loadData()
    {
        let activeRoutine = self.getActiveRoutine()
        if activeRoutine != nil
        {
            self.listExercises = (activeRoutine?.exercises)!.sort({ $0.strMuscleGroup < $1.strMuscleGroup })
            
            let totalExercises = Float(self.listExercises.count)
            
            var completedExercises:Float = 0.0
            for exercise in self.listExercises
            {
                if exercise.boolCompletado
                {
                    completedExercises += 1
                }
            }
            
            self.progressBar.setProgress(completedExercises/totalExercises, animated: true)
        }
        
        self.progressBar.setProgress(0.0, animated: true)
    }
    
    //------------------------------------------------------------------------------------------------------------------
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    //==================================================================================================================
    // MARK: - Table view
    
    //------------------------------------------------------------------------------------------------------------------
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    //------------------------------------------------------------------------------------------------------------------
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // Si no hay ejercicios regresa 0 y si si hay agrega uno que es el boton de completado.
        if self.listExercises.count == 0
        {
            return 0
        }
        
        return self.listExercises.count + 1
    }
    
    //------------------------------------------------------------------------------------------------------------------
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        // Muestra la celda de completar.
        if indexPath.row == self.listExercises.count
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("completeCell", forIndexPath: indexPath)
            return cell
        }
        
        // Carga cada ejercicio.
        let cell =
            tableView.dequeueReusableCellWithIdentifier("CeldaRutina", forIndexPath: indexPath) as! RoutineTableViewCell
        
        cell.outletEjercicio.text = self.listExercises[indexPath.row].strDescription.uppercaseString
        cell.outletSubtitulo.text = self.listExercises[indexPath.row].strMuscleGroup.uppercaseString
        if self.listExercises[indexPath.row].boolCompletado
        {
            cell.accessoryType = .Checkmark
        }
        else
        {
            cell.accessoryType = .None
        }
        
        return cell
    }
    
    //------------------------------------------------------------------------------------------------------------------
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        // si es el boton de completar o si el ejercicio ya ser realizó desactiva el swipe.
        if indexPath.row == self.listExercises.count || self.listExercises[indexPath.row].boolCompletado
        {
            return false
        }
        
        return true
    }
    
    //------------------------------------------------------------------------------------------------------------------
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) ->
        [UITableViewRowAction]?
    {
        // Crea el action de completar el ejercicio haciendo swipe.
        let editAction = UITableViewRowAction(style: .Normal, title: "Completar") {action in
            let routine = self.getActiveRoutine()
            if routine != nil
            {
                let listExerciseID = self.listExercises[indexPath.row].strExerciseID
                let exercise = routine!.exercises.filter("strExerciseID == %@", listExerciseID).first!
                
                let realm = try! Realm()
                try! realm.write
                    {
                        exercise.boolCompletado = true
                }
                self.loadData()
                self.tableView.reloadData()
            }
        }
        
        // cambia el background del boton.
        editAction.backgroundColor = UIColor(red: 0.15, green: 1.0, blue: 0.7, alpha: 1.0)
        
        return [editAction]
    }
    
    //==================================================================================================================
    // MARK: - Protocolo
    
    //------------------------------------------------------------------------------------------------------------------
    func popView()
    {
        // Recarga los datos de la rutina y quita la vista que está encima.
        self.loadData()
        self.tableView.reloadData()
        navigationController?.popViewControllerAnimated(true)
    }
    
    //------------------------------------------------------------------------------------------------------------------
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "addRoutineSegue"
        {
            let view = segue.destinationViewController as! AddTableViewController
            
            view.delegado = self
        }
        
        if segue.identifier == "viewExerciseSegue"
        {
            let view = segue.destinationViewController as! ExerciseViewController
            let index = self.tableView.indexPathForSelectedRow?.row
            view.exerciseToShow = self.listExercises[index!]
            view.delegado = self
        }
        
        if segue.identifier == "editRoutineSegue"
        {
            let view = segue.destinationViewController as! EditRoutineTableViewController
            view.delegado = self
        }
    }
    
    //------------------------------------------------------------------------------------------------------------------
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool
    {
        // Si va a edit routine y no hay rutina activa no ejecuta el segue.
        if identifier == "editRoutineSegue"
        {
            if self.getActiveRoutine() == nil
            {
                return false
            }
            return true
        }
        
        return true
    }
}


