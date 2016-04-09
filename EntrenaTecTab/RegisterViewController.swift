//
//  RegisterViewController.swift
//  EntrenaTecTab
//
//  Created by Alex De la Rosa on 04/04/16.
//  Copyright © 2016 Alejandro Henkel. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController
{
    @IBOutlet weak var outletNombre: UITextField!
    @IBOutlet weak var outletBrazo: UITextField!
    @IBOutlet weak var outletPecho: UITextField!
    @IBOutlet weak var outletHombro: UITextField!
    @IBOutlet weak var outletPierna: UITextField!
    @IBOutlet weak var outletLagartijas: UITextField!
    @IBOutlet weak var outletAbs: UITextField!
    
    @IBAction func confirmarDatos(sender: UIButton)
    {
        
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
