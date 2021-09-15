//
//  TotalPayment.swift
//  Senior1PJ
//
//  Created by Krittamet Chuwongworaphinit on 8/5/2564 BE.
//

import UIKit
//
//  ShowPayment.swift
//  Senior1PJ
//
//  Created by Krittamet Chuwongworaphinit on 8/5/2564 BE.
//
class Location {
    var buildingName : String?
    var roomName : String?
    
    init(bdName:String, rName:String) {
        self.buildingName = bdName
        self.roomName = rName
    }
}

class AllTotal {
    var paymentImage : UIImage?
    var paymentName: String?
    var dateToPaid: String?
    var paymentPrice : Int
    
    
    
    init(pmImage: UIImage, pmName: String, dtPaid: String, pmPrice: Int) {
        self.paymentImage = pmImage
        self.paymentName = pmName
        self.dateToPaid = dtPaid
        self.paymentPrice = pmPrice
    }
    
}

class TotalPayment: UIViewController {
    
    var buildingRoom : Location?
    var detailPayList = [[String:Any]]()
    var Totalprice = 0.0

    
    @IBOutlet var dateBill_label: UILabel!
    @IBOutlet var heighDetailConstaint: NSLayoutConstraint!
    @IBOutlet var datehead: UILabel!
    @IBOutlet var confirmview_bt: UIButton!
    var status = ""
    @IBOutlet var titlehead: UILabel!
    @IBOutlet var buildinghead: UILabel!
    @IBOutlet var roomhead: UILabel!
    @IBOutlet var heighConstaint: NSLayoutConstraint!
    var count = 4
    @IBOutlet var myTableView: UITableView!
    var eachTypeName = ["Room","Electricity","Water","Others","Deposit"]
    var eachLogo = ["bed","flash","drop","money","purse"]
    var eachBill = ["roomPrice","elec","water","punish","deposit"]
    var rowAt = 0
    @IBOutlet var sumPayment: UILabel!
    var sum = 0
    var countvisibilitygone = 0
    var dataJ = [[String:Any]]()
    var priceArr = [String]()
    
    @IBOutlet var myTableView2: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        heighConstaint.constant = CGFloat((Double(count) * 82))
        
        datehead.adjustsFontSizeToFitWidth = true
        titlehead.adjustsFontSizeToFitWidth = true
        buildinghead.adjustsFontSizeToFitWidth = true
        roomhead.adjustsFontSizeToFitWidth = true
        datehead.text = datetoday
        myTableView.separatorStyle = .none
        
        
        buildinghead.text = buildingRoom?.buildingName
        roomhead.text = buildingRoom?.roomName
        
        if status != "Unpaid" {
            sumPayment.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
            confirmview_bt.visibility = .invisible
        } else {
            confirmview_bt.visibility = .visible
            sumPayment.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)

        }
        
        let roomprice = dataJ[rowAt]["rent"] as! Double
        let waterprice = dataJ[rowAt]["waterPrice"] as! Double
        
        let electricPrice = dataJ[rowAt]["electricityPrice"] as! Double
        let otherprice = dataJ[rowAt]["totalOtherPrice"] as! Double
        
        let date = dataJ[rowAt]["date"] as! String
//        "\(Totalprice.insertComma()) THB"
        priceArr += ["\(roomprice.insertComma()) THB"]
        priceArr += ["\(electricPrice.insertComma()) THB"]
        priceArr += ["\(waterprice.insertComma()) THB"]
        priceArr += ["\(otherprice.insertComma()) THB"]
        
        dateBill_label.text = reformat(str: date, toThis: "dd MMMM yyyy")
        
        
        
        
        
    
       
    }
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true)

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destination = segue.destination as? TotalPayment {
//
//            destination.buildingRoom = Location(bdName: "\(currentBuilding)", rName: "\(currentRoom)")
//
//
        
    }
    
    @objc func showMiracle() {
        let slideVC = QROverlayView()
//        amountToPay = "200"
//        let keptBill = detailPayList[rowAt]["bill"] as? [String:Any]
//        let totalBill = keptBill?["fakeTotal"] as! Int
        
//        amountToPay = String(format: "%.2f",Double(totalBill))
//        amountToPay = String(format: "%.2f",Double(0.1))
        
        
        slideVC.date = dateBill_label.text!
        slideVC.total = "Total \(sumPayment.text!) THB"
        //v1 realone
        let eWalletvar = dataJ[rowAt]["eWallet"] as! String
        let prompPayNovar = dataJ[rowAt]["prompPayNo"] as! String
        //v2

//        let eWalletvar = eWalletid
//        let prompPayNovar = "0943542367"
        let cutzero = prompPayNovar.dropFirst(1)
    
//        amountToPay = sumPayment.text!
        amountToPay = String(Double(Totalprice))

        phonePromptpay = String(cutzero)
        eWalletid = eWalletvar
//        phonePromptpay = "943542367"
//        eWalletid = "004999021296693"
        
        
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        self.present(slideVC, animated: true, completion: nil)
    }
    
    @IBAction func confirmToPay(_ sender: Any) {
        //Success
        //Payment is successful
        
        showMiracle()

    }
    
  
