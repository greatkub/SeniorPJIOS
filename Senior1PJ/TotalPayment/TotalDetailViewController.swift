//
//  TotalDetailViewController.swift
//  Senior1PJ
//
//  Created by Krittamet Chuwongworaphinit on 26/6/2564 BE.
//

import UIKit

class TotalDetailViewController: UIViewController {
    

    @IBAction func goback(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet var total: UILabel!
    @IBOutlet var title_label: UILabel!
    @IBOutlet var date_label: UILabel!
    @IBOutlet var makeBorderView: UIView!
    @IBOutlet var heightConstraint:
        NSLayoutConstraint!
    var fees = [[String:Any]]()
    var totalOtherPrice = 0.0
    var occurpant = 0

    @IBOutlet var note: UILabel!
    let screenSize: CGRect = UIScreen.main.bounds
    let priceArr = [Double]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        makeBorderView.layer.borderWidth = 1
        makeBorderView.layer.borderColor = #colorLiteral(red: 0.5723067522, green: 0.5723067522, blue: 0.5723067522, alpha: 1)
        
        date_label.adjustsFontSizeToFitWidth = true
        title_label.adjustsFontSizeToFitWidth = true
        
        total.text = insertComma(a: totalOtherPrice) + " THB"
        date_label.text = datetoday
        print(fees)
        print(fees[0]["feeTypeName"] as! String)
        note.text = "Total price is divided by the number of tenents (\(occurpant))"
        
    }
    var data = ["Chair lost","Lamp broke ","Pay late","Table break"]
    
//    var data = ["Chair lost"]
    
//    func insertComma(a: Double) -> String {
//        let numberFormatter = NumberFormatter()
//        numberFormatter.minimumFractionDigits = 2
//        numberFormatter.maximumFractionDigits = 2
//
//
//        numberFormatter.numberStyle = .decimal
//        return numberFormatter.string(from: NSNumber(value:a))!
//    }
    


}
extension TotalDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TotalDetailCell
        
        
        cell.detail_label.text = fees[0]["feeTypeName"] as! String
        cell.priceDetail_label.text = insertComma(a: fees[0]["feeTypePrice"] as! Double) + " THB"

        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if fees.count <= 3 {
            heightConstraint.constant = (screenSize.height / 7.3)
        } else {
            heightConstraint.constant = CGFloat(Double(data.count) * 28)
        }

        return fees.count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }

    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = UIView()
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }
    
   
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        kept = indexPath.section
//
//        performSegue(withIdentifier: "showtotal", sender: self)
//        print("selected \(indexPath.section)")
//
//    }
    
    
}
