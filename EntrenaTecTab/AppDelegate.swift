//
//  AppDelegate.swift
//  EntrenaTecTab
//
//  Created by Alejandro Henkel on 3/30/16.
//  Copyright © 2016 Alejandro Henkel. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    
    var window: UIWindow?
    
    //==================================================================================================================
    // MARK: - Load Exercises.
    
    //------------------------------------------------------------------------------------------------------------------
    func preloadData()
    {
        // Guarda los ejercicios en la base de Datos.
        
        // Guarda los datos de Exercises.plist en un NSArray.
        let arrExercises = self.loadExercises()
        
        // Por cada elemento del NSArray, crea un objeto de tipo Exercise y lo guarda en Realm.
        for exercise in arrExercises
        {
            let exerciseToAdd = Exercise()
            exerciseToAdd.strExerciseID = String(exercise.objectForKey("ExerciseId")!)
            exerciseToAdd.strName = String(exercise.objectForKey("Name")!)
            exerciseToAdd.strDescription = String(exercise.objectForKey("Description")!)
            exerciseToAdd.strImageName = String(exercise.objectForKey("ImageName")!)
            exerciseToAdd.strMuscleGroup = String(exercise.objectForKey("MuscleGroup")!)
            
            let realm = try! Realm()
            try! realm.write
            {
                realm.add(exerciseToAdd)
            }
        }
    }
    
    //------------------------------------------------------------------------------------------------------------------
    func loadExercises() -> NSArray
    {
        // Lee los ejercicios de un property list y regresa el NSArray con los datos.
        let path = NSBundle.mainBundle().pathForResource("Exercises", ofType: "plist")
        return NSArray(contentsOfFile: path!)!
    }
    
    //==================================================================================================================
    // MARK: - Set Views.
    
    //------------------------------------------------------------------------------------------------------------------
    func SetView()
    {
        // Carga la vista que corresponde. (Si el usuario está loggeado carga la vista del Tab Bar y sino
        //  carga el loging).
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        var initViewController: UIViewController
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let isLoggedIn = defaults.boolForKey("isLoggedIn")
        let isRegistered = defaults.boolForKey("isRegistered")
        
        // Si el usuario ya está loggeado, checa si ya registró sus datos y manda a la vista
        //  correspondiente.
        if isLoggedIn
        {
            if isRegistered
            {
                initViewController = storyBoard.instantiateViewControllerWithIdentifier("TabBar")
            }
            else
            {
                initViewController = storyBoard.instantiateViewControllerWithIdentifier("Register")
            }
        }
        else
        {
            initViewController = storyBoard.instantiateViewControllerWithIdentifier("LogIn")
        }
        
        self.window = UIWindow.init(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = initViewController
        self.window?.makeKeyAndVisible()
    }
    
    // MARK: - App Methods.
    //------------------------------------------------------------------------------------------------------------------
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        // Override point for customization after application launch.
        let defaults = NSUserDefaults.standardUserDefaults()
        let isPreloaded = defaults.boolForKey("isPreloaded")
        if !isPreloaded
        {
            self.preloadData()
            defaults.setBool(true, forKey: "isPreloaded")
        }
        
        self.SetView()
        
        return true
    }
    
    //------------------------------------------------------------------------------------------------------------------
    func applicationWillResignActive(application: UIApplication)
    {

    }
    
    //------------------------------------------------------------------------------------------------------------------
    func applicationDidEnterBackground(application: UIApplication)
    {
        
    }
    
    //------------------------------------------------------------------------------------------------------------------
    func applicationWillEnterForeground(application: UIApplication)
    {

    }
    
    //------------------------------------------------------------------------------------------------------------------
    func applicationDidBecomeActive(application: UIApplication)
    {
        
    }
    
    //------------------------------------------------------------------------------------------------------------------
    func applicationWillTerminate(application: UIApplication)
    {
        
    }
}

