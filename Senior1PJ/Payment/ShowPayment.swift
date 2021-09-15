//
//  ShowPayment.swift
//  Senior1PJ
//
//  Created by Krittamet Chuwongworaphinit on 8/5/2564 BE.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class PaidOrUnPaid {
 
    var monthName: String?
    var paidAlready: String?
    
    
    init(mName: String, pAleady: String) {
   
        self.monthName = mName
        self.paidAlready = pAleady

    }
    
}

class ShowPayment: UIViewController {

    @IBOutlet var heighConstaint: NSLayoutConstraint!
    
    @IBOutlet var payDate_label: UILabel!
    @IBOutlet var datehead: UILabel!
    @IBOutlet var titlehead: UILabel!
    @IBOutlet var buidinghead: UILabel!
    @IBOutlet var roomhead: UILabel!
  
    @IBOutlet var viewbelowroom: UIView!
    @IBOutlet var myTableView: UITableView!
    
    @IBOutlet var nopayemnt_label: UILabel!
    @IBOutlet var heightViewBuildingRoom: NSLayoutConstraint!
    public var delegate: UIViewController?
    let screenSize: CGRect = UIScreen.main.bounds

    ///////////////////    ///////////////////    ///////////////////    ///////////////////    ///////////////////
//                cell
    
    var monthPaidArray = [PaidOrUnPaid]()

    ///////////////////    ///////////////////    Get  API   ///////////////////    ///////////////////
    
    var currentBuilding = "..."
    var currentRoom = "Room"
    let urlFile = "https://536a20dd-fe69-4914-8458-6ad1e9b3ce18.mock.pstmn.io/test"
    var monthList = [[String:Any]]()
    var billObj = [[String:Any]]()
    var dataJ = [[String:Any]]()
    var room = 0

    
    /////////////////     //////////////////   /////////////  //////////////  //////////   /////////////
    let dispatchGroup = DispatchGroup()
    let refreshTB = UIRefreshControl()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        let loadingVC = LoadingViewController()
////
////        // Animate loadingVC over the existing views on screen
//        loadingVC.modalPresentationStyle = .overCurrentContext
//
//        // Animate loadingVC with a fade in animation
//        loadingVC.modalTransitionStyle = .crossDissolve
//
//        present(loadingVC, animated: true, completion: nil)
        datehead.adjustsFontSizeToFitWidth = true
        titlehead.adjustsFontSizeToFitWidth = true
        buidinghead.adjustsFontSizeToFitWidth = true
        roomhead.adjustsFontSizeToFitWidth = true
        nopayemnt_label.adjustsFontSizeToFitWidth = true
        myTableView.separatorStyle = .none
        
//        heighConstaint.constant = CGFloat(Double(4) * 84)
        heightViewBuildingRoom.constant = (screenSize.height / 2)
//        buidinghead.text = personalInfo().building
//        roomhead.text = "Room \(personalInfo().room)"
        self.heightViewBuildingRoom.constant = 74
        self.myTableView.reloadData()

        refreshTB.tintColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        refreshTB.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        myTableView.addSubview(refreshTB)
        self.myTableView.showsHorizontalScrollIndicator = false
        self.myTableView.showsVerticalScrollIndicator = false
        
        getJSONData2()
        
        datehead.text = datetoday
        
    }
    @objc func refreshData() {
        getJSONData2()
        refreshTB.endRefreshing()
        print("refreshData")
        myTableView.reloadData()
    }
 
//    override func viewWillAppear(_ animated: Bool) {
//        getJSONData2()
//        print("show")
//    }

    var kept = 0
    
//    override func viewWillAppear(_ animated: Bool) {
//        getJSONData()
//        myTableView.reloadData()
//        print("111 Appear")
//    }
    
    /*-----------------------------------------------------------------*/
    /*                                                                 */
    /*                              JSON ()                            */
    /*                                                                 */
    /*-----------------------------------------------------------------*/
    
    func getJSONData2() {

        let UrlReal = "\(currentJSON)/api/v1/mobile/bill-payment-building/user/\(currentUserId)"
        
        AF.request(UrlReal).responseJSON { (response) in
            switch response.result
            {
            case .success(_):
                if let jsondata = response.value as? [[String:Any]] {
                    let dataJ2 = jsondata
                    
                    self.room =  (dataJ2[0]["roomId"] as? Int)!
                    print(self.room)
                   
                    self.currentBuilding = (dataJ2[0]["buildingName"] as? String)!
                    self.currentRoom = "Room \(dataJ2[0]["roomNumber"] as! String)"

                 
                    self.myTableView.reloadData()
                    self.view.layoutIfNeeded()
                    print(self.room)

                    self.getJSONData()

                }

            case .failure(let error):
                print("Error Ovvured \(error.localizedDescription)")
                self.dispatchGroup.leave()

            }
        }

    }

    
    
    
    func getJSONData() {
        
        let UrlReal = "\(currentJSON)/api/v1/mobile/bill-payment-renting/room/\(room)/user/\(currentUserId)"

        print(UrlReal)
        AF.request(UrlReal).responseJSON { (response) in
            switch response.result
            {
            case .success(_):
                if let jsondata = response.value as? [[String:Any]] {
                    self.dataJ = jsondata
                    
                    print("This one")
//                    self.buidinghead.text = self.dataJ[0]["buildingName"] as? String
//                    self.roomhead.text = "Room \(self.dataJ[0]["roomNumber"] as! String)"
                    print(jsondata)
                    self.buidinghead.text = self.currentBuilding
                        self.roomhead.text = self.currentRoom
                    
                    self.viewbelowroom.visibility = .gone
                    self.nopayemnt_label.visibility = .gone
                    self.myTableView.reloadData()
                    self.view.layoutIfNeeded()
                }

            case .failure(let error):
                print("Error Ovvured \(error.localizedDescription)")
            }
        }
    }


}

