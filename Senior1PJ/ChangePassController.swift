//
//  ChangePassController.swift
//  Senior1PJ
//
//  Created by Krittamet Chuwongworaphinit on 16/8/2564 BE.
//

import UIKit
import Alamofire

class ChangePassController: UIViewController {

   
    @IBOutlet var currentpass_TF: UITextField!
    @IBOutlet var newPass_TF: UITextField!
    @IBOutlet var confirmpass_TF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)

        self.dismiss(animated: true)
    }
  
    let urlchangepass = "\(currentJSON)/api/v1/mobile/change-password/\(currentUserId)"
    
    @IBAction func changePass_bt(_ sender: Any) {
        
        let parameters: [String: Any] = [
            "id": currentUserId,
            "password": newPass_TF.text!
        ]
        if(currentpass_TF.text == db_currentPass && newPass_TF.text == confirmpass_TF.text) {
            print("current pass and db pass is collect")
            AF.request(urlchangepass, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { response in
                print(response.response?.statusCode)
                
                self.showAlert(title: "Succesfully", message: "Your password has been changed")

////                switch response.result {
////                case .success(let _):
////                    print("Insert successfully")
////                    print(response.value)
////
////
////                    if(response.response?.statusCode == 200) {
////
////                        self.showAlert(title: "Succesfully", message: "Your password has been changed")
////
////
////
////
////                    } else {
////                        self.showAlert(title: "Server problem", message: "Please try again later")
////                    }
////
////
////                case .failure(let error):
////                    print(error.errorDescription)
////
////                    let alert = UIAlertController(title: "Invalid ", message: "Please check your password again", preferredStyle: .alert)
////
////                    let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
////                    alert.addAction(alertAction)
////                    self.present(alert, animated: true, completion: nil)
////
////                }
            })
//        } else {
//            showAlert(title: "Password Doesn't match", message: "Please try again")
        } else {
            showAlert(title: "Invalid password", message: "Please try again")
        }
                
       
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
