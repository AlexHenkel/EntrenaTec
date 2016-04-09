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
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    // Guarda los ejercicios en la base de Datos
    func preloadData()
    {
        // Guarda los datos de Exercises.plist en un NSArray
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
    
    // Lee los ejercicios de un property list y regresa el NSArray con los datos.
    func loadExercises() -> NSArray
    {
        let path = NSBundle.mainBundle().pathForResource("Exercises", ofType: "plist")
        return NSArray(contentsOfFile: path!)!
    }
    
    // Carga la vista que corresponde. (Si el usuario está loggeado carga la vista del Tab Bar y sino carga el loging).
    func SetView()
    {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        var initViewController: UIViewController
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let isLoggedIn = defaults.boolForKey("isLoggedIn")
        if isLoggedIn
        {
            initViewController = storyBoard.instantiateViewControllerWithIdentifier("TabBar")
        }
        else
        {
            initViewController = storyBoard.instantiateViewControllerWithIdentifier("LogIn")
        }
        
        self.window = UIWindow.init(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = initViewController
        self.window?.makeKeyAndVisible()
    }
    
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
    
    func applicationWillResignActive(application: UIApplication)
    {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication)
    {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication)
    {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication)
    {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication)
    {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

