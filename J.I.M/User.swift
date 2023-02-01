//
//  User.swift
//  J.I.M
//
//  Created by Julian Manaois on 1/31/23.
//

import UIKit
import SwiftUI
import Foundation

public class User {
    var username: String
    var email: String
    var password: String

    init(username: String, email: String, password: String) {
        self.username = username
        self.email = email
        self.password = password
    }

    static func getLoggedInUser() -> User? {
        // get the user data from UserDefaults
        let username = UserDefaults.standard.string(forKey: "username")
        let email = UserDefaults.standard.string(forKey: "email")
        let password = UserDefaults.standard.string(forKey: "password")

        // if all the data exists, return a User instance
        if let username = username, let email = email, let password = password {
            return User(username: username, email: email, password: password)
        }

        // otherwise, return nil
        return nil
    }
    
    static func saveUser(user: User) {
            let encodedUser = try? PropertyListEncoder().encode(user)
            UserDefaults.standard.set(encodedUser, forKey: "loggedInUser")
        }
}
