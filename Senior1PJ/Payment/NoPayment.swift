//
//  NoPayment.swift
//  Senior1PJ
//
//  Created by Krittamet Chuwongworaphinit on 6/5/2564 BE.
//

import UIKit

class NoPayment: UIViewController {

    @IBOutlet var date_head: UILabel!
    @IBOutlet var title_head: UILabel!
    
    @IBOutlet var building_body: UILabel!
    @IBOutlet var room_body: UILabel!
    
    @IBOutlet var nopayment_label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        date_head.adjustsFontSizeToFitWidth = true
        title_head.adjustsFontSizeToFitWidth = true
        building_body.adjustsFontSizeToFitWidth = true
        room_body.adjustsFontSizeToFitWidth = true
        nopayment_label.adjustsFontSizeToFitWidth = true
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
