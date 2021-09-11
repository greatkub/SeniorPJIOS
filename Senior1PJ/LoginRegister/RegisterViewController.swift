//
//  RegisterViewController.swift
//  Senior1PJ
//
//  Created by Krittamet Chuwongworaphinit on 2/6/2564 BE.
//

import UIKit

class RegisterViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
   



    @IBOutlet var firstnameTF: UITextField!
    @IBOutlet var backgroundSV: UIScrollView!
    @IBOutlet var lastnameTF: UITextField!
    @IBOutlet var bankNameTF: UITextField!
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var phoneTF: UITextField!
    @IBOutlet var emergencyTF: UITextField!
    @IBOutlet var birthDateTF: UITextField!
    @IBOutlet var GenderTF: UITextField!
    @IBOutlet var userNameTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var cf_passwordTF: UITextField!
    @IBOutlet var banckAccountTF: UITextField!
    let datePicker = UIDatePicker()
    let pickerView = UIPickerView()
   
    let genders = ["Male", "Female"]
    let banks = ["Siam Commercial Bank", "Kasikornbank", "Bangkok Bank", "Krung Thai Bank"
                 , "Bank of Ayudhya"]
    var selectedTextField = UITextField()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Subscribe to a Notification which will fire before the keyboard will show
        subscribeToNotification(UIResponder.keyboardWillShowNotification, selector: #selector(keyboardWillShowOrHide))
        
        //Subscribe to a Notification which will fire before the keyboard will hide
        subscribeToNotification(UIResponder.keyboardWillHideNotification, selector: #selector(keyboardWillShowOrHide))
        
        //We make a call to our keyboard handling function as soon as the view is loaded.
        initializeHideKeyboard()
        createDatePicker()
        createPicker(TF: GenderTF)
        createPicker(TF: bankNameTF)
        
        //to make textFieldShouldBeginEditing -> Work
        GenderTF.delegate = self
        bankNameTF.delegate = self

    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        selectedTextField = textField
        pickerView.reloadAllComponents()
        pickerView.isHidden = false
        return true
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if selectedTextField == GenderTF {
            return genders.count
        } else {
            return banks.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if selectedTextField == GenderTF {
            return genders[row]
        } else {
            return banks[row]
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if selectedTextField == GenderTF {
            GenderTF.text = genders[row]
        } else {
            bankNameTF.text = banks[row]
        }
    }
    
    func createPicker(TF: UITextField!) {
        
        pickerView.dataSource = self
        pickerView.delegate = self
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(dPressed))
        toolbar.setItems([doneBtn], animated: true)
        // assign toolbar
        
        TF.inputAccessoryView = toolbar
        //assign data picker to the text field
        TF.inputView = pickerView
    

    }
    
    
    @objc func dPressed() {

        self.view.endEditing(true)
    }
    
    func createDatePicker() {
        
//        birthDateTF.textAlignment = .center
        datePicker.preferredDatePickerStyle = .wheels
        
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        // assign toolbar
        birthDateTF.inputAccessoryView = toolbar
        
        //assign data picker to the text field
        birthDateTF.inputView = datePicker
        
        // date picker mode
        datePicker.datePickerMode = .date
        Locale(identifier: "en_US")
        
        
    }
    

    
    @objc func donePressed() {
        //formatter
        let formater = DateFormatter()
        formater.dateStyle = .medium
        formater.timeStyle = .none
        formater.locale = Locale(identifier: "en_us")
//        formater.setLocalizedDateFormatFromTemplate("MM-dd-yyyy")
        birthDateTF.text = formater.string(from: datePicker.date)

        
        self.view.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //Unsubscribe from all our notifications
        unsubscribeFromAllNotifications()
    }
    
    @IBOutlet var profile_image: UIImageView!
    @IBAction func addimage_bt(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    
    @IBAction func btnSaveClick(_ sender: UIButton) {
        guard let fname = self.firstnameTF.text else { return  }
        guard let lname = self.lastnameTF.text else {return }
        guard let email = self.emailTF.text else {return }
        guard let password = self.passwordTF.text else {return }
        guard let cf_password = self.cf_passwordTF.text else {return}
        guard let gender = self.GenderTF.text else {return}
        guard let bank = self.bankNameTF.text else {return}
        guard let bankAcc = self.banckAccountTF.text else {return}
        guard let phone = self.phoneTF.text else {return}
        guard let phoneEmergency = self.emergencyTF.text else {return}
        guard let birthDate = self.birthDateTF.text else {return}
        guard let userName = self.userNameTF.text else {return}


        
        
        let register = RegisterModel(name: fname + lname,
                                     email: email,
                                     password: password,
                                     gender: gender,
                                     bank: bank,
                                     bankAcc: bankAcc,
                                     phone: phone,
                                     phoneEmergency: phoneEmergency,
                                     birthdate: birthDate,
                                     username: userName)
        
        if password != cf_password {
            
            showAlert(title: "Alert", message: "confirmation password does not match")
            
        } else {
            
            APIManager.shareInstance.callingRegisterAPI(register: register){
                (isSuccess, str) in
                if isSuccess {
                    self.showAlert(title: "Alert", message: str)
                } else {
                    self.showAlert(title: "Alert", message: str)
                }
            }
            
        }
    }
    

}
extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            profile_image.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}


extension RegisterViewController {
    
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

extension RegisterViewController {
    
    func subscribeToNotification(_ notification: NSNotification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: notification, object: nil)
    }
    
    func unsubscribeFromAllNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShowOrHide(notification: NSNotification) {
        // Get required info out of the notification
        if let scrollView = backgroundSV, let userInfo = notification.userInfo, let endValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey], let durationValue = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey], let curveValue = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] {
            
            // Transform the keyboard's frame into our view's coordinate system
            let endRect = view.convert((endValue as AnyObject).cgRectValue, from: view.window)
            
            // Find out how much the keyboard overlaps our scroll view
            let keyboardOverlap = scrollView.frame.maxY - endRect.origin.y
            
            // Set the scroll view's content inset & scroll indicator to avoid the keyboard
            scrollView.contentInset.bottom = keyboardOverlap
            scrollView.scrollIndicatorInsets.bottom = keyboardOverlap
            
            let duration = (durationValue as AnyObject).doubleValue
            let options = UIView.AnimationOptions(rawValue: UInt((curveValue as AnyObject).integerValue << 16))
            UIView.animate(withDuration: duration!, delay: 0, options: options, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }

}

