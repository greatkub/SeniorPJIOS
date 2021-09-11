//
//  PetitionOverlayView.swift
//  Senior1PJ
//
//  Created by Krittamet Chuwongworaphinit on 10/8/2564 BE.
//

import UIKit
import SwiftUI
import Alamofire
import FirebaseStorage

class PetitionOverlayView: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet var newpetition_lb: UILabel!
    @IBOutlet var titile_lb: UILabel!
    @IBOutlet var descrip_lb: UILabel!
//    @IBOutlet var description_tv: UIView!
    @IBOutlet var title_TF: UITextField!
    @IBOutlet var myImage: UIImageView!
    @IBOutlet var desciption_tv: UITextView!
    @IBOutlet var submitoutlet: UIButton!
    var linkImageStr = ""
    

    private let storage = Storage.storage().reference()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        desciption_tv.layer.borderWidth = 0.8
        desciption_tv.layer.borderColor = #colorLiteral(red: 0.8674604893, green: 0.8626397252, blue: 0.8625634909, alpha: 1)
        
//        guard let urlString = UserDefaults.standard.value(forKey: "url") as? String,
//              let url = URL(string: urlString) else {
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
//            guard let data = data, error == nil else {
//                return
//            }
//
//            DispatchQueue.main.async {
//                let image = UIImage(data: data)
//                self.myImage.image = image
//            }
//
//
//        })
//
//        task.resume()
    }
    
    
    
 
    @IBAction func upload_image_bt(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
   
    @IBAction func submit_button(_ sender: Any) {
        let urlpost = "\(currentJSON)/api/v1/petition/petition"
        
        let parameters: [String: Any] = [
            "Title": title_TF.text!,
            "Description": desciption_tv.text!,
            "Image": linkImageStr,
               "UserId": currentUserId
        ]
        
        AF.request(urlpost, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { response in
            print(response.response?.statusCode)
            
            self.showAlert(title: "Successfully", message: "Your petition has been added")
            

        })
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)

        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
                if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
                    myImage.image = image
                    
                    submitoutlet.backgroundColor = #colorLiteral(red: 0.5043085217, green: 0.5545553565, blue: 0.6431950331, alpha: 1)
                    submitoutlet.isEnabled = false
                }
//
        guard let imageData = image.pngData() else {
            return
            
        }
        
        
        storage.child("images/file.png").putData(imageData,
                                                 metadata: nil,
                                                 completion: { _, error in
                                                    
                                                guard error == nil else {
                                                    print("Failed to upload")
                                                    return
                                                }
                                                    
                                                    self.storage.child("images/file.png").downloadURL(completion: { url, error in
                                                        guard let url = url, error == nil else {
                                                            return
                                                        }
                                                        
                                                        let urlString = url.absoluteString
                                                        print("Dowload URL: \(urlString)")
                                                        self.linkImageStr = urlString
                                                        UserDefaults.standard.set(urlString, forKey: "url" )
                                                        self.submitoutlet.backgroundColor = #colorLiteral(red: 0.2594431043, green: 0.3677232862, blue: 0.5306056142, alpha: 1)
                                                        self.submitoutlet.isEnabled = true
                                                    })
            
        } )
        
        
//        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
//            myImage.image = image
//        }
//
//        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}
