//
//  PetitionViewController.swift
//  Senior1PJ
//
//  Created by Krittamet Chuwongworaphinit on 10/8/2564 BE.
//

import UIKit
import Alamofire

class PetitionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
 
    //Search bar
    @IBOutlet var searchbar: UISearchBar!
    var filterData: [[String: Any]]!
    
    let searchController = UISearchController()
    
    @IBAction func goBackk(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
        self.dismiss(animated: true)
    }
    
    @IBOutlet var myTableView: UITableView!
    
    //Should be Model
    var dataJ = [[String:Any]]()
    
    let refreshTB = UIRefreshControl()
    
    @IBOutlet var date: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        date.text = datetoday
        myTableView.dataSource = self
        myTableView.delegate = self
        getJSONData()
        
        refreshTB.tintColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        refreshTB.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        // Search bar
        myTableView.addSubview(refreshTB)
        searchbar.delegate = self
        filterData = dataJ
        


//        title = "Search"
//        searchController.searchResultsUpdater =  self
//        searchbar = searchController
        
    }
    
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
    
        if searchText.isEmpty {
            filterData = dataJ
        } else {
            filterData = dataJ.filter { j -> Bool in
                if let title = j["title"] as? String {
                    print("TITLE: \(title) - SEARCH: \(searchText)")
                    print("IS CONTAIN: \(title.lowercased().contains(searchText.lowercased()))")
                    return title.lowercased().contains(searchText.lowercased())
                }
                
                return false
            }
        }
        
        

//
//        filterData = searchText.isEmpty ? dataJ : dataJ.filter { (item: String) -> Bool in
//            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
//        }
        
        myTableView.reloadData()
    }
    
    @objc func refreshData() {
        getJSONData()
        refreshTB.endRefreshing()
        myTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return filterData.count
    }
    
    var tag = 0
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "detailpetitionvc") as! DetailPetitionVC
        let i = indexPath.section
        
        vc.title2 = filterData[i]["title"] as! String
        vc.status = filterData[i]["statusInfo"] as! String
        let date = filterData[i]["petitionDate"] as? String
        vc.date =  reformat2(str: date!, toThis: "dd/MM/yyyy")
        vc.content = filterData[i]["description"] as! String
        vc.num = indexPath.section
        vc.dataJ = filterData
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PetitionCell
        let index = indexPath.section
        
        
        cell.title_lb.text = filterData[index]["title"] as? String
        cell.content_lb.text = filterData[index]["description"] as? String
        let date = filterData[index]["petitionDate"] as? String
        cell.date_lb.text = reformat2(str: date!, toThis: "dd/MM/yyyy")
        cell.status_lb.text = filterData[index]["statusInfo"] as? String
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexpath: IndexPath) {
//        let tabbar =  tabBarController as! BaseTabBarController
        let petitionid = dataJ[indexpath.section]["id"] as! Int
        
        let deletePetition = "\(currentJSON)/api/v1/petition/delete-petition/\(petitionid)"
        
        let parameters: [String: Any] = [
            "isDeleted": true
        ]
        
        
        if editingStyle == .delete {
            
            AF.request(deletePetition, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { response in
//                print(response.response?.statusCode)
//
//                self.showAlert(title: "Successfully", message: "Your petition has been added")
            })
            
            dataJ.remove(at: indexpath.section)
//            self.myTableView.reloadData()
//            myTableView.deleteRows(at: [indexpath], with: .automatic)
           

            
            

//            self.myTableView.deleteRows(at: [indexpath], with: UITableView.RowAnimation.automatic)
            self.myTableView.reloadData()

            
//            print("\(indexpath.section)")
            


        }
    }
    
    @objc func showMiracle() {
        let slideVC = PetitionOverlayView()

        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        self.present(slideVC, animated: true, completion: nil)
    }
    
    @IBAction func showOverPetition(_ sender: Any) {
        //Success
        //Payment is successful
        
        showMiracle()

    }
    
    
    func getJSONData() {
        
        //option to use local json file
        guard let path = Bundle.main.path(forResource: "dataMonth", ofType: "json") else {
            return
        }
        let url1 = URL(fileURLWithPath: path)
        let UrlReal = "\(currentJSON)/api/v1/petition/petitions/user/\(currentUserId)"

//      let urlFile2 = "https://536a20dd-fe69-4914-8458-6ad1e9b3ce18.mock.pstmn.io/news"
//        let urlFile = "http://haritibhakti.com/jsondata/vegetables.json"
        
        AF.request(UrlReal).responseJSON { (response) in
            switch response.result
            {
            case .success(_):
                if let jsondata = response.value as? [[String:Any]] {
                    self.dataJ = jsondata
                    self.filterData = self.dataJ
                } else {
                    
                }
//                let jsondata = response.value as! [[String:Any]]?
//                self.dataJ = jsondata!
                
                self.myTableView.reloadData()

                self.view.layoutIfNeeded()

            case .failure(let error):
                print("Error Ovvured \(error.localizedDescription)")
            }
        }
    }
}

extension PetitionViewController: UIViewControllerTransitioningDelegate {
    internal func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PetitionPresentation(presentedViewController: presented, presenting: presenting)
    }
}

