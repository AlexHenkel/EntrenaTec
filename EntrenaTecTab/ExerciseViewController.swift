//
//  ExerciseViewController.swift
//  EntrenaTecTab
//
//  Created by Alex De la Rosa on 05/04/16.
//  Copyright © 2016 Alejandro Henkel. All rights reserved.
//

import UIKit
import RealmSwift

class ExerciseViewController: UIViewController
{
    //------------------------------------------------------------------------------------------------------------------
    @IBOutlet weak var outDescripcion: UILabel!
    @IBOutlet weak var outMaquina: UIImageView!
    @IBOutlet weak var outReps: UILabel!
    @IBOutlet weak var outGrupo: UILabel!
    
    var exerciseToShow: Exercise!
    
    //------------------------------------------------------------------------------------------------------------------
    @IBAction func actCompletado(sender: UIButton)
    {
        
    }
    
    //------------------------------------------------------------------------------------------------------------------
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = self.exerciseToShow.strName.uppercaseString
        self.outDescripcion.text = self.exerciseToShow.strDescription.uppercaseString
        self.outGrupo.text = self.exerciseToShow.strMuscleGroup.uppercaseString
        self.outMaquina.image = UIImage(named: self.exerciseToShow.strImageName)
        
    }

    //------------------------------------------------------------------------------------------------------------------
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
