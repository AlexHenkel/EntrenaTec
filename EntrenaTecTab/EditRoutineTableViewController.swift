//
//  EditRoutineTableViewController.swift
//  EntrenaTecTab
//
//  Created by Alex De la Rosa on 14/04/16.
//  Copyright © 2016 Alejandro Henkel. All rights reserved.
//

import UIKit

class EditRoutineTableViewController: UITableViewController
{
    //------------------------------------------------------------------------------------------------------------------
    @IBOutlet weak var actEditDone: UIBarButtonItem!
    
    //------------------------------------------------------------------------------------------------------------------
    override func viewDidLoad()
    {
        super.viewDidLoad()
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
        return 0
    }
    
    //------------------------------------------------------------------------------------------------------------------
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 0
    }
    
    //------------------------------------------------------------------------------------------------------------------
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
}
