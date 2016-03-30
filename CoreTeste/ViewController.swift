//
//  ViewController.swift
//  CoreTeste
//
//  Created by Athila Zuma on 12/11/15.
//  Copyright © 2015 Hangout Ltda. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var edit: UITextField!
    
    @IBAction func btnSave(sender: AnyObject) {
        let appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context:NSManagedObjectContext = appDel.managedObjectContext
        
        let newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context) as NSManagedObject
        newUser.setValue(txtUsername.text, forKey: "username")
        newUser.setValue(txtPassword.text, forKey: "password")
        newUser.setValue("Macho", forKey: "sexo")
        try! context.save()
        print(newUser)
        print("salvo")
        
    }
    
    
    
    
    @IBAction func btnApagar(sender: AnyObject) {
        deleteIncidents()
    
        
    }
    
    func deleteIncidents() {
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDel.managedObjectContext
        let coord = appDel.persistentStoreCoordinator
        
        let fetchRequest = NSFetchRequest(entityName: "Users")//
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try coord.executeRequest(deleteRequest, withContext: context)
        } catch let error as NSError {
            debugPrint(error)
        }
    }
    
    
    
    
    @IBAction func btnLoad(sender: AnyObject) {
        let appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context:NSManagedObjectContext = appDel.managedObjectContext
        
        let request = NSFetchRequest(entityName: "Users")
        request.returnsObjectsAsFaults = false
        
        var results: [AnyObject]?
        do {
            results = try context.executeFetchRequest(request)
        } catch _ {
            results = nil
        }
        
        if results!.count > 0 {
            
            let total = results!.count
            
            for (var i = 0;i < total;++i){
                let result = results![i]
                if let username: String = result.valueForKey("username") as? String {
                    print("username[\(i)]: \(username)")
                    txtUsername.text = username
                    //    context.deleteObject(result as! NSManagedObject)
                    do {
                        try context.save()
                    } catch _ {
                    }
                }
                
                if let password: String = result.valueForKey("password") as? String {
                    print("password[\(i)]: \(password)")
                    txtPassword.text = password
                    //    context.deleteObject(result as! NSManagedObject)
                    
                    do {
                        try context.save()
                    } catch _ {
                    }
                    
                }
                
                
                if let sexo: String = result.valueForKey("sexo") as? String {
                    print("sexo[\(i)]: \(sexo)")
                    //    context.deleteObject(result as! NSManagedObject)
                    
                    do {
                        try context.save()
                    } catch _ {
                    }
                    
                }
            }
            
        } else {
            
            print("Sem resultados")
            
        }
        
    }
    
    let usuario = users(username: "Athila", sexo: "Macho", password: "123")
    
    func removeData(userName: String) {
        var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context: NSManagedObjectContext = appDel.managedObjectContext
        
        var fetchRequest = NSFetchRequest(entityName: "Users")
        fetchRequest.predicate = NSPredicate(format: "username = %@", userName)
        
        if let fetchResults = try! appDel.managedObjectContext.executeFetchRequest(fetchRequest) as? [NSManagedObject] {
            if fetchResults.count != 0{
                
                var managedObject = fetchResults[0]
                context.deleteObject(managedObject)
                appDel.saveContext()
                //try! context.save()
            }
        }
    }
    
    @IBAction func btnRemover(sender: AnyObject) {
        removeData(txtUsername.text!)
        
        /*let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let moc = appDelegate.managedObjectContext
        
        // 3
        //moc.deleteObject(0)
        appDelegate.saveContext()*/
    }
    
    func buscaData(userName: String) {
        var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context: NSManagedObjectContext = appDel.managedObjectContext
        
        var fetchRequest = NSFetchRequest(entityName: "Users")
        fetchRequest.predicate = NSPredicate(format: "username = %@", userName)
        
        if let fetchResults = try! appDel.managedObjectContext.executeFetchRequest(fetchRequest) as? [NSManagedObject] {
            if fetchResults.count != 0{
                var managedObject = fetchResults[0]
                if let username: String = managedObject.valueForKey("username") as? String {
                    print("username[busca]: \(username)")
                    do {
                        try context.save()
                    } catch _ {
                    }
                }
                if let password: String = managedObject.valueForKey("password") as? String {
                    print("password[busca]: \(password)")
                    do {
                        try context.save()
                    } catch _ {
                    }
                }
                if let sexo: String = managedObject.valueForKey("sexo") as? String {
                    print("sexo[busca]: \(sexo)")
                    do {
                        try context.save()
                    } catch _ {
                    }
                }
            }
        }
    }
    
    @IBAction func btnBusca(sender: AnyObject) {
        buscaData(txtUsername.text!)
        
        
        /*let appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context:NSManagedObjectContext = appDel.managedObjectContext
        
        let request = NSFetchRequest(entityName: "Users")
        let predicate = NSPredicate(format: "username == Lili")
        request.predicate = predicate
        request.returnsObjectsAsFaults = false
        
        var results: [AnyObject]?
        do {
            results = try context.executeFetchRequest(request)
            
        } catch _ {
            results = nil
        }
        
        
        if results!.count > 0 {
            
            let total = results!.count
            
            for (var i = 0;i < total;++i){
                let result = results![i]
                if let username: String = result.valueForKey("username") as? String {
                    print("username[\(i)]: \(username)")
                    txtUsername.text = username
                    //    context.deleteObject(result as! NSManagedObject)
                    do {
                        try context.save()
                    } catch _ {
                    }
                }
                
                if let password: String = result.valueForKey("password") as? String {
                    print("password[\(i)]: \(password)")
                    txtPassword.text = password
                    //    context.deleteObject(result as! NSManagedObject)
                    
                    do {
                        try context.save()
                    } catch _ {
                    }
                    
                }
                
                
                if let sexo: String = result.valueForKey("sexo") as? String {
                    print("sexo[\(i)]: \(sexo)")
                    //    context.deleteObject(result as! NSManagedObject)
                    
                    do {
                        try context.save()
                    } catch _ {
                    }
                    
                }
            }
            
        } else {
            
            print("Sem resultados")
            
        }*/
    }
    
    @IBAction func btnAtualizar(sender: AnyObject) {
        saveLoginData("Femea", userName: "Lili")

    }
    
    
    func saveLoginData(Sexo: String, userName: String) {
        var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context: NSManagedObjectContext = appDel.managedObjectContext
        
        var fetchRequest = NSFetchRequest(entityName: "Users")
        fetchRequest.predicate = NSPredicate(format: "username = %@", userName)
        
        if let fetchResults = try! appDel.managedObjectContext.executeFetchRequest(fetchRequest) as? [NSManagedObject] {
            if fetchResults.count != 0{
                
                var managedObject = fetchResults[0]
                managedObject.setValue(Sexo, forKey: "sexo")
                //managedObject.setValue("Femea", forKey: "sexo")
                try! context.save()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

