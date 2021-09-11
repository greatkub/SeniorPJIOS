//
//  CellHistory.swift
//  Senior1PJ
//
//  Created by Krittamet Chuwongworaphinit on 14/6/2564 BE.
//

import UIKit

class CellHistory: UITableViewCell {
    @IBOutlet var date_label: UILabel!
    @IBOutlet var amount_label: UILabel!
    @IBOutlet var difference_label: UILabel!
    
    @IBOutlet var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
