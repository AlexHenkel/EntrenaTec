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
    //------------------------------------------------------------------------------------------------------------------
    @IBOutlet weak var outletNombre: UITextField!
    @IBOutlet weak var outletFlex: UITextField!
    @IBOutlet weak var outletCooper: UITextField!
    @IBOutlet weak var outletLagartijas: UITextField!
    @IBOutlet weak var outletAbs: UITextField!
    
    //------------------------------------------------------------------------------------------------------------------
    @IBAction func confirmarDatos(sender: UIButton)
    {
        // Valida los datos de los Outlets, Guarda al nuevo usuario en la BD y presenta el view controller.
        
        // Saca los datos del outlet quitandole blancos en exceso.
        let strNombre =
            outletNombre.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let strFlex =
            outletFlex.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let strCooper =
            outletCooper.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let strLagartijas =
            outletLagartijas.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let strAbs =
            outletAbs.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        // Valida los datos y guarda al usuario.
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
    
    //------------------------------------------------------------------------------------------------------------------
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Agrega el tap gesture para quitar el teclado.
        self.hideKeyboardWhenTappedAround()
    }

    //------------------------------------------------------------------------------------------------------------------
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
