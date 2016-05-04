//
//  HistoryViewController.swift
//  EntrenaTecTab
//
//  Created by Alex De la Rosa on 29/04/16.
//  Copyright © 2016 Alejandro Henkel. All rights reserved.
//

import UIKit
import RealmSwift
import MessageUI

class HistoryViewController: UIViewController, MFMailComposeViewControllerDelegate
{
    //------------------------------------------------------------------------------------------------------------------
    @IBOutlet weak var tvHistorial: UITextView!
    @IBOutlet weak var nombreAlumno: UILabel!
    @IBOutlet weak var matricula: UILabel!
    @IBOutlet weak var nivel: UILabel!
    
    //------------------------------------------------------------------------------------------------------------------
    func cargarHistorial()
    {
        // Carga todos los datos del alumno, todas las rutinas que ha realizado. De cada rutina pone fecha de inicio y
        //  término, que días el alumno completo la rutina y la lista de ejercicios que tiene la rutina.
        let defaults = NSUserDefaults.standardUserDefaults()
        let user = defaults.stringForKey("studentId")!
        
        let realm = try! Realm()
        
        let student = realm.objects(User).filter("strStudentID == %@", user).first
        
        if student != nil
        {
            self.nombreAlumno.text = student!.strName.uppercaseString
            self.matricula.text = student!.strStudentID.uppercaseString
            self.nivel.text = student!.strLevel.uppercaseString
            
            let dateFormatter: NSDateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            var strRoutines = ""
            
            for routine in student!.routines
            {
                strRoutines += "Rutina \(routine.intRoutineID + 1): \n\n"
                strRoutines += " \tFecha de inicio: \(dateFormatter.stringFromDate(routine.dateStart)) \n\n"
                if routine.dateEnd != nil
                {
                    strRoutines += "\tFecha de Termino: \(dateFormatter.stringFromDate(routine.dateEnd!)) \n\n"
                }
                else
                {
                    strRoutines += "\tFecha de Termino: ??? \n\n"
                }
                
                strRoutines += "\tAsistencia: \n"
                dateFormatter.dateFormat = "EEEE dd MMMM"
                for day in routine.days
                {
                    strRoutines += "\t\t \(dateFormatter.stringFromDate(day.date)) \n"
                }
                
                strRoutines += "\n"
                
                strRoutines += "\tEjercicios: \n"
                for exercise in routine.exercises
                {
                    strRoutines += "\t\t \(exercise.strDescription) \n"
                }
                
                strRoutines += "\n\n\n"
                
            }
            self.tvHistorial.text = strRoutines
        }
    }
    
    //------------------------------------------------------------------------------------------------------------------
    func textToSend() -> String
    {
        // Genera un string parecido al del metodo cargaHistorial, pero este incluye Tags HTML para mandarlo vía email.
        let defaults = NSUserDefaults.standardUserDefaults()
        let user = defaults.stringForKey("studentId")!
        
        let realm = try! Realm()
        
        let student = realm.objects(User).filter("strStudentID == %@", user).first
        
        if student != nil
        {
            var strDataToSend = "<p><strong>Nombre: </strong> \(student!.strName.capitalizedString)</p>"
            strDataToSend += "<p><strong>Matricula:</strong> \(student!.strStudentID.capitalizedString)</p>"
            strDataToSend += "<p><strong>Nivel:</strong> \(student!.strLevel.capitalizedString)</p>"
            
            let dateFormatter: NSDateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            
            for routine in student!.routines
            {
                strDataToSend += "<ul>"
                strDataToSend += "<li><p><strong>&emsp;Rutina \(routine.intRoutineID + 1):</strong></p>"

                strDataToSend += "<ul><li>Fecha de inicio: \(dateFormatter.stringFromDate(routine.dateStart))</li>"
                if routine.dateEnd != nil
                {
                    strDataToSend += "<li>Fecha de Termino: \(dateFormatter.stringFromDate(routine.dateEnd!))</li>"
                }
                else
                {
                    strDataToSend += "<li>Fecha de Termino: ???</li>"
                }
                
                strDataToSend += "<li>Asistencia:</li><ul>"
                dateFormatter.dateFormat = "EEEE dd MMMM"
                for day in routine.days
                {
                    strDataToSend += "<li>\(dateFormatter.stringFromDate(day.date))</li>"
                }
                
                strDataToSend += "</ul>"
                
                strDataToSend += "<li>Ejercicios:</li><ul>"
                for exercise in routine.exercises
                {
                    strDataToSend += "<li>\(exercise.strDescription)</li>"
                }
                
                strDataToSend += "</ul></ul></ul>"
                
            }
            return strDataToSend
        }
        
        return ""
    }
    
    //------------------------------------------------------------------------------------------------------------------
    @IBAction func sendEmail()
    {
        // Metodo que se encarga de mandar el mail del alumno a los entrenadores.
        if MFMailComposeViewController.canSendMail()
        {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            
            let defaults = NSUserDefaults.standardUserDefaults()
            let user = defaults.stringForKey("studentId")!
            let dateFormatter: NSDateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let today = dateFormatter.stringFromDate(NSDate())
            
            
            mail.setSubject("Reporte \(today) - \(user)")
            mail.setToRecipients(["alexdelarosacortes@gmail.com"])
            mail.setMessageBody(self.textToSend(), isHTML: true)
            presentViewController(mail, animated: true, completion: nil)
        }
    }
    
    //------------------------------------------------------------------------------------------------------------------
    // Metodo utilizado para quitar el mail composer.
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?)
    {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //------------------------------------------------------------------------------------------------------------------
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    //------------------------------------------------------------------------------------------------------------------
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(true)
        
        // Carga los datos del historial.
        self.cargarHistorial()
    }
    
    //------------------------------------------------------------------------------------------------------------------
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
}
