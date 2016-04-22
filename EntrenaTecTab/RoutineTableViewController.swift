//
//  RoutineTableViewController.swift
//  EntrenaTecTab
//
//  Created by Alex De la Rosa on 05/04/16.
//  Copyright © 2016 Alejandro Henkel. All rights reserved.
//

import UIKit
import RealmSwift

class RoutineTableViewController: UITableViewController, addRoutineProtocol, ExerciseProtocol
{
    //------------------------------------------------------------------------------------------------------------------
    var listExercises = [Exercise]()

    @IBOutlet weak var outletBarra: UINavigationItem!
    @IBOutlet weak var outletEdit: UIBarButtonItem!
   
    //------------------------------------------------------------------------------------------------------------------
    @IBAction func actionCompletar(sender: AnyObject) {
        
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Cambia el titulo del View.
        let today = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        let date = dateFormatter.stringFromDate(today)
        self.title = "Rutina \(date)"
        
        self.loadData()
    }
    
    func loadData()
    {
        // Busca si el usuario tiene una rutina activa y la carga.
        let defaults = NSUserDefaults.standardUserDefaults()
        let user = defaults.stringForKey("studentId")!
        
        let realm = try! Realm()
        
        let student = realm.objects(User).filter("strStudentID == %@", user).first
        
        if student != nil
        {
            let routines = student!.routines
            print(routines)
            let activeRoutine = routines.filter("boolCompleted == %@", false).first
            if activeRoutine != nil
            {
                self.listExercises = (activeRoutine?.exercises)!.sort({ $0.strMuscleGroup < $1.strMuscleGroup })
            }
        }
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
        if indexPath.row == self.listExercises.count
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("completeCell", forIndexPath: indexPath)
            return cell
        }
        
        let cell =
            tableView.dequeueReusableCellWithIdentifier("CeldaRutina", forIndexPath: indexPath) as! RoutineTableViewCell

        cell.outletEjercicio.text = self.listExercises[indexPath.row].strName.uppercaseString
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
    
    //==================================================================================================================
    // MARK: - Protocolo
    
    //------------------------------------------------------------------------------------------------------------------
    func popView()
    {
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
    }
}
