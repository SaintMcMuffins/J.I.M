//
//  User.swift
//  J.I.M
//
//  Created by Julian Manaois on 1/31/23.

import CoreData
import UIKit

public class User: NSManagedObject, Encodable {
    
    @NSManaged public var username: String
    @NSManaged public var email: String
    @NSManaged public var password: String
    
    public init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?, username: String = "", email: String = "", password: String = "") {
        super.init(entity: entity, insertInto: context)
        self.username = username
        self.email = email
        self.password = password
    }
    
    public required init?(coder: NSCoder) {
        guard let username = coder.decodeObject(forKey: "username") as? String,
              let email = coder.decodeObject(forKey: "email") as? String,
              let password = coder.decodeObject(forKey: "password") as? String else {
            return nil
        }
        self.username = username
        self.email = email
        self.password = password
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(username, forKey: "username")
        coder.encode(email, forKey: "email")
        coder.encode(password, forKey: "password")
    }
    
    static func getLoggedInUser() -> User? {
        let request = NSFetchRequest<User>(entityName: "User")
        request.predicate = NSPredicate(format: "isLoggedIn == true")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        do {
            let users = try context.fetch(request)
            return users.first
        } catch {
            print("Error fetching logged in user: \(error)")
            return nil
        }
    }
    
    static func saveUser(user: User) {
        UserDefaults.standard.set(user.username, forKey: "username")
        UserDefaults.standard.set(user.email, forKey: "email")
        UserDefaults.standard.set(user.password, forKey: "password")
        
        let encodedUser = try? PropertyListEncoder().encode(user)
        UserDefaults.standard.set(encodedUser, forKey: "loggedInUser")
    }
}
