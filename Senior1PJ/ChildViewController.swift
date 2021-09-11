//
//  ChildViewController.swift
//  Senior1PJ
//
//  Created by Krittamet Chuwongworaphinit on 6/5/2564 BE.
//

import UIKit

class ChildViewController: UIViewController {

    @IBOutlet var childDate: UILabel!
    @IBOutlet var ChildLabel: UILabel!
    @IBOutlet var BuildingLabel: UILabel!
    @IBOutlet var nopaymentLabel: UILabel!
    @IBOutlet var RoomLabel: UILabel!
    @IBOutlet var heightConstant: NSLayoutConstraint!
    
    @IBOutlet var myTableView: UITableView!
    var count = 10
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        childDate.adjustsFontSizeToFitWidth = true
        ChildLabel.adjustsFontSizeToFitWidth = true
        BuildingLabel.adjustsFontSizeToFitWidth = true
        nopaymentLabel.adjustsFontSizeToFitWidth = true
        RoomLabel.adjustsFontSizeToFitWidth = true
        
        heightConstant.constant = CGFloat(Double(count) * 67)
        myTableView.separatorStyle = .none

        
        
    }
    

}
extension ChildViewController:  UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.section
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! IsPaid
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    

    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return 1
      }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 12
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let HeaderView = UIView()
        HeaderView.backgroundColor = UIColor.clear
        return HeaderView
    }
    
  }
    


