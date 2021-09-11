//
//  MenuCell.swift
//  Senior1PJ
//
//  Created by Krittamet Chuwongworaphinit on 7/8/2564 BE.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet var icon_image: UIImageView!
    @IBOutlet var listmenu_lb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
