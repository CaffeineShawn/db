//
//  File.swift
//  
//
//  Created by Shaw Young on 2021/12/25.
//
struct User: Codable {
    let gender: String
    let id: Int
    let name, password, phone: String

    enum CodingKeys: String, CodingKey {
        case gender = "user_gender"
        case id = "user_id"
        case name = "user_name"
        case password = "user_password"
        case phone = "user_phone"
    }
    

}
