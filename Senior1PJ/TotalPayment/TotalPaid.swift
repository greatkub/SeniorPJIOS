//
//  TotalPaid.swift
//  Senior1PJ
//
//  Created by Krittamet Chuwongworaphinit on 8/5/2564 BE.
//

import UIKit

class TotalPaid: UITableViewCell {

    @IBOutlet var electricwaterBill: UIView!

    @IBOutlet var topMonet_label: UILabel!
    
    @IBOutlet var lowmoney_label: UILabel!
    
    @IBOutlet var typeName_label: UILabel!
    @IBOutlet var logoType_image: UIImageView!
    @IBOutlet var dateToPay: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func animate() {
        UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.contentView.layoutIfNeeded()
        })
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
