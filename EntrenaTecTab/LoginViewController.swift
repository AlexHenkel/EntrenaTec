//
//  LoginViewController.swift
//  EntrenaTecTab
//
//  Created by Alex De la Rosa on 04/04/16.
//  Copyright © 2016 Alejandro Henkel. All rights reserved.
//

import UIKit
import RealmSwift

class LoginViewController: UIViewController
{
    //------------------------------------------------------------------------------------------------------------------
    @IBOutlet weak var outletMatritucla: UITextField!
    
    //------------------------------------------------------------------------------------------------------------------
    @IBAction func actionLogIn(sender: UIButton)
    {
        // Valida que la matricula sea la correcta y presenta el view controller correspondiente.
        
        let strMatricula =
            outletMatritucla.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        if strMatricula != ""
        {
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setBool(true, forKey: "isLoggedIn")
            defaults.setObject(strMatricula, forKey: "studentId")
            
            var viewController: UIViewController
            
            self.storyboard
            
            if defaults.boolForKey("isRegistered")
            {
                viewController = self.storyboard!.instantiateViewControllerWithIdentifier("TabBar")
            }
            else
            {
                viewController = self.storyboard!.instantiateViewControllerWithIdentifier("Register")
            }
            
            self.presentViewController(viewController, animated: true, completion: nil)
        }
    }
    
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
}
