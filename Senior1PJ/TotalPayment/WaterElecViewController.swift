//
//  WaterElecViewController.swift
//  Senior1PJ
//
//  Created by Krittamet Chuwongworaphinit on 26/6/2564 BE.
//

import UIKit

class WaterElecViewController: UIViewController {

    @IBOutlet var priceperunit_label: UILabel!
    @IBOutlet var unit_label: UILabel!
    @IBOutlet var current_label: UILabel!
    @IBOutlet var previous_label: UILabel!
    @IBOutlet var total: UILabel!
    @IBOutlet var billpayment_label: UILabel!
    @IBOutlet var date_label: UILabel!
    var selecticon: Int = 0
    @IBOutlet var logotypebill_image: UIImageView!
    @IBOutlet var boundFrame: UIView!
    @IBAction func goback(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var current = ""
    var previous = ""
    var usage = 0
    var priceperunit = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        boundFrame.layer.borderWidth = 1
        boundFrame.layer.borderColor = #colorLiteral(red: 0.5723067522, green: 0.5723067522, blue: 0.5723067522, alpha: 1)
        // Do any additional setup after loading the view.
        iconBeSelected()
        
        date_label.adjustsFontSizeToFitWidth = true
        billpayment_label.adjustsFontSizeToFitWidth = true
        
        total.text = insertComma(a: 566) + " THB"
        current_label.text = current
        previous_label.text = previous
        unit_label.text = String(usage)
        priceperunit_label.text = String(priceperunit)
        
        date_label.text = datetoday
        
    }
    
    func iconBeSelected() {
        logotypebill_image.image = UIImage(named: imagedatabill[selecticon])
        
    }
    
    func insertComma(a: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2


        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:a))!
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
