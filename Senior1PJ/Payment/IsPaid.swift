//
//  IsPaid.swift
//  Senior1PJ
//
//  Created by Krittamet Chuwongworaphinit on 6/5/2564 BE.
//

import UIKit

class IsPaid: UITableViewCell {
    @IBOutlet var monthLabel: UILabel!
    @IBOutlet var paidLabel: UILabel!
    @IBOutlet var chevronImage: UIImageView!
    @IBOutlet var frameChevron: UIView!
    @IBOutlet var datePay_label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
