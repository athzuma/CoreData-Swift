//
//  CoreDataFunções.swift
//  CoreTeste
//
//  Created by Athila Zuma on 30/03/16.
//  Copyright © 2016 Hangout Ltda. All rights reserved.
//

import Foundation
import CoreData
import UIKit

func ApagarTodaTabela(Tabela: String) {
    let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
    let context = appDel.managedObjectContext
    let coord = appDel.persistentStoreCoordinator
    
    let fetchRequest = NSFetchRequest(entityName: Tabela) //entityName: "Users"
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    
    do {
        try coord.executeRequest(deleteRequest, withContext: context)
    } catch let error as NSError {
        debugPrint(error)
    }
}

func removeData(Tabela: String, Valor: String) {
    let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    let context: NSManagedObjectContext = appDel.managedObjectContext
    
    let fetchRequest = NSFetchRequest(entityName: Tabela)
    fetchRequest.predicate = NSPredicate(format: "username = %@", Valor)
    
    if let fetchResults = try! appDel.managedObjectContext.executeFetchRequest(fetchRequest) as? [NSManagedObject] {
        if fetchResults.count != 0{
            
            let managedObject = fetchResults[0]
            context.deleteObject(managedObject)
            appDel.saveContext()
            //try! context.save()
        }
    }
}

func buscaData(Tabela: String, userName: String) {
    let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    let context: NSManagedObjectContext = appDel.managedObjectContext
    
    let fetchRequest = NSFetchRequest(entityName: Tabela)
    fetchRequest.predicate = NSPredicate(format: "username = %@", userName)
    
    if let fetchResults = try! appDel.managedObjectContext.executeFetchRequest(fetchRequest) as? [NSManagedObject] {
        if fetchResults.count != 0{
            let managedObject = fetchResults[0]
            if let username: String = managedObject.valueForKey("username") as? String {
                print("username: \(username)")
                do {
                    try context.save()
                } catch _ {
                }
            }
            if let password: String = managedObject.valueForKey("password") as? String {
                print("password: \(password)")
                do {
                    try context.save()
                } catch _ {
                }
            }
        }
    }
}

func AtualizaData(Tabela: String, password: String, userName: String) {
    let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    let context: NSManagedObjectContext = appDel.managedObjectContext
    
    let fetchRequest = NSFetchRequest(entityName: Tabela)
    fetchRequest.predicate = NSPredicate(format: "username = %@", userName)
    
    if let fetchResults = try! appDel.managedObjectContext.executeFetchRequest(fetchRequest) as? [NSManagedObject] {
        if fetchResults.count != 0{
            
            let managedObject = fetchResults[0]
            managedObject.setValue(password, forKey: "password")
            try! context.save()
        }
    }
}


func InserirData(Tabela: String, username: String, password: String) {
    let appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    let context:NSManagedObjectContext = appDel.managedObjectContext
    
    let newUser = NSEntityDescription.insertNewObjectForEntityForName(Tabela, inManagedObjectContext: context) as NSManagedObject
    newUser.setValue(username, forKey: "username")
    newUser.setValue(password, forKey: "password")
    try! context.save()
}