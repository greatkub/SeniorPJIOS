//
//  DetailAnnouncementViewController.swift
//  Senior1PJ
//
//  Created by Krittamet Chuwongworaphinit on 28/4/2564 BE.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class AnnounceDetail {
    var createdAt : String?
    var tite : String?
    var description : String?
    var image : String!
    var like : String?
    
    
    init(created:String, title:String, descrip:String, imageDetail:String, liked:String ) {
        self.createdAt = created
        self.tite = title
        self.description = descrip
        self.image = imageDetail
        self.like = liked
    }
}


class DetailNews: UIViewController {
    
    var image_from_tab_announcement = ""
    var showDetail: AnnounceDetail?
    var detailRowAt = 0
    var newsList = [[String:Any]]()
//    var keptchat = [String:Any]()
    
    var date = ""

    @IBOutlet var image_vc: UIImageView!
    
    @IBOutlet var dateShow: UILabel!
    
    @IBOutlet var title_label: UILabel!
    
    @IBOutlet var content_label: UILabel!
    @IBOutlet var like_bt: UIButton!
    @IBOutlet var like_label: UILabel!
    @IBOutlet var comment_label: UILabel!

    @IBOutlet var likenearbt_label: UILabel!
    
    var checktag = 0
    var dataJ = [[String:Any]]()
    var postid = 0
    var hasAnounceId = Int()
    var filterlikeid = 0
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let urlImage = dataJ[detailRowAt]["imageUrl"] as? String
        
        AF.request(urlImage!).responseImage {
            (response) in
            
            if let image = response.value{
                
                DispatchQueue.main.async {
                    self.image_vc.image = image
                }
            }
        }
        
//        let Showdate = newsList[detailRowAt]["createdAt"] as? String
        let date = dataJ[detailRowAt]["announceDate"] as! String
        
        dateShow.text = reformat(str: date, toThis: "dd/MM/yyyy")

        
        title_label.text = dataJ[detailRowAt]["title"] as! String
        content_label.text = dataJ[detailRowAt]["description"] as! String
        postid = dataJ[detailRowAt]["id"] as! Int
        
//        like_label.text = "\(String(dataJ[detailRowAt]["likes"] as! Int))"
        numberOfLike()
        
        
        getJSONData()
        numberOfComment()

    }
    
    
    func getJSONData() {
        
        //option to use local json file
    
        let jameAPI = "\(currentJSON)/api/v1/announcement/likes/\(currentUserId)"
//        let urlFile = "http://haritibhakti.com/jsondata/vegetables.json"
        AF.request(jameAPI).responseJSON { (response) in
            switch response.result
            {
            case .success(_):
//                let jsondata = response.value as! [[String:Any]]?
//                self.newsList = jsondata!

                
                if let jsondata = response.value as? [[String:Any]] {
                    let filterannounce = jsondata.filter{$0["announcementId"] as! Int == self.postid}
    //                self.hasAnounceId =
                    print(filterannounce)
                    print(filterannounce.count)
                    print(self.postid)
                    print("HO")
                    print(jsondata)
                    if filterannounce.count != 0 {
                        self.filterlikeid =  filterannounce[0]["id"] as! Int
                        self.like_bt.tintColor = #colorLiteral(red: 0.2594431043, green: 0.3677232862, blue: 0.5306056142, alpha: 1)
                        self.clickLike = 1
                    }
                } else {
                    self.like_bt.tintColor = #colorLiteral(red: 0.6665995121, green: 0.666713655, blue: 0.6665844917, alpha: 1)
                    self.clickLike = 0
                    
                }
               
            case .failure(let error):
                print("Error Ovvured \(error.localizedDescription)")
            }
        }
    }
    
    func numberOfLike() {
        let jameAPI = "\(currentJSON)/api/v1/announcement/announcements"
//        let urlFile = "http://haritibhakti.com/jsondata/vegetables.json"
        AF.request(jameAPI).responseJSON { (response) in
            switch response.result
            {
            case .success(_):
//                let jsondata = response.value as! [[String:Any]]?
//                self.newsList = jsondata!

                if let jsondata = response.value as? [[String:Any]] {
                    let filterannounce = jsondata.filter{$0["id"] as! Int == self.postid}
                    let likes = filterannounce[0]["likes"] as! Int
                    print(likes)
                    self.like_label.text = String(likes) + " likes"
                }
               
            case .failure(let error):
                print("Error Ovvured \(error.localizedDescription)")
            }
        }
    }
    

    func numberOfComment(){
        let jameAPI = "\(currentJSON)/api/v1/comment/comments/\(postid)"
//        let urlFile = "http://haritibhakti.com/jsondata/vegetables.json"
        AF.request(jameAPI).responseJSON { (response) in
            switch response.result
            {
            case .success(_):
//                let jsondata = response.value as! [[String:Any]]?
//                self.newsList = jsondata!

                if let jsondata = response.value as? [[String:Any]] {
                    let countcomment = jsondata.count
                    
                    self.comment_label.text = String(countcomment) + " comments"
                } else {
                    self.comment_label.text = String(0) + " comments"
                }
               
            case .failure(let error):
                print("Error Ovvured \(error.localizedDescription)")
            }
        }
        
    }
    
    
    
    
    var clickLike = 0
    @IBAction func Like_action(_ sender: Any) {
        if clickLike == 0 {
            like_bt.tintColor = #colorLiteral(red: 0.2594431043, green: 0.3677232862, blue: 0.5306056142, alpha: 1)
            clickLike = 1
            likenearbt_label.textColor = #colorLiteral(red: 0.2594431043, green: 0.3677232862, blue: 0.5306056142, alpha: 1)
            
            let postUrl = "\(currentJSON)/api/v1/announcement/like"

            let parameters: [String: Any] = [
    //            "username": usernameTF.text!,
    //            "password": passwordTF.text!
                 "PostAnnouncementId": postid,
                "IsLike": true,
                "UserId": currentUserId
            ]

            AF.request(postUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { response in
                print(response.response?.statusCode)
                
//                self.getJSONData()
    //            self.myTableView.reloadData()
                self.numberOfLike()

//                self.showAlert(title: "success", message: "yeahh")
//                self.commentTextView.text = ""

            })
//            numberOfLike()
        
        } else {
            
            let postUrl = "\(currentJSON)/api/v1/announcement/edit-like/\(filterlikeid)"

            let parameters: [String: Any] = [
                 "Id": filterlikeid,
                "IsLike": false,
                "UserId": currentUserId
            ]

            AF.request(postUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { response in
                print(response.response?.statusCode)

//                self.showAlert(title: "Unlike Success", message: "yeahh")
                self.numberOfLike()

            })
//            like_label.text = "\(String(dataJ[detailRowAt]["likes"] as! Int)) Likes"

            like_bt.tintColor = #colorLiteral(red: 0.6665995121, green: 0.666713655, blue: 0.6665844917, alpha: 1)
            clickLike = 0
            likenearbt_label.textColor = #colorLiteral(red: 0.6665995121, green: 0.666713655, blue: 0.6665844917, alpha: 1)

        }
    }
    
  
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)

        self.dismiss(animated: true)
    }
    
    @objc func showMiracle() {
        let slideVC = OverlayView()
        slideVC.postid = postid
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        self.present(slideVC, animated: true, completion: nil)
    }
    
    @IBAction func onButtonComment(_ sender: Any) {
        showMiracle()
    }
    

    

}
extension DetailNews: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
    
}

