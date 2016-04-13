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

    @IBOutlet weak var outletNombre: UILabel!
    @IBOutlet weak var outletNivel: UILabel!
    @IBOutlet weak var outletImagen: UIImageView!
    @IBOutlet weak var outletCooperPerfil: UILabel!
    @IBOutlet weak var outletFlexPerfil: UILabel!
    @IBOutlet weak var outletLagartijasPerfil: UILabel!
    @IBOutlet weak var outletAbsPerfil: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Carga los datos del perfil
        self.LoadProfile()
    }
    
    
    func LoadProfile()
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        let user = defaults.stringForKey("studentId")!
        
        let realm = try! Realm()
        
        let student = realm.objects(User).filter("strStudentID == %@", user)
        
        if student.count > 0
        {
            self.outletNombre.text = student[0].strName
            self.outletNivel.text = student[0].strLevel
            self.outletCooperPerfil.text = String(format:"%0.2f", student[0].doubleCooper1)
            self.outletFlexPerfil.text = String(student[0].intFlex1)
            self.outletLagartijasPerfil.text = String(student[0].intPushups1)
            self.outletAbsPerfil.text = String(student[0].intAbs1)
        }
        
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