//    var selectedIndex: IndexPath = IndexPath(row: -1, section: -1)
    
    var count2 = 0
}

extension TotalPayment:  UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.section
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TotalPaid
//        let keptBill = detailPayList[rowAt]["bill"] as? [String:Any]
//        let totalBill = keptBill?["fakeTotal"] as! Int
//        let everyBillPayment = keptBill?[eachBill[index]] as! Int
//
        Totalprice = dataJ[0]["totalPrice"] as! Double
        
        let transId = dataJ[0]["userRentingTransactionId"] as! [[String:Any]]?
        let thistransid = transId?[0]["userTransactionId"] as! Int
        
        billid = thistransid
//        cell.topMonet_label.text = "\(Double(Totalprice).insertComma()) THB"
        cell.topMonet_label.text = priceArr[index]
//        priceArr
        cell.logoType_image.image = UIImage(named: eachLogo[index])
        
        
        
        

        cell.typeName_label.text = eachTypeName[index]
//        var eachTypeName = ["Room","Electricity","Water","Others","Deposit"]

        if (index == 0) {
            cell.chevronhide.visibility = .gone
        }

        sumPayment.text = Double(Totalprice).insertComma()
        
        
//        if everyBillPayment == 0 {
//            cell.visibility = .gone
//            countvisibilitygone += 1
//        }
//
        cell.selectionStyle = .none
        cell.animate()
    
        
        return cell
    }
    

    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return count
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
        
//        if selectedIndex == indexPath  {
//            heighConstaint.constant = CGFloat(((Double(count) * 82) + 132))
//
////            count2 = count2 + 1
//            print(1)
////            selectedIndex = IndexPath(row: indexPath.row, section: indexPath.section)
//            return 200
//
//        }
        
        
//        print("ddd" + "\(indexPath)")
//        print(indexPath)
        
//        if selectedIndex == indexPath && heighConstaint.constant == 200 {
//            return 68
//        }
//        heighConstaint.constant = CGFloat((Double(count) * 82))
        
        heighConstaint.constant = CGFloat((Double(count - countvisibilitygone) * 82))

        print(2)
        return 68
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.section)
        
        let index = indexPath.section
        
        let vc = storyboard?.instantiateViewController(identifier: "waterelecviewcontroller") as! WaterElecViewController
        let vc2 = storyboard?.instantiateViewController(identifier: "totaldetailviewcontroller") as! TotalDetailViewController
        
        let unitperprice = dataJ[rowAt]["unitPerPrice"] as! [[String:Any]]?
        //elec
        
        let electricityPreviousReading = dataJ[rowAt]["electricityPreviousReading"] as! String
        let electricityCurrentReading = dataJ[rowAt]["electricityCurrentReading"] as! String
        let electricityUsage = dataJ[rowAt]["electricityUsage"] as! Int
        let elecperunit = unitperprice?[0]["feeTypePrice"] as! Double
        //water
        let waterPreviousReading = dataJ[rowAt]["waterPreviousReading"] as! String
        let waterCurrentReading = dataJ[rowAt]["waterCurrentReading"] as! String
        let waterUsage = dataJ[rowAt]["waterUsage"] as! Int
        let waterperunit = unitperprice?[1]["feeTypePrice"] as! Double
        //Other
        let fees = dataJ[rowAt]["fees"] as! [[String:Any]]?
        let totalOtherPrice = dataJ[rowAt]["totalOtherPrice"] as! Double
        let occupant = dataJ[rowAt]["numberOfTenant"] as! Int
        
        
        
        
        
        
        if index == 1 || index == 2  {
            if index == 1 {
                vc.current = electricityCurrentReading
                vc.previous = electricityPreviousReading
                vc.usage = electricityUsage
                vc.priceperunit = elecperunit
            } else {
                vc.current = waterCurrentReading
                vc.previous = waterPreviousReading
                vc.usage = waterUsage
                vc.priceperunit = waterperunit
            }
            vc.occurpant = occupant
            vc.selecticon = index
            self.present(vc, animated: true, completion: nil)
        }
        else if index == 3 {
            vc2.fees = fees!
            vc2.totalOtherPrice = totalOtherPrice
            vc2.occurpant = occupant

            self.present(vc2, animated: true, completion: nil)
        }
       
        
        
//        selectedIndex = indexPath
//        print("-------- \(selectedIndex.section)")
////        myTableView.reloadData()
//        myTableView.beginUpdates()
//        myTableView.reloadRows(at: [selectedIndex], with: .none)
//        myTableView.endUpdates()
    }
    
    
    
    
    
    
    
}

extension TotalPayment: UIViewControllerTransitioningDelegate {
    internal func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        QRPresentationController(presentedViewController: presented, presenting: presenting)
    }
}




