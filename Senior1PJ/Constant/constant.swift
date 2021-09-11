//
//  constant.swift
//  Senior1PJ
//
//  Created by Krittamet Chuwongworaphinit on 10/6/2564 BE.
//

import Foundation
import SwiftUI

let app_id = "B0E94E2F-8183-24D2-FF2C-A3B9F27D2B00"
let rest_key = "02BDBFE4-DD05-4CAD-96AF-971D184C4870"
let base_url = "https://api.backendless.com/\(app_id)/\(rest_key)/users/"
let register_url = "\(base_url)register"
let login_url = "\(base_url)login"

//public func showAlert(title: String,message: String) {
//    let alert = UIAlertController(title: title,
//                                  message: message,
//                                  preferredStyle: .alert)
//    self.present(alert, animated: true, completion: nil)
//}
extension UIViewController {
  func showAlert(title: String, message: String) {
    let alertController = UIAlertController(title: title, message:
      message, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
    }))
    self.present(alertController, animated: true, completion: nil)
  }
}