extension ShowPayment:  UITableViewDataSource, UITableViewDelegate{
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.section
        index_GB = index
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! IsPaid
        let str = dataJ[index]["date"] as! String

        
        cell.datePay_label.text = reformat(str: str, toThis: "dd/MM/yyyy")
        cell.monthLabel.text = numToString(a:  Int(reformat(str: str, toThis: "M"))!)
        cell.paidLabel.text = (dataJ[index]["statusInfo"] as? String)?.uppercased()


        if(cell.paidLabel.text != "UNPAID") {

            cell.frameChevron.visibility = .visible
            cell.paidLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)

        }else{
            cell.paidLabel.textColor = #colorLiteral(red: 0.4949062467, green: 0.5911551118, blue: 0.7381506562, alpha: 1)
        }
        return cell
    }
    

    
    func numToString(a:Int) -> String {
        print(a)
        var month = ["January", "Febuary", "March", "April", "May", "June", "July", "August", "September" , "October", "November", "December"]
        print("\(month[a-1])")
        return month[a-1]
    }
    
    func paidString(a:Int) -> String {
        var b = ["UNPAID", "PAID"]
        return b[a]
    }
    
    

    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        if dataJ.count > 5 {
            heighConstaint.constant = CGFloat(Double(
                                                5) * 84)
            return 5
        }
        heighConstaint.constant = CGFloat(Double(
                                            dataJ.count) * 84)
        return dataJ.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return 1
      }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 14
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        kept = indexPath.section

        performSegue(withIdentifier: "showtotal", sender: self)
        print("selected \(indexPath.section)")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? TotalPayment {
            
//            let staInfo = dataJ[kept]["statusInfo"] as? [[String:Any]]
            
//            destination.status = dataJ[kept]["statusInfo"] as! String
            destination.status = dataJ[kept]["statusInfo"] as! String

            destination.buildingRoom = Location(bdName: "\(buidinghead.text!)", rName: "\(roomhead.text!)")
            destination.rowAt = kept
            destination.dataJ = dataJ
            
//            destination.buildingRoom = Location(bdName: "\(buidinghead.text!)", rName: "\(roomhead.text!)")
//            destination.detailPayList = mysigninreverse
//            destination.rowAt = kept
            
//            destination.status = mysigninreverse[kept]["status"] as! Int
//
//            destination.buildingRoom = Location(bdName: "\(buidinghead.text!)", rName: "\(roomhead.text!)")
//            destination.detailPayList = mysigninreverse
//            destination.rowAt = kept
            
            

        }
    }
    
    
    
    
    
}








//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////








//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////









extension UIView {

    enum Visibility: String {
        case visible = "visible"
        case invisible = "invisible"
        case gone = "gone"
    }

    var visibility: Visibility {
        get {
            let constraint = (self.constraints.filter{$0.firstAttribute == .height && $0.constant == 0}.first)
            if let constraint = constraint, constraint.isActive {
                return .gone
            } else {
                return self.isHidden ? .invisible : .visible
            }
        }
        set {
            if self.visibility != newValue {
                self.setVisibility(newValue)
            }
        }
    }

    @IBInspectable
    var visibilityState: String {
        get {
            return self.visibility.rawValue
        }
        set {
            let _visibility = Visibility(rawValue: newValue)!
            self.visibility = _visibility
        }
    }

    private func setVisibility(_ visibility: Visibility) {
        let constraints = self.constraints.filter({$0.firstAttribute == .height && $0.constant == 0 && $0.secondItem == nil && ($0.firstItem as? UIView) == self})
        let constraint = (constraints.first)

        switch visibility {
        case .visible:
            constraint?.isActive = false
            self.isHidden = false
            break
        case .invisible:
            constraint?.isActive = false
            self.isHidden = true
            break
        case .gone:
            self.isHidden = true
            if let constraint = constraint {
                constraint.isActive = true
            } else {
                let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 0)
                // constraint.priority = UILayoutPriority(rawValue: 999)
                self.addConstraint(constraint)
                constraint.isActive = true
            }
            self.setNeedsLayout()
            self.setNeedsUpdateConstraints()
        }
    }
}

