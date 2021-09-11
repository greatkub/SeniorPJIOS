//
//  CollectionViewCell_Announce_Important.swift
//  Senior1PJ
//
//  Created by Krittamet Chuwongworaphinit on 30/4/2564 BE.
//

import UIKit

class ImportantNews: UICollectionViewCell {
    
    @IBOutlet var image_announce: UIImageView!
    
    @IBOutlet var view_frameimage: UIView!
    
    @IBOutlet var date_lb: UILabel!    
    @IBOutlet var impannounce_lb: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        view_frameimage.clipsToBounds = true
        view_frameimage.layer.cornerRadius = 10

    }
    
}
