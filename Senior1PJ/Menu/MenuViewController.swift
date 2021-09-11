//
//  MenuViewController.swift
//  Senior1PJ
//
//  Created by Krittamet Chuwongworaphinit on 7/8/2564 BE.
//

import UIKit
import Alamofire
import AlamofireImage

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    @IBOutlet var firstname: UILabel!
    @IBOutlet var lastname: UILabel!
    @IBOutlet var myimage: UIImageView!
    var dataJ = [[String:Any]]()
    
    @IBOutlet var heighConstaint: NSLayoutConstraint!
    

    @IBOutlet var myTableView: UITableView!
    
    var menulist = ["Profile", "Petition", "Payment History", "Change Password", "Logout"]
    var imgmenulist = ["menu-user", "menu-docs", "menu-history", "menu-key", "menu-logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        myTableView.tableFooterView = UIView()
        getJSONData()

    }
    
    
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
                self.firstname.text = self.dataJ[0]["firstName"] as! String
                self.lastname.text = self.dataJ[0]["lastName"] as! String

              
                let urlImage = self.dataJ[0]["profileUrl"] as? String
                
                AF.request(urlImage!).responseImage {
                    (response) in
                    
                    if let image = response.value{
                        DispatchQueue.main.async {
                            self.myimage.image = image
                        }
                    }
                }
                
                self.view.layoutIfNeeded()

            case .failure(let error):
                print("Error Ovvured \(error.localizedDescription)")
            }
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        
      

        return menulist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MenuCell
        
        cell.listmenu_lb.text = menulist[indexPath.section]
        cell.icon_image.image = UIImage(named: imgmenulist[indexPath.section])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
//        if indexPath.section == menulist.count - 1 {
//            self.myTableView.separatorColor = UIColor.clear
//        }
        return 60
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let vc = self.storyboard?.instantiateViewController(identifier: "dataprofileviewcontroller") as! DataProfileViewController
            
            self.navigationController?.pushViewController(vc, animated: true)

        }
        
        if indexPath.section == 1 {
            let vc = storyboard?.instantiateViewController(identifier: "pvc") as! PetitionViewController

            self.navigationController?.pushViewController(vc, animated: true)
            
         
        }
        
        if indexPath.section == 2 {
            let vc = storyboard?.instantiateViewController(identifier: "chartviewcontroller") as! ChartsViewController
            
            self.present(vc, animated: true, completion: nil)
            
        }
        if indexPath.section == 3 {
            let vc = storyboard?.instantiateViewController(identifier: "changepasscontroller") as! ChangePassController

            self.navigationController?.pushViewController(vc, animated: true)

            
        //            let vc = storyboard?.instantiateViewController(identifier: "chartviewcontroller") as! ChartsViewController
        //
        //            self.present(vc, animated: true, completion: nil)
            
        }
        if indexPath.section == 4 {
            let vc = storyboard?.instantiateViewController(identifier: "loginviewcontroller") as! LoginViewController
            
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    
    

}

//
//
//func numberOfSections(in tableView: UITableView) -> Int {
//    // #warning Incomplete implementation, return the number of sections
//    heighConstaint.constant = CGFloat(Double(mysigninreverse.count) * 84)
//
//
//    return mysigninreverse.count
//}
//
//func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//      return 1
//  }
//
//func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//    return 14
//}
//
//func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//    let footerView = UIView()
//    footerView.backgroundColor = UIColor.clear
//    return footerView
//}
//
//func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//    return 70
//}
//
//
//func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    kept = indexPath.section
//
//    performSegue(withIdentifier: "showtotal", sender: self)
//    print("selected \(indexPath.section)")
//
//}
//
//override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    if let destination = segue.destination as? TotalPayment {
//
//        destination.status = mysigninreverse[kept]["status"] as! Int
//
//        destination.buildingRoom = Location(bdName: "\(buidinghead.text!)", rName: "\(roomhead.text!)")
//        destination.detailPayList = mysigninreverse
//        destination.rowAt = kept
//
//
//
//    }
//}
//
//
//
//
//
//}
//
//
//
//
//
//
//
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
//
//
//
//
//
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
//
//
//
//
//
//
//
//extension UIView {
//
//enum Visibility: String {
//    case visible = "visible"
//    case invisible = "invisible"
//    case gone = "gone"
//}
//
//var visibility: Visibility {
//    get {
//        let constraint = (self.constraints.filter{$0.firstAttribute == .height && $0.constant == 0}.first)
//        if let constraint = constraint, constraint.isActive {
//            return .gone
//        } else {
//            return self.isHidden ? .invisible : .visible
//        }
//    }
//    set {
//        if self.visibility != newValue {
//            self.setVisibility(newValue)
//        }
//    }
//}
//
//@IBInspectable
//var visibilityState: String {
//    get {
//        return self.visibility.rawValue
//    }
//    set {
//        let _visibility = Visibility(rawValue: newValue)!
//        self.visibility = _visibility
//    }
//}
//
//private func setVisibility(_ visibility: Visibility) {
//    let constraints = self.constraints.filter({$0.firstAttribute == .height && $0.constant == 0 && $0.secondItem == nil && ($0.firstItem as? UIView) == self})
//    let constraint = (constraints.first)
//
//    switch visibility {
//    case .visible:
//        constraint?.isActive = false
//        self.isHidden = false
//        break
//    case .invisible:
//        constraint?.isActive = false
//        self.isHidden = true
//        break
//    case .gone:
//        self.isHidden = true
//        if let constraint = constraint {
//            constraint.isActive = true
//        } else {
//            let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 0)
//            // constraint.priority = UILayoutPriority(rawValue: 999)
//            self.addConstraint(constraint)
//            constraint.isActive = true
//        }
//        self.setNeedsLayout()
//        self.setNeedsUpdateConstraints()
//    }
//}
//}
