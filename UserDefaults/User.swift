//
//  User.swift
//  UserDefaults
//
//  Created by Vlad Zinevich on 11.09.2021.
//

import Foundation

struct User: Encodable, Decodable {
    var name = "User"
    var surname = "Name"
    
    var encoded: Data? {
        let encoder = PropertyListEncoder()
        return try? encoder.encode(self)
    }
    
    init? (from data: Data) {
        let decoder = PropertyListDecoder()
        guard let user = try? decoder.decode(User.self, from: data) else { return nil }
        
        name = user.name
        surname = user.surname
    }
    
    init() {}
}
