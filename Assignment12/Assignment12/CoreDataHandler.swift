//
//  CoreDataHandler.swift
//  MyCoreData
//
//  Created by DCS on 16/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//
import UIKit
import Foundation
import CoreData

class CoreDataHandler {
    
    static let shared = CoreDataHandler()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let manageObjectContext: NSManagedObjectContext?
    
    private init() {
        manageObjectContext = appDelegate.persistentContainer.viewContext
    }
    
    func save() {
        appDelegate.saveContext()
    }
    
    func insert(password: String, name:String, div:String, phone:String, email:String, completion: @escaping () -> Void) {
        let std = Student(context: manageObjectContext!)
        std.password = password
        std.name = name
        std.div = div
        std.phone = phone
        std.email = email
        save()
        completion()
    }
    
    func update(std:Student, password: String, name:String, div:String, phone:String, email:String, completion: @escaping () -> Void) {
        std.name = name
        std.password = password
        std.name = name
        std.div = div
        std.phone = phone
        std.email = email
        save()
        completion()
    }
    
    func delete(std:Student, completion: @escaping () -> Void) {
        manageObjectContext!.delete(std)
        
        save()
        completion()
    }
    
    func fetch() -> [Student] {
        let fetchRequest:NSFetchRequest<Student> = Student.fetchRequest()
        
        do {
            let stdArray = try manageObjectContext?.fetch(fetchRequest)
            return stdArray!
        } catch {
            print(error)
            return [Student]()
        }
    
    }
    func chekLogin(email:String) -> Student {
        let fetchRequest:NSFetchRequest<Student> = Student.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email contains %@",email)
        do {
            let studArray = try manageObjectContext?.fetch(fetchRequest)
            return studArray![0]
        } catch {
            print(error)
            return Student()
        }
    }
    func fetchClassWise(sclass:String) -> [Student] {
        let fetchRequest:NSFetchRequest<Student> = Student.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "div contains %@",sclass)
        
        do {
            let studArray = try manageObjectContext?.fetch(fetchRequest)
            return studArray!
        } catch {
            print(error)
            return [Student]()
        }
    }
    func StudUpdatePwd(stud:Student, pwd: String,completion: @escaping () -> Void){
        stud.password = pwd
        save()
        completion()
    }
    func insertNotice( title:String,descriptions: String, completion: @escaping () -> Void) {
        let note = Notice(context: manageObjectContext!)
        note.title = title
        note.descriptions = descriptions
        
        save()
        completion()
    }
    
    func updateNotice(note:Notice, title:String,descriptions: String, completion: @escaping () -> Void) {
        note.title = title
        note.descriptions = descriptions
        
        save()
        completion()
    }
    
    func deleteNotice(note:Notice, completion: @escaping () -> Void) {
        manageObjectContext!.delete(note)
        
        save()
        completion()
    }
    
    func fetchNotice() -> [Notice] {
        print("Fetch Notice Function  called...")
        let fetchRequest:NSFetchRequest<Notice> = Notice.fetchRequest()
        
        do {
            let noteArray = try manageObjectContext?.fetch(fetchRequest)
            print(noteArray!)
            return noteArray!
        } catch {
            print(error)
            return [Notice]()
        }
        
    }
}
