//
//  StorageManager.swift
//  UserDefaults
//
//  Created by Vlad Zinevich on 11.09.2021.
//

import Foundation

class StorageManager {
    static let shared = StorageManager()
    
    private var user = User()
    private let defaults = UserDefaults.standard
    
    private let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    private var archiveURL: URL!
    
    init() {
        archiveURL = documentDirectory.appendingPathComponent("User").appendingPathExtension("plist")
    }
    
    func getUser() -> User {
        guard let savedUser = defaults.object(forKey: "savedUser") as? Data else { return user }
        guard let loadedUser = try? JSONDecoder().decode(User.self, from: savedUser) else { return user }
        user = loadedUser
        return user
    }
    
    func saveUser(_ user: User) {
        guard let userEncoded = try? JSONEncoder().encode(user) else { return }
        defaults.set(userEncoded, forKey: "savedUser")
    }
    
    func saveUserToFile(_ user: User) {
        let encoder = PropertyListEncoder()
        guard let encodedUser = try? encoder.encode(user) else { return }
        try? encodedUser.write(to: archiveURL, options: .noFileProtection)
    }
    
    func getUserFromFile() -> User {
        guard let savedUser = try? Data(contentsOf: archiveURL) else { return user }
        let decoder = PropertyListDecoder()
        guard let loadedUser = try? decoder.decode(User.self, from: savedUser) else { return user }
        user = loadedUser
        return user
    }
}
