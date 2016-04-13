//
//  EditViewController.swift
//  EntrenaTecTab
//
//  Created by Javier Guajardo on 4/12/16.
//  Copyright © 2016 Alejandro Henkel. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var outletPicker: UIPickerView!
    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tfCooper: UITextField!
    @IBOutlet weak var tfLagartijas: UITextField!
    @IBOutlet weak var tfFlex: UITextField!
    @IBOutlet weak var tfAbs: UITextField!
    
    @IBOutlet weak var tapCancelar: UIButton!
    var pickerData: [String] = [String]()
    
    
    @IBAction func tapGuardas(sender: AnyObject) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        //Conectar Datos
        self.outletPicker.delegate = self
        self.outletPicker.delegate = self
        
        //Agregar Datos al Arreglo para el Picker
        pickerData = ["Principiante", "Intermedio", "Avanzado"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
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
