//
//  Friend.swift
//  PWD Drishti
//
//  Created by Aditya Sharma on 22/07/24.
//

import SwiftUI
struct Emp:Identifiable{
    var id: Int
    var empid: Int
    var name: String
    var age: Int
    var address: String
    var Position: String
    var Dateofjoining:String
}

struct User: Identifiable,Codable {
    let id: Int
    let email: String
    let first_name: String
    let last_name: String
    let avatar: String
}

struct Support: Codable {
    let url: String
    let text: String
}

struct ApiResponse: Codable {
    let page: Int
    let per_page: Int
    let total: Int
    let total_pages: Int
    let data: [User]
    let support: Support
}

struct APIResponse: Codable {
    let success: Int
    let data:[UserData]
}

struct UserData: Codable {
    let apiKey: String
    let mobile: String
    let roleId: Int
    let salt: String?
    let userId: Int
    let userName: String
    let userPassword: String
}

struct LoginRequest: Codable{
    let user_id:String
    let user_password:String
}
