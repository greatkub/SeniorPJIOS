//
//  RegisterModel.swift
//  Senior1PJ
//
//  Created by Krittamet Chuwongworaphinit on 10/6/2564 BE.
//

import Foundation

struct RegisterModel: Encodable {
    let name: String
    let email: String
    let password: String
    let gender: String
    let bank: String
    
    let bankAcc: String
    let phone: String
    let phoneEmergency: String
    let birthdate: String
    let username: String
}

struct ResponseModel: Codable {
    let lastLogin: Int
    let userStatus: String
    let created: Int
    let ownerID, socialAccount: String
    let name, welcomeClass, blUserLocale, userToken: String
//    let updated: JSONNull?
    let email, objectID: String
    let gender: String
    let bank: String
    let bankAcc: String
    let phone: String
    let phoneEmergency: String
    let birthdate: String
    let username: String



    enum CodingKeys: String, CodingKey {
        case lastLogin, userStatus, created
        case gender
        case ownerID = "ownerId"
        case socialAccount, name
        case welcomeClass = "___class"
        case blUserLocale
        case userToken = "user-token"
        case email, bank, bankAcc, phone, phoneEmergency, birthdate
        case username
        case objectID = "objectId"
    }
}

