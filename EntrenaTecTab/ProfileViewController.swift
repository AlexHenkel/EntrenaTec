//
//  ProfileViewController.swift
//  EntrenaTecTab
//
//  Created by Alex De la Rosa on 05/04/16.
//  Copyright © 2016 Alejandro Henkel. All rights reserved.
//

import UIKit
import RealmSwift

class ProfileViewController: UIViewController
{
    //------------------------------------------------------------------------------------------------------------------
    @IBOutlet weak var outletNombre: UILabel!
    @IBOutlet weak var outletNivel: UILabel!
    @IBOutlet weak var outletImagen: UIImageView!
    @IBOutlet weak var outletCooperPerfil: UILabel!
    @IBOutlet weak var outletFlexPerfil: UILabel!
    @IBOutlet weak var outletLagartijasPerfil: UILabel!
    @IBOutlet weak var outletAbsPerfil: UILabel!
    
    
    //------------------------------------------------------------------------------------------------------------------
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    //==================================================================================================================
    // MARK: - Show Profile Data
    
    //------------------------------------------------------------------------------------------------------------------
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Carga los datos del perfil
        self.LoadProfile()
    }
    
    //------------------------------------------------------------------------------------------------------------------
    func LoadProfile()
    {
        // Carga los datos del usuario de la Base de Datos.
        let defaults = NSUserDefaults.standardUserDefaults()
        let user = defaults.stringForKey("studentId")!
        
        let realm = try! Realm()
        
        let student = realm.objects(User).filter("strStudentID == %@", user)
        
        if student.count > 0
        {
            self.outletNombre.text = student[0].strName.uppercaseString
            self.outletNivel.text = student[0].strLevel.uppercaseString
            self.outletCooperPerfil.text = String(format:"%0.2f", student[0].doubleCooper1)
            self.outletFlexPerfil.text = String(student[0].intFlex1)
            self.outletLagartijasPerfil.text = String(student[0].intPushups1)
            self.outletAbsPerfil.text = String(student[0].intAbs1)
        }
    }
    
    //==================================================================================================================
    // MARK: - Navigation
    
    //------------------------------------------------------------------------------------------------------------------
    @IBAction func unwind(sender: UIStoryboardSegue)
    {
        // Metodo que se ejecuta para regresar de la vista de Edit Profile.
    }
    
    //------------------------------------------------------------------------------------------------------------------
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        let view = segue.destinationViewController as! EditViewController
        view.strLevel = self.outletNivel.text?.capitalizedString
        view.strNombre = self.outletNombre.text
        view.strCooper = self.outletCooperPerfil.text
        view.strFlex = self.outletFlexPerfil.text
        view.strLagartijas = self.outletLagartijasPerfil.text
        view.strAbs = self.outletAbsPerfil.text
    }
}
