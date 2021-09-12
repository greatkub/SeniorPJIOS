//
//  BaseTabBarController.swift
//  Senior1PJ
//
//  Created by Krittamet Chuwongworaphinit on 27/4/2564 BE.
//

import UIKit
import Alamofire

class BaseTabBarController: UITabBarController {
    
//    var aligatoAPI: [[String: Any]] = []
    
    var urlFile = "https://536a20dd-fe69-4914-8458-6ad1e9b3ce18.mock.pstmn.io/test"
    var sentJSON : [[String:Any]] = []
    var getEveryRecordTotalFromThePersonWasSelected = [[String:Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        callJSON()
        getJSONData(0)
        setupTabBar()

        
    }
    
    
    func getJSONData(_ who: Int) {
    
        //option to use local json file
            guard let path = Bundle.main.path(forResource: "dataMonth", ofType: "json") else {
                return
            }
            let url = URL(fileURLWithPath: path)
    
        
        AF.request(url).responseJSON { (response) in
            switch response.result
            {
            case .success(_):
                let jsondata = response.value as! [[String:Any]]?
                allJSON_GB = jsondata!
                thisPerson_GB = allJSON_GB[who]
                mysigninreverse = thisPerson_GB["signin"] as! [[String:Any]]
                mysigninreverse =  mysigninreverse.reversed()
                
                print("gh243 \(mysigninreverse)")
                
                
//                var myPersonalData = personalInfo()
                
//                myPersonalData.firstName = thisPerson_GB["firstName"] as! String
//                personalInfo(firstName: thisPerson_GB["firstName"] as! String,
//                             lastName: thisPerson_GB["lastName"] as! String,
//                             building: thisPerson_GB["building"] as! String,
//                             room: thisPerson_GB["room"] as! String,
//                             birthDate: thisPerson_GB["birthDate"] as! String,
//                             phoneNumber: thisPerson_GB["phoneNo"] as! String)
                
//                var a = personalInfo().room
                
//                print("youu33\(personalInfo().residenceInfo)")
                
                
    
            case .failure(let error):
                print("Error Ovvured \(error.localizedDescription)")
            }
        }
    }
    
    
//    override func viewDidAppear(_ animated: Bool) {
//
////        self.tabBarItem.image = imagesize
//    }
    
    func setupTabBar() {
//       tabBarController?.tabBar.items![0].title = "Week"
        self.tabBar.tintColor = #colorLiteral(red: 0.2594431043, green: 0.3677232862, blue: 0.5306056142, alpha: 1)
       tabBar.items![0].image = resizeImage(image: UIImage(named: "stack")!, targetSize: CGSize(width: 25.0, height: 25.0))
//       tabBarController?.tabBar.items![1].title = "Profile"
        tabBar.items![1].image = resizeImage(image: UIImage(named: "wallet")!, targetSize: CGSize(width: 22.0, height: 22.0))
        tabBar.items![2].image = resizeImage(image: UIImage(named: "menu")!, targetSize: CGSize(width: 22.0, height: 22.0))
        
   }
    
//    func callJSON() {
//        getJSON(url: urlFile, completion: { (res, err) in
//            if let response = res {
//                // success
////                self.aligatoAPI = response
//                self.sentJSON = response
//            } else {
//                // failure
//                print(err)
//
//            }
//        })
//    }
//
//
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
