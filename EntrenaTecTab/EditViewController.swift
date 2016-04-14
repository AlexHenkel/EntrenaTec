//
//  EditViewController.swift
//  EntrenaTecTab
//
//  Created by Javier Guajardo on 4/12/16.
//  Copyright © 2016 Alejandro Henkel. All rights reserved.
//

import UIKit
import RealmSwift

class EditViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource
{
    
    @IBOutlet weak var outletPicker: UIPickerView!
    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tfCooper: UITextField!
    @IBOutlet weak var tfLagartijas: UITextField!
    @IBOutlet weak var tfFlex: UITextField!
    @IBOutlet weak var tfAbs: UITextField!
    
    var strNombre: String!
    var strCooper: String!
    var strLagartijas: String!
    var strFlex: String!
    var strAbs: String!
    var strLevel: String!
    
    @IBOutlet weak var tapCancelar: UIButton!
    var pickerData: [String] = [String]()
    
    
    @IBAction func tapGuardas(sender: AnyObject)
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        let user = defaults.stringForKey("studentId")!
        
        let realm = try! Realm()
        
        let student = realm.objects(User).filter("strStudentID == %@", user).first
        
        try! realm.write
        {
            student!.strLevel = self.pickerData[outletPicker.selectedRowInComponent(0)]
        }
        
        // Saca los datos del outlet quitandole blancos en exceso.
        let strNombre = tfNombre.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let strFlex = tfFlex.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let strCooper = tfCooper.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let strLagartijas = tfLagartijas.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let strAbs = tfAbs.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        if strNombre != "" && strFlex != "" && strCooper != "" && strLagartijas != "" && strAbs != ""
        {
            try! realm.write
            {
                student!.strName = strNombre
                student!.intFlex1 = Int(strFlex)!
                student!.doubleCooper1 = Double(strCooper)!
                student!.intPushups1 = Int(strLagartijas)!
                student!.intAbs1 = Int(strAbs)!
            }
            
            let viewController = self.storyboard!.instantiateViewControllerWithIdentifier("TabBar")
            self.presentViewController(viewController, animated: true, completion: nil)
        }
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Conectar Datos
        self.outletPicker.delegate = self
        self.outletPicker.dataSource = self
        
        //Agregar Datos al Arreglo para el Picker
        pickerData = ["Principiante", "Intermedio", "Avanzado"]
        
        self.loadData()
    }
    
    func loadData()
    {
        //Carga los datos actuales
        self.tfNombre.text = self.strNombre
        self.tfCooper.text = self.strCooper
        self.tfLagartijas.text = self.strLagartijas
        self.tfFlex.text = self.strFlex
        self.tfAbs.text = self.strAbs
        
        //Selecciona el dato correcto en el picker.
        switch self.strLevel
        {
        case "Principiante":
            self.outletPicker.selectRow(0, inComponent: 0, animated: true)
        case "Intermedio":
            self.outletPicker.selectRow(1, inComponent: 0, animated: true)
        case "Avanzado":
            self.outletPicker.selectRow(2, inComponent: 0, animated: true)
        default:
            break
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return pickerData[row]
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
