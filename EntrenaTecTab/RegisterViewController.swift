//
//  RegisterViewController.swift
//  EntrenaTecTab
//
//  Created by Alex De la Rosa on 04/04/16.
//  Copyright © 2016 Alejandro Henkel. All rights reserved.
//

import UIKit
import RealmSwift

class RegisterViewController: UIViewController
{
    @IBOutlet weak var outletNombre: UITextField!
    @IBOutlet weak var outletFlex: UITextField!
    @IBOutlet weak var outletCooper: UITextField!
    @IBOutlet weak var outletLagartijas: UITextField!
    @IBOutlet weak var outletAbs: UITextField!
    
    @IBAction func confirmarDatos(sender: UIButton)
    {
        
        // Saca los datos del outlet quitandole blancos en exceso.
        let strNombre = outletNombre.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let strFlex = outletFlex.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let strCooper = outletCooper.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let strLagartijas = outletLagartijas.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let strAbs = outletAbs.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        if strNombre != "" && strFlex != "" && strCooper != "" && strLagartijas != "" && strAbs != ""
        {
            let defaults = NSUserDefaults.standardUserDefaults()
            let user = defaults.stringForKey("studentId")!
            
            let realm = try! Realm()
            
            let student = User()
            student.strStudentID = user
            student.strName = strNombre
            student.intFlex1 = Int(strFlex)!
            student.doubleCooper1 = Double(strCooper)!
            student.intPushups1 = Int(strLagartijas)!
            student.intAbs1 = Int(strAbs)!
            
            try! realm.write
            {
                realm.add(student)
            }
            
            defaults.setBool(true, forKey: "isRegistered")
            
            let viewController = self.storyboard!.instantiateViewControllerWithIdentifier("TabBar")
            self.presentViewController(viewController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
