//
//  SegueFromRight.swift
//  Senior1PJ
//
//  Created by Krittamet Chuwongworaphinit on 13/5/2564 BE.
//

import Foundation
import UIKit

class SegueFromRight: UIStoryboardSegue {

    override func perform() {
        let src = self.source
        let dst = self.destination

        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0)

        UIView.animate(withDuration: 0.15,
               delay: 0.0,
               options: UIView.AnimationOptions.curveEaseInOut,
               animations: {
                    dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
            },
                   completion: { finished in
                    src.present(dst, animated: false, completion: nil)
        })
    }
}
