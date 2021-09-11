//
//  APIManager.swift
//  Senior1PJ
//
//  Created by Krittamet Chuwongworaphinit on 10/6/2564 BE.
//

import Foundation
import Alamofire

enum APIErros: Error {
    case custom(message: String)
}

typealias Handler = (Swift.Result<Any?, APIErros>) -> Void

class APIManager {
    static let shareInstance = APIManager()

    func callingRegisterAPI(register: RegisterModel, completionHander: @escaping (Bool, String) -> ()) {
        let headers: HTTPHeaders = [.contentType("application/json")]

        AF.request(register_url, method: .post, parameters: register, encoder: JSONParameterEncoder.default, headers: headers).response {
            response in debugPrint(response)
            switch response.result {
            case.success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    if response.response?.statusCode == 200 {
                        completionHander(true, "User register succesfully")
                    }
                    if response.response?.statusCode == 400 {
                        completionHander(false, "Enter the email address in the form someone@example.com")
                    }
                    else {
                        print(response.response?.statusCode)
                        completionHander(false, "Please try again")
                    }
                } catch {
                    print(error.localizedDescription)
                    completionHander(false, "Please try again")
                }
            case .failure(let err):
                print(err.localizedDescription)
                completionHander(false, "Please try again")
            }
        }

    }
    
    func callingLoginAPI(login: LoginModel, completionHander: @escaping Handler) {
        let headers: HTTPHeaders = [.contentType("application/json")]

        AF.request(login_url, method: .post, parameters: login, encoder: JSONParameterEncoder.default, headers: headers).response {
            response in debugPrint(response)
            switch response.result {
            case.success(let data):
                do {
                    let json = try JSONDecoder().decode(ResponseModel.self, from: data!)
                    print(json)
//                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    if response.response?.statusCode == 200 {
//                        completionHander(true, "Register Successfully")

                        completionHander(.success(json))
                    } else {
//                        completionHander(false, "Please try again")
                        completionHander(.failure(.custom(message: "Please check your network connectivity")))
                    }
                } catch {
                    print(error.localizedDescription)
                    completionHander(.failure(.custom(message: "Please try again")))
                }
            case .failure(let err):
                print(err.localizedDescription)
                completionHander(.failure(.custom(message: "Please try again")))
            }
        }

    }
}
