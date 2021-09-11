//
//  DataProfileViewController.swift
//  Senior1PJ
//
//  Created by Krittamet Chuwongworaphinit on 27/6/2564 BE.
//

import UIKit
import Alamofire

class DataProfileViewController: UIViewController {

    @IBOutlet var border_view: UIView!
    @IBOutlet var firstname_TF: UITextField!
    @IBOutlet var Lastname_TF: UITextField!
    @IBOutlet var date_TF: UITextField!
    @IBOutlet var phone_TF: UITextField!
    @IBOutlet var profile_image: UIImageView!
    @IBOutlet var room_TF: UITextField!
    @IBOutlet var buildingName_TF: UITextField!
    @IBOutlet var edittimagecolor: UIImageView!
    @IBOutlet var myBed_TF: UITextField!
    
    @IBOutlet var image_bt: UIButton!
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)

        self.dismiss(animated: true)
    }
    @IBOutlet var history_bt: UIButton!
    @IBAction func goHistory(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "chartviewcontroller") as! ChartsViewController
        
        self.present(vc, animated: true, completion: nil)
    }
    var dataJ = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        border_view.layer.borderWidth = 2
        border_view.layer.borderColor = #colorLiteral(red: 0.2594431043, green: 0.3677232862, blue: 0.5306056142, alpha: 1)
       
        let origImage = UIImage(named: "history")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
//        history_bt.setImage(tintedImage, for: .normal)
//        history_bt.tintColor = #colorLiteral(red: 0.2901639342, green: 0.2902185619, blue: 0.2901568413, alpha: 1)
        edittimagecolor.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
//        callJSON()
        getJSONData()
        border_view.visibility = .gone
        image_bt.visibility = .gone
        
    }
    
    @IBAction func addImage_bt(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    let URL2 = "https://536a20dd-fe69-4914-8458-6ad1e9b3ce18.mock.pstmn.io/test"
    
    
//    func callJSON(){
//        getJSON(url: URL2, completion: { (res, err) in
//                        if let response = res {
//                            // success
//                            self.dataJ = response
//                            print("great22\(response)")
//                            print("end")
//                            self.firstname_TF.text = self.dataJ[0]["firstName"] as? String
//                            self.Lastname_TF.text = self.dataJ[0]["lastName"] as? String
//                            self.date_TF.text = self.dataJ[0]["birthDate"] as?
//                                String
//                            self.room_TF.text = self.dataJ[0]["room"] as? String
//                            self.phone_TF.text = self.dataJ[0]["phoneNo"] as? String
//
//                        } else {
//                            // failure
//                        }
//                    })
//    }
    
    
    
    func getJSONData() {
        
        //option to use local json file
        guard let path = Bundle.main.path(forResource: "dataMonth", ofType: "json") else {
            return
        }
        let url1 = URL(fileURLWithPath: path)
        let UrlReal = "\(currentJSON)/api/v1/mobile/user/\(currentUserId)"

//      let urlFile2 = "https://536a20dd-fe69-4914-8458-6ad1e9b3ce18.mock.pstmn.io/news"
//        let urlFile = "http://haritibhakti.com/jsondata/vegetables.json"
        AF.request(UrlReal).responseJSON { (response) in
            switch response.result
            {
            case .success(_):
                let jsondata = response.value as! [[String:Any]]?
                self.dataJ = jsondata!
                print("end")
                let myid = self.dataJ[0]["id"] as? Int
                self.firstname_TF.text = self.dataJ[0]["firstName"] as? String
                self.Lastname_TF.text = self.dataJ[0]["lastName"] as? String
                
                let birth = self.dataJ[0]["birthDate"] as!
                    String
                self.date_TF.text = reformat(str: birth, toThis: "dd MMMM yyyy")
//                self.room_TF.text = self.dataJ[0]["room"] as? String
                self.phone_TF.text = self.dataJ[0]["phoneNumber"] as? String
//                self.buildingName_TF.text = self.dataJ[0]["building"] as? String
                
                
//                print("great22\(self.dataJ[0]["phoneNo"] as? String)")
                let buildingJson = self.dataJ[0]["building"] as? [[String:Any]]
                self.buildingName_TF.text = buildingJson![0]["buildingName"] as? String
                self.room_TF.text = buildingJson![0]["roomNumber"] as? String
                self.myBed_TF.text = buildingJson![0]["bedName"] as? String


                
                let urlImage = self.dataJ[0]["profileUrl"] as? String
                
                AF.request(urlImage!).responseImage {
                    (response) in
                    
                    if let image = response.value{
                        DispatchQueue.main.async {
                            self.profile_image.image = image
                        }
                    }
                }
                
                self.view.layoutIfNeeded()

            case .failure(let error):
                print("Error Ovvured \(error.localizedDescription)")
            }
        }
    }
    
}

extension DataProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
 
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
