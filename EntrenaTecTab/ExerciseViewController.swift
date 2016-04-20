//
//  ExerciseViewController.swift
//  EntrenaTecTab
//
//  Created by Alex De la Rosa on 05/04/16.
//  Copyright © 2016 Alejandro Henkel. All rights reserved.
//

import UIKit

class ExerciseViewController: UIViewController
{
    //------------------------------------------------------------------------------------------------------------------
    @IBOutlet weak var outDescripcion: UILabel!
    @IBOutlet weak var outMaquina: UIImageView!
    @IBOutlet weak var outReps: UILabel!
    @IBOutlet weak var outGrupo: UILabel!
    
    //------------------------------------------------------------------------------------------------------------------
    @IBAction func actCompletado(sender: UIButton)
    {
        
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
