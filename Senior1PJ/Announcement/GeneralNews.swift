//
//  GeneralTableViewCell.swift
//  Senior1PJ
//
//  Created by Krittamet Chuwongworaphinit on 30/4/2564 BE.
//

import UIKit

class GeneralNews: UITableViewCell {
    
    @IBOutlet var image_cell: UIImageView!
    @IBOutlet var general_label: UILabel!
    @IBOutlet var date_announce: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
