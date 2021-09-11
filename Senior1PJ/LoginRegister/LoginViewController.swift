//
//  LoginViewController.swift
//  Senior1PJ
//
//  Created by Krittamet Chuwongworaphinit on 2/6/2564 BE.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet var usernameTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    var dataJ = [String:Any]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initializeHideKeyboard()
    }
    
    @IBAction func btnLoginClick(_ sender: UIButton) {
        guard let username = usernameTF.text else { return }
        guard let password = passwordTF.text else { return }
        let modelLogin = LoginModel(login: username, password: password)
        APIManager.shareInstance.callingLoginAPI(login: modelLogin ) { (result) in
            switch result {
            case .success(let json):
                print(json)
                let name = (json as! ResponseModel).name
                let email = (json as! ResponseModel).email
                
                
//                let email = (json as AnyObject).value(forKey: "email") as! String
//                let name = (json as AnyObject).value(forKey: "name") as! String
//                let modelLoginResponse = LoginResponseModel(name: name, email: email)
//                print(modelLoginResponse)
                let vc = self.storyboard?.instantiateViewController(identifier: "basetabbarcontroller") as! BaseTabBarController
                self.present(vc, animated: true, completion: nil)

                
                
//                self.showAlert(title: "Success", message: "wow")

            case.failure(let err):
                self.showAlert(title: "fail", message: err.localizedDescription)
                print(err.localizedDescription)
            }
            
        }
    }
    
    let urlLogin = "\(currentJSON)/api/v1/user/user-login"
    
    @IBAction func login(_ sender: Any) {
        
        let parameters: [String: Any] = [
            "username": usernameTF.text!,
            "password": passwordTF.text!,
//            "isFirst": true
        ]
        
        AF.request(urlLogin, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { response in
            print(response.response?.statusCode)
            
            switch response.result {
            case .success(let _):
                print("Insert successfully")
                print(response.value)
                
                if(response.response?.statusCode == 200) {
                    let jsondata = response.value as! [String:Any]?
                    self.dataJ = jsondata!
                    
                    currentUserId = self.dataJ["id"] as! Int
                    db_currentPass = self.dataJ["password"] as! String
                    currentProfile = self.dataJ["profileURL"] as! String
                    
                    var today = self.dataJ["todayDay"] as! String
                    
                    datetoday = reformat(str: String(today.dropLast(6)), toThis: "dd MMM yyyy")
                    print(datetoday)
                    
//                    let isFirst = self.dataJ["isFirst"] as! Bool
//                    print(isFirst)
                    
                    
//                    if isFirst == true {
//                        print("First")
//                        print(self.dataJ["isFirst"] as! Bool)
//
//
//                        let parameters2: [String: Any] = [
//                            "username": self.usernameTF.text!,
//                            "password": self.passwordTF.text!,
//                            "isFirst": false
//                        ]
//
//                        AF.request(self.urlLogin, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { response in
//
//                           print("I will VC")
//                            print("yo")
//                        })
//
//
//                    }
                    
                    print("Hi1")
//                    print(isFirst)
                    let vc = self.storyboard?.instantiateViewController(identifier: "basetabbarcontroller") as! BaseTabBarController

                    self.present(vc, animated: true, completion: nil)
                    



                } else {
                    self.showAlert(title: "Wrong password", message: "Please try again")
                }

                
            case .failure(let error):
                print(error.errorDescription)
                
                let alert = UIAlertController(title: "Server Issue", message: "try again later", preferredStyle: .alert)
                
                let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
                
            }
        })
    }
    

    func initializeHideKeyboard(){
        //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        
        //Add this tap gesture recognizer to the parent view
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyboard(){
        //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
        //In short- Dismiss the active keyboard.
        view.endEditing(true)
    }

}
