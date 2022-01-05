//
//  File.swift
//  
//
//  Created by Shaw Young on 2021/12/25.
//
import SwiftUI

final class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    
    @MainActor
    func fetchUsers() async throws {
        guard let url = URL(string: (UserDefaults.standard.object(forKey: "address") == nil ? BaseURL.base.rawValue : UserDefaults.standard.object(forKey: "address") as! String) + EndPoints.getUsers.rawValue) else {
            throw HttpErrors.badUrl
        }
        users = try await fetch(url: url)
//        print(users)
    }
    
    func updateUser(id: Int, name: String, gender: String, phone: String, role: Int, password: String) async throws {
        guard let url = URL(string: (UserDefaults.standard.object(forKey: "address") == nil ? BaseURL.base.rawValue : UserDefaults.standard.object(forKey: "address") as! String) + EndPoints.updateUser.rawValue) else {
            throw HttpErrors.badUrl
        }
        var map: [String: Any] = [:]
        map["user_id"] = id
        map["user_name"] = name
        map["user_gender"] = gender
        map["user_phone"] = phone
        map["user_role"] = role
        map["user_password"] = password
        let jsonData = try JSONSerialization.data(withJSONObject: map, options: [])
        try await sendData(url: url, json: jsonData, method: HttpMethods.PUT.rawValue)
    }
    
    
    func filter(keyWord: String) -> [User] {
        return users.filter { user in
            user.name.contains(keyWord) || user.phone.contains(keyWord)
        }
    }
}
