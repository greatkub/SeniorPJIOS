//
//  Login.swift
//  Senior1PJ
//
//  Created by Krittamet Chuwongworaphinit on 11/6/2564 BE.
//

import UIKit

struct LoginModel : Encodable {
    let login: String
    let password: String
}

struct LoginResponseModel {
    let name: String
    let email: String
}


