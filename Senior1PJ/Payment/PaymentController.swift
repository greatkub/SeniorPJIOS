//
//  TestAlphaViewController.swift
//  Senior1PJ
//
//  Created by Krittamet Chuwongworaphinit on 6/5/2564 BE.
//

import UIKit

class PaymentController: UIViewController {

    
//    @IBOutlet var totalpayment_contrainer: UIView!
    @IBOutlet var monthpayment_container: UIView!
    @IBOutlet var nopayment_container: UIView!
    
//    public var callback: ((_ id: Int) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Start")
        
        
//        self.totalpayment_contrainer.alpha = 0
        self.monthpayment_container.alpha = 0
        self.nopayment_container.alpha = 1
//        self.pink.alpha = 0
//        self.green.alpha = 1
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.monthpayment_container.alpha = 1
        self.nopayment_container.alpha = 0
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("End")
    }
    
    public func test() {
        print("111111111")
    }
    
    var count = 0
    
    
    

        
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

