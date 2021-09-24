//
//  OverlayView2.swift
//  Senior1PJ
//
//  Created by Krittamet Chuwongworaphinit on 15/6/2564 BE.
//

import UIKit
import SwiftUI
import Alamofire
import AlamofireImage

struct commentDetail {
    var profile : UIImage?
    var firstName : String?
    var lastname : String?
    var commentimage : UIImage?
    var commentAt : String?
    
    init(profile: UIImage? = nil, //👈
         firstName: String? = nil,
         lastname: String? = nil,
         commentimage: UIImage? = nil,
         commentAt: String? = nil) {
          
          self.profile = profile
          self.firstName = firstName
          self.lastname = lastname
          self.commentimage = commentimage
          self.commentAt = commentAt
      }
}

class OverlayView: UIViewController {
   
    
    @IBOutlet var camera_bt: UIButton!
    var datajson = [[String:Any]]()
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    
    @IBOutlet weak var slideIdicator: UIView!
    @IBOutlet weak var subscribeButton: UIView!
    var delegate: DetailNewsDelegate?

    
    @IBOutlet var bottomFrameTextField: NSLayoutConstraint!
    
    @IBOutlet var viewframe: UIView!
    
    @IBOutlet var myTableView: UITableView!
    @IBOutlet var commentTextView: UITextView!
    @IBOutlet var imageFromUser: UIImageView!
    var dataJ = [[String:Any]]()
    var chatcom = [String:Any]()
    var postid = 0
    @IBOutlet var myProfileimg: UIImageView!
    
    @IBAction func addimage_bt(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @IBAction func cancel_viewframe(_ sender: Any) {
        imagePickerControllerDidCancel(UIImagePickerController())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let vc = delegate else { return }
        vc.didDismiss()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        
        slideIdicator.roundCorners(.allCorners, radius: 10)
//        subscribeButton.roundCorners(.allCorners, radius: 10)
        camera_bt.visibility = .gone
        initializeHideKeyboard()
        viewframe.visibility = .gone
        
        self.myTableView.separatorStyle = UITableViewCell.SeparatorStyle.none

//        callJSON()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        
        
        commentTextView.translatesAutoresizingMaskIntoConstraints = false
        
//        commentTextView.font = UIFont.preferredFont(forTextStyle: .headline)
        
        commentTextView.delegate = self
        commentTextView.isScrollEnabled = false
        commentTextView.text = "Enter a comment ..."
        commentTextView.textColor = UIColor.lightGray

        
        textViewDidChange(commentTextView)
        
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        myTableView.estimatedRowHeight = 100
        myTableView.rowHeight = UITableView.automaticDimension
        self.myTableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        
        
        getJSONData()
        
//        myProfileimg
//        currentProfile
        let urlImage = currentProfile
        
        AF.request(urlImage).responseImage {
            (response) in
            
            if let image = response.value{

                DispatchQueue.main.async {
                    self.myProfileimg.image = image
                }
            }
            
        }
        
    }
    
    func callJSON() {
        guard let path = Bundle.main.path(forResource: "data2", ofType: "json") else {
                   return
        }
        let url = URL(fileURLWithPath: path)
        AF.request(url).responseJSON { (response) in
            switch response.result
            {
            case .success(_):
                let jsondata = response.value as! [[String:Any]]?
                self.datajson = jsondata!
    //            self.myTableView.reloadData()
            
                print("HH234 \(self.datajson)")
            case .failure(let error):
                print("Error Ovvured \(error.localizedDescription)")
            }
        }
        
    }
    
//    https://b473-2001-fb1-89-8bf8-9ce1-2e94-8925-68d1.ngrok.io/api/v1/comment/comments/10003
    
    func getJSONData() {
        
        //option to use local json file
        guard let path = Bundle.main.path(forResource: "dataMonth", ofType: "json") else {
            return
        }
        let url1 = URL(fileURLWithPath: path)
        let UrlReal = "\(currentJSON)/api/v1/comment/comments/\(postid)"

//      let urlFile2 = "https://536a20dd-fe69-4914-8458-6ad1e9b3ce18.mock.pstmn.io/news"
//        let urlFile = "http://haritibhakti.com/jsondata/vegetables.json"
        
        AF.request(UrlReal).responseJSON { (response) in
            switch response.result
            {
            case .success(_):
//                if response.value != nil {
                if let jsondata = response.value as? [[String:Any]] {
                    self.dataJ = jsondata
                } else {
                    
                }
//                }
              
                
                self.myTableView.reloadData()

                self.view.layoutIfNeeded()

            case .failure(let error):
                print("Error Ovvured \(error.localizedDescription)")
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {

        print("hey")
        if commentTextView.textColor == UIColor.lightGray {
            commentTextView.text = ""
            commentTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {

        if commentTextView.text == "" {

            commentTextView.text = "Enter a comment ..."
            commentTextView.textColor = UIColor.lightGray
        }
    }
  
    

    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
        bottomFrameTextField.constant = 0
    }
    
    @objc func keyboardWillShow( notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            var newHeight: CGFloat
            let duration:TimeInterval = (notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            if #available(iOS 11.0, *) {
                newHeight = keyboardFrame.cgRectValue.height - self.view.safeAreaInsets.bottom
            } else {
                newHeight = keyboardFrame.cgRectValue.height
            }
            let keyboardHeight = newHeight // **10 is bottom margin of View**  and **this newHeight will be keyboard height**
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: {
                            self.bottomFrameTextField.constant = keyboardHeight //**//Here you can manage your view constraints for animated show**
                            self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 0 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                
            }
        }
    }
}

extension OverlayView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataJ.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTableViewCell {
            
            var index = indexPath.section
            let firstname = dataJ[index]["firstName"] as! String
            let lastname = dataJ[index]["lastName"] as! String
            
//            cell.userNameLabel.text = "\(datajson[index]["firstName"] as! String) \(datajson[index]["lastName"] as! String)"
//            cell.profile.image = nil
            cell.userNameLabel.text = "\(firstname) \(lastname)"
            cell.myTextLabel.text = dataJ[index]["message"] as! String

//            cell.myTextLabel.text = datajson[index]["comment"] as! String
            
            let urlImage = dataJ[index]["profileUrl"] as? String
            
            AF.request(urlImage!).responseImage {
                (response) in
                
                if let image = response.value{

                    DispatchQueue.main.async {
                        cell.profile.image = image
                    }
                }
                
            }
            
            let datecom = dataJ[index]["commentDate"] as! String

//            cell.file_image.image
            cell.timepost_label.text = reformat2(str: datecom, toThis: "dd/MM/yyyy")
//            cell.myTextLabel.text = dataArray[indexPath.row]
            return cell

        }

        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexpath: IndexPath) {
        
        let commentid = dataJ[indexpath.section]["id"] as! Int
        let userId = dataJ[indexpath.section]["userId"] as! Int
        
        let deletePetition = "\(currentJSON)/api/v1/comment/comment/\(commentid)/user/\(currentUserId)"
        
        let parameters: [String: Any] = [
            "isDeleted": true
        ]
        
        let alertController = UIAlertController(title: "Success", message:
                                                    "Your petition has been added", preferredStyle: .alert)
        
       
        
        if editingStyle == .delete {
            
//<<<<<<< HEAD
//            AF.request(deletePetition, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { response in
////                print(response.response?.statusCode)
////
//
//                self.showAlert(title: "\(commentid)", message: "Your comment has been delete")
//
//            })
//
//            dataJ.remove(at: indexpath.section)
//=======
            if (currentUserId == userId) {
                AF.request(deletePetition, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { response in
    //                print(response.response?.statusCode)
//>>>>>>> 6fdeebc1f81aa1ba46b25ee5fb2e57aba96212fb

                    self.showAlert(title: "Deleted", message: "Your comment is deleted")
                })
                
                dataJ.remove(at: indexpath.section)
    //            getJSONData()
                self.myTableView.reloadData()
            } else {
                self.showAlert(title: "Error", message: "This comment is not yours")
            }
           
        }
    
    }
}

extension OverlayView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        viewframe.visibility = .visible
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            imageFromUser.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        viewframe.visibility = .gone
        picker.dismiss(animated: true, completion: nil)
    }
}


