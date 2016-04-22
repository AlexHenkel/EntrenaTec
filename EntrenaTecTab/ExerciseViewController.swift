//
//  ExerciseViewController.swift
//  EntrenaTecTab
//
//  Created by Alex De la Rosa on 05/04/16.
//  Copyright © 2016 Alejandro Henkel. All rights reserved.
//

import UIKit
import RealmSwift

protocol ExerciseProtocol
{
    func popView()
}


class ExerciseViewController: UIViewController
{
    //------------------------------------------------------------------------------------------------------------------
    @IBOutlet weak var outDescripcion: UILabel!
    @IBOutlet weak var outMaquina: UIImageView!
    @IBOutlet weak var outReps: UILabel!
    @IBOutlet weak var outGrupo: UILabel!
    @IBOutlet weak var outletCompletado: UIButton!
    
    
    var exerciseToShow: Exercise!
    var delegado: ExerciseProtocol!
    
    //------------------------------------------------------------------------------------------------------------------
    @IBAction func actCompletado(sender: UIButton)
    {
        // Busca si el usuario tiene una rutina activa y la carga.
        let defaults = NSUserDefaults.standardUserDefaults()
        let user = defaults.stringForKey("studentId")!
        
        let realm = try! Realm()
        
        let student = realm.objects(User).filter("strStudentID == %@", user).first
        
        if student != nil
        {
            let routines = student!.routines
            print(routines)
            let activeRoutine = routines.filter("boolCompleted == %@", false).first
            if activeRoutine != nil
            {
                let strId = self.exerciseToShow.strExerciseID
                let exercise = (activeRoutine?.exercises)!.filter("strExerciseID == %@", strId).first
                try! realm.write
                    {
                        exercise!.boolCompletado = true
                }
                self.delegado.popView()
            }
        }

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
