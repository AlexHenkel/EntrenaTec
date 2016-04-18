//
//  AddTableViewController.swift
//  EntrenaTecTab
//
//  Created by Alex De la Rosa on 14/04/16.
//  Copyright © 2016 Alejandro Henkel. All rights reserved.
//

import UIKit
import RealmSwift


protocol addRoutineProtocol
{
    func saveNewRoutine()
    func popView()
}

class AddTableViewController: UITableViewController
{
    var arrExercises = [Exercise]()
    var dicSelectedExercises = [String: Exercise]()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let realm = try! Realm()
        
        let exercises = realm.objects(Exercise)
        
        self.arrExercises = Array(exercises)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        return self.arrExercises.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("addCell", forIndexPath: indexPath)

        cell.textLabel?.text = self.arrExercises[indexPath.row].strName
        cell.detailTextLabel?.text = self.arrExercises[indexPath.row].strMuscleGroup

        return cell
    }
    
    override func tableView(tableView:UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