extension OverlayView {
    
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

extension OverlayView: UITextViewDelegate {
    

    func textViewDidChange(_ textView: UITextView) {
//        print(textView.text)
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
       
        if numberOfLines(textView: commentTextView) >= 4{
            textView.isScrollEnabled = true
//            textView.frame.size.height = textView.contentSize.height
            }else{
//                textView.frame.size.height = textView.contentSize.height
                textView.isScrollEnabled = false // textView.isScrollEnabled = false for swift 4.0
                textView.constraints.forEach { (constraint) in
                    if constraint.firstAttribute == .height {
                        constraint.constant = estimatedSize.height
                    }
                }
            }
    }
    
    func numberOfLines(textView: UITextView) -> Int {
        let layoutManager = textView.layoutManager
        let numberOfGlyphs = layoutManager.numberOfGlyphs
        var lineRange: NSRange = NSMakeRange(0, 1)
        var index = 0
        var numberOfLines = 0

        while index < numberOfGlyphs {
            layoutManager.lineFragmentRect(forGlyphAt: index, effectiveRange: &lineRange)
            index = NSMaxRange(lineRange)
            numberOfLines += 1
        }
        return numberOfLines
    }
    
}

extension OverlayView { //Post API
    
    @IBAction func submitComment(_ sender: Any) {
        let postUrl = "\(currentJSON)/api/v1/comment/comment"

        let parameters: [String: Any] = [
//            "username": usernameTF.text!,
//            "password": passwordTF.text!
            "Message": commentTextView.text!, //commenttextview
            "PostAnnouncementId": postid,
            "UserId": currentUserId
        ]

        AF.request(postUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { response in
            print(response.response?.statusCode)
                        
            self.getJSONData()
//            self.myTableView.reloadData()
//            self.showAlert(title: "success", message: "yeahh")
            self.commentTextView.text = ""

        })
    }
//    @IBAction func submitComment(_ sender: Any) {
//        print("\(commentTextView.text!)")
//    }
}
