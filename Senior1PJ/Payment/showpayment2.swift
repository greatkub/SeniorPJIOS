////
////  showpayment2.swift
////  Senior1PJ
////
////  Created by Krittamet Chuwongworaphinit on 29/6/2564 BE.
////
//
////
////  ShowPayment.swift
////  Senior1PJ
////
////  Created by Krittamet Chuwongworaphinit on 8/5/2564 BE.
////
//
//import UIKit
//import Alamofire
//import SwiftyJSON
//import AlamofireImage
//
//class PaidOrUnPaid {
//
//    var monthName: String?
//    var paidAlready: String?
//
//
//    init(mName: String, pAleady: String) {
//   
//        self.monthName = mName
//        self.paidAlready = pAleady
//
//    }
//
//}
//
//class ShowPayment: UIViewController {
//
//    @IBOutlet var heighConstaint: NSLayoutConstraint!
//
//    @IBOutlet var payDate_label: UILabel!
//    @IBOutlet var datehead: UILabel!
//    @IBOutlet var titlehead: UILabel!
//    @IBOutlet var buidinghead: UILabel!
//    @IBOutlet var roomhead: UILabel!
//
//    @IBOutlet var myTableView: UITableView!
//
//    @IBOutlet var nopayemnt_label: UILabel!
//    @IBOutlet var heightViewBuildingRoom: NSLayoutConstraint!
//    public var delegate: UIViewController?
//    let screenSize: CGRect = UIScreen.main.bounds
//
//    ///////////////////    ///////////////////    ///////////////////    ///////////////////    ///////////////////
////                cell
//
//    var monthPaidArray = [PaidOrUnPaid]()
//
//    ///////////////////    ///////////////////    Get  API   ///////////////////    ///////////////////
//
//    var currentBuilding = "..."
//    var currentRoom = "Room"
//    let urlFile = "https://536a20dd-fe69-4914-8458-6ad1e9b3ce18.mock.pstmn.io/test"
//    var monthList = [[String:Any]]()
//    var billObj = [[String:Any]]()
//
//
//    /////////////////     //////////////////   /////////////  //////////////  //////////   /////////////
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//
//        datehead.adjustsFontSizeToFitWidth = true
//        titlehead.adjustsFontSizeToFitWidth = true
//        buidinghead.adjustsFontSizeToFitWidth = true
//        roomhead.adjustsFontSizeToFitWidth = true
//        nopayemnt_label.adjustsFontSizeToFitWidth = true
//        myTableView.separatorStyle = .none
//
//
//        heightViewBuildingRoom.constant = (screenSize.height / 2)
//        buidinghead.text = personalInfo().building
//        roomhead.text = "Room \(personalInfo().room)"
//
////        getJSONData()
////        callJSON()
//
//
//    }
//
//    func callJSON() {
//        getJSON(url: urlFile, completion: { (res, err) in
//                  if let response = res {
//                      // success
//                      print("great22\(response)")
//                      print("end")
//                    self.monthList = response
//                    print("453")
//                    print(self.monthList)
//
//                    self.buidinghead.text = personalInfo().building
//                    self.roomhead.text = "Room \(personalInfo().room)"
//
//                    self.billObj = (self.monthList[0]["signin"] as? [[String:Any]])!
////                    self.buidinghead.text = self.monthList[0]["building"] as? String
////                    self.roomhead.text = "Room \(self.monthList[0]["room"] as! String)"
////                    self.billObj = (self.monthList[0]["signin"] as? [[String:Any]])!
//                    self.heightViewBuildingRoom.constant = 74
//                    self.nopayemnt_label.visibility = .gone
//                    self.myTableView.reloadData()
//
//                  } else {
//                      print(err)
//                  }
//              })
//    }
//
//
//    var kept = 0
//
//
//    /*-----------------------------------------------------------------*/
//    /*                                                                 */
//    /*                              JSON ()                            */
//    /*                                                                 */
//    /*-----------------------------------------------------------------*/
//
//
//
//
//
//
//
//
//}
//
//extension ShowPayment:  UITableViewDataSource, UITableViewDelegate{
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let index = indexPath.section
//        index_GB = index
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! IsPaid
//
//
////        cell.monthLabel.text = monthPaidArray[index].monthName
////        cell.paidLabel.text = monthPaidArray[index].paidAlready
//        let monthPay = billObj.reversed()[index]["month"] as! Int
//        let status = billObj.reversed()[index]["status"] as! Int
////        let asd = bill?["water"] as? Int
//
//        print("1234\(billObj.count)")
//
//        print("123\(monthPay)")
////        let elec = billObj["elec"] as! Int
////        let water = billObj["water"] as! Int
//////
////        print("188 \(water)")
//
////        cell.datePay_label.text = billObj.reversed()[index]["dateToPay"] as! String
////        cell.monthLabel.text = numToString(a: monthPay)
////        cell.paidLabel.text = paidString(a: status)
//
//        cell.datePay_label.text = reversedResedenceHistory().datetoPay
//        cell.monthLabel.text = numToString(a: reversedResedenceHistory().month)
//        cell.paidLabel.text = paidString(a: reversedResedenceHistory().status)
//
//        if(cell.paidLabel.text != "UNPAID") {
//
////            cell.chevronImage.visibility = .gone
//            cell.frameChevron.visibility = .visible
//            cell.paidLabel.textColor = #colorLiteral(red: 0.4949062467, green: 0.5911551118, blue: 0.7381506562, alpha: 1)
//
//        }else{
//            cell.paidLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
//        }
//        return cell
//    }
//
//    func numToString(a:Int) -> String {
//        var month = ["January", "Febuary", "March", "April", "May", "June", "July", "August", "October", "November", "December"]
//        return month[a-1]
//    }
//
//    func paidString(a:Int) -> String {
//        var b = ["UNPAID", "PAID"]
//        return b[a]
//    }
//
//
//
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        heighConstaint.constant = CGFloat(Double(mysigninreverse.count) * 84)
//
//
//        return mysigninreverse.count
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//          return 1
//      }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 14
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let footerView = UIView()
//        footerView.backgroundColor = UIColor.clear
//        return footerView
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 70
//    }
//
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        kept = indexPath.section
//
//        performSegue(withIdentifier: "showtotal", sender: self)
//        print("selected \(indexPath.section)")
//
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destination = segue.destination as? TotalPayment {
//
//            destination.buildingRoom = Location(bdName: "\(buidinghead.text!)", rName: "\(roomhead.text!)")
//            destination.detailPayList = mysigninreverse
//            destination.rowAt = kept
//
//
//
//        }
//    }
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
//    enum Visibility: String {
//        case visible = "visible"
//        case invisible = "invisible"
//        case gone = "gone"
//    }
//
//    var visibility: Visibility {
//        get {
//            let constraint = (self.constraints.filter{$0.firstAttribute == .height && $0.constant == 0}.first)
//            if let constraint = constraint, constraint.isActive {
//                return .gone
//            } else {
//                return self.isHidden ? .invisible : .visible
//            }
//        }
//        set {
//            if self.visibility != newValue {
//                self.setVisibility(newValue)
//            }
//        }
//    }
//
//    @IBInspectable
//    var visibilityState: String {
//        get {
//            return self.visibility.rawValue
//        }
//        set {
//            let _visibility = Visibility(rawValue: newValue)!
//            self.visibility = _visibility
//        }
//    }
//
//    private func setVisibility(_ visibility: Visibility) {
//        let constraints = self.constraints.filter({$0.firstAttribute == .height && $0.constant == 0 && $0.secondItem == nil && ($0.firstItem as? UIView) == self})
//        let constraint = (constraints.first)
//
//        switch visibility {
//        case .visible:
//            constraint?.isActive = false
//            self.isHidden = false
//            break
//        case .invisible:
//            constraint?.isActive = false
//            self.isHidden = true
//            break
//        case .gone:
//            self.isHidden = true
//            if let constraint = constraint {
//                constraint.isActive = true
//            } else {
//                let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 0)
//                // constraint.priority = UILayoutPriority(rawValue: 999)
//                self.addConstraint(constraint)
//                constraint.isActive = true
//            }
//            self.setNeedsLayout()
//            self.setNeedsUpdateConstraints()
//        }
//    }
//}
//
