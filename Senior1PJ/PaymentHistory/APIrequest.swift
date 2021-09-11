//
//  APIrequest.swift
//  Senior1PJ
//
//  Created by Krittamet Chuwongworaphinit on 14/6/2564 BE.
//

import Foundation
import Alamofire
import UIKit


func getJSON(url: String, completion: @escaping (_ response: [[String: Any]]?, _ err: Error?) -> Void) {
    
    //option to use local json file
//    guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
//        return
//    }
//    let url = URL(fileURLWithPath: path)
  
//        let urlFile = "http://haritibhakti.com/jsondata/vegetables.json"
    AF.request(url).responseJSON { (response) in
        switch response.result
        {
        case .success(_):
            let jsondata = response.value as! [[String:Any]]
//            self.newsList = jsondata!
//            print(self.newsList)
//            self.myTableView.reloadData()
            completion(jsondata, nil)
            
        case .failure(let error):
            print("Error Ovvured \(error.localizedDescription)")
            completion(nil, error)
        }
    }
    
    
}

//        getJSONData2(url: "https://536a20dd-fe69-4914-8458-6ad1e9b3ce18.mock.pstmn.io/test", completion: { (res, err) in
//            if let response = res {
//                // success
//                print("great22\(response)")
//                print("end")
//            } else {
//                // failure
//            }
//        })

//OLD VERSION

func getJSONData() {

    //option to use local json file
//        guard let path = Bundle.main.path(forResource: "dataMonth", ofType: "json") else {
//            return
//        }
//        let url = URL(fileURLWithPath: path)
//
//    let urlFile = "https://536a20dd-fe69-4914-8458-6ad1e9b3ce18.mock.pstmn.io/test"
//    AF.request(urlFile).responseJSON { (response) in
//        switch response.result
//        {
//        case .success(_):
//            let jsondata = response.value as! [[String:Any]]?
//            self.monthList = jsondata!
//        
////            self.myTableView.reloadData()
//
//        case .failure(let error):
//            print("Error Ovvured \(error.localizedDescription)")
//        }
//    }
//}

}
