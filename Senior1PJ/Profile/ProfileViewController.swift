//
//  ProfileViewController.swift
//  Senior1PJ
//
//  Created by Krittamet Chuwongworaphinit on 15/6/2564 BE.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet var profilecontainer: UIView!
    var whoBeSelected : [[String:Any]] = []
    @IBAction func goProfile(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "dataprofileviewcontroller") as! DataProfileViewController
        
        profilecontainer.alpha = 1
        
        self.present(vc, animated: true, completion: nil)
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tabbar = tabBarController as! BaseTabBarController
        whoBeSelected = tabbar.sentJSON
        profilecontainer.alpha = 0
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ChartsViewController {
            destination.dataJ = whoBeSelected
        }
        
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
