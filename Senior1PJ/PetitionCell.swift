//
//  PetitionTableViewCell.swift
//  Senior1PJ
//
//  Created by Krittamet Chuwongworaphinit on 10/8/2564 BE.
//

import UIKit

class PetitionCell: UITableViewCell {

    @IBOutlet var title_lb: UILabel!
    @IBOutlet var date_lb: UILabel!
    @IBOutlet var status_lb: UILabel!
    @IBOutlet var content_lb: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
