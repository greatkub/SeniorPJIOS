//
//  QROverlayView.swift
//  Senior1PJ
//
//  Created by Krittamet Chuwongworaphinit on 15/6/2564 BE.
//

import UIKit
import SwiftUI

class QROverlayView: UIViewController {
   
    
    var date = ""
    var total = ""
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    
    @IBOutlet weak var slideIdicator2: UIView!
    @IBOutlet weak var subscribeButton: UIView!
    @IBOutlet var date_label: UILabel!
    @IBOutlet var moneylabel: UILabel!
    @IBOutlet var qrcode_image: UIImageView!
    @IBOutlet var sliptView: UIView!
    
    @IBOutlet var title_label: UILabel!
    var codenamefinancial = ""

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        
        slideIdicator2.roundCorners(.allCorners, radius: 10)
//        subscribeButton.roundCorners(.allCorners, radius: 10)
        title_label.adjustsFontSizeToFitWidth = true
        date_label.adjustsFontSizeToFitWidth = true
        moneylabel.adjustsFontSizeToFitWidth = true
        sliptView.layer.borderWidth = 1
        sliptView.layer.borderColor = #colorLiteral(red: 0.8469749093, green: 0.8471175432, blue: 0.8469560742, alpha: 1)
        
        moneylabel.text = total
        date_label.text = date
        
        print("HIx3" + total)
        print(date)
        
        codenamefinancial = withoutCrc16Ewallet + ewallet
        print(codenamefinancial)
        
        
        qrcode_image.image = generateQRCode(from: codenamefinancial)

       
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
    
  
    
    @IBAction func saveToDevice(_ sender: Any) {
        let imageData = self.view.takeScreenshot()
        UIImageWriteToSavedPhotosAlbum(imageData, nil, nil, nil)
        
        self.showAlert(title: "", message: "Save Successful")

        
    }
    
    
    @IBAction func shareSheet(_ sender: Any) {
        let imageData = self.view.takeScreenshot()

        let shareSheetVC = UIActivityViewController(
            activityItems: [imageData], applicationActivities: nil
        )
        present(shareSheetVC, animated: true, completion: nil)
    }
    
    @IBAction func goback(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
  
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 0 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                
            }
        }
    }
}

//extension UIImageView {
//
//    static func makeImage() -> UIImage? {
//        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
//
//        guard let context = UIGraphicsGetCurrentContext() else { return nil }
//        layer.render(in: context)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//
//        UIGraphicsEndImageContext()
//
//
//        return image
//    }
//
//}
extension UIView {

    public func takeScreenshot() -> UIImage {

        // Begin context
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)

        // Draw view in that context
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)

        // And finally, get image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        if (image != nil)
        {
            return image!
        }
        return UIImage()
    }
}
