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
        InserirData("Users", username: txtUsername.text!, password: txtPassword.text!)
    }
    
    @IBAction func btnApagar(sender: AnyObject) {
        ApagarTodaTabela("Users")
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
                
            }
            
        } else {
            
            print("Sem resultados")
            
        }
        
    }
    
    
    @IBAction func btnRemover(sender: AnyObject) {
        removeData("Users", Valor: txtUsername.text!)
        print(txtUsername.text!)
    }
    
    
    
    @IBAction func btnBusca(sender: AnyObject) {
        buscaData("Users", userName: txtUsername.text!)
    }
    
    @IBAction func btnAtualizar(sender: AnyObject) {
        AtualizaData("Users", password: txtPassword.text!, userName: txtUsername.text!)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

