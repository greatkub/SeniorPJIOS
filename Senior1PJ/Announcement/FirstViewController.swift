//
//  FirstViewController.swift
//  Senior1PJ
//
//  Created by Krittamet Chuwongworaphinit on 30/4/2564 BE.
//

import UIKit
import Alamofire
//import SwiftyJSON
import AlamofireImage

class FirstViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var sliderCollectionView: UICollectionView!
    
    @IBOutlet var LogoName: UILabel!
    @IBOutlet var bodyLabel: UILabel!
    @IBOutlet var dateHeader: UILabel!
    @IBOutlet var myTableView: UITableView!
    @IBOutlet var generalLabel: UILabel!
    @IBOutlet var heightConstant: NSLayoutConstraint!
    @IBOutlet var page_controller: UIPageControl!
    
    @IBOutlet var bringToFrontHeader: UIView!
    
    @IBOutlet var bringTobackBody: UIView!
    let count = 14
    //    var currentPage: Int =  0
    var list_image_important_anouncement: [String] = ["0","1","2"]
    
    var kept = 0
    var keptImage: [UIImage] = []
    let dispatchGroup = DispatchGroup()
    let screenSize: CGRect = UIScreen.main.bounds
    var date = ""
    var timer = Timer()
    var counter = 0
    
    
    
    
    
    /*-----------------------------------------------------------------*/
    /*                                                                 */
    /*                           VIEW DIDLOAD ()                       */
    /*                                                                 */
    /*-----------------------------------------------------------------*/
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        //        self.bringToFrontHeader.bringSubviewToFront(myTableView)
        /// Resizing UITableView height to fit content
        /// Collection View Cell height 70 + footer 12 = 82
        
        getJSONData()
        dateHeader.text = datetoday
        print(datetoday)
        // if count == 1 {
        //        } else {
        //            heightConstant.constant = CGFloat(Double(count) * 82 - Double(count))
        //        }
        
        myTableView.separatorStyle = .none
        
        LogoName.adjustsFontSizeToFitWidth = true
        bodyLabel.adjustsFontSizeToFitWidth = true
        dateHeader.adjustsFontSizeToFitWidth = true
        generalLabel.adjustsFontSizeToFitWidth = true
        
        page_controller.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //
    //        //table cell
    //        if let destination = segue.destination as? DetailNews {
    //            destination.detailRowAt = kept
    //            destination.newsList = newsList
    //            destination.date = date
    //
    //        }
    //
    //
    //
    //    }
    
    
    
    
    
    /*-----------------------------------------------------------------*/
    /*                                                                 */
    /*                              JSON ()                            */
    /*                                                                 */
    /*-----------------------------------------------------------------*/
    var newsList = [[String:Any]]()
    var generalnews = [[String:Any]]()
    var importantnews = [[String:Any]]()
    
    
    
    func getJSONData() {
        
        //option to use local json file
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            return
        }
        let url = URL(fileURLWithPath: path)
        let urlFile2 = "https://536a20dd-fe69-4914-8458-6ad1e9b3ce18.mock.pstmn.io/news"
        
        let jameAPI = "\(currentJSON)/api/v1/announcement/announcements"
        //        let urlFile = "http://haritibhakti.com/jsondata/vegetables.json"
        AF.request(jameAPI).responseJSON { (response) in
            switch response.result
            {
            case .success(_):
                //                let jsondata = response.value as! [[String:Any]]?
                //                self.newsList = jsondata!
                
                let jsondata = response.value as! [[String:Any]]?
                
                self.generalnews = (jsondata?.filter{$0["type"] as! String == "General News"})!
                self.importantnews = (jsondata?.filter{$0["type"] as! String != "General News"})!
                
                
                self.page_controller.numberOfPages = self.importantnews.count
                
                //                self.generalnews = jsondata.filter{$0["post"] != "new"}
                print(self.generalnews)
                self.myTableView.reloadData()
                self.sliderCollectionView.reloadData()
                
            case .failure(let error):
                print("Error Ovvured \(error.localizedDescription)")
            }
        }
    }
    
    
    
    
    
    
    
    
    /*-----------------------------------------------------------------*/
    /*                                                                 */
    /*                          COLLECTION VIEW                        */
    /*                                                                 */
    /*-----------------------------------------------------------------*/
    ///Important news.swift
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return importantnews.count
    }
    
    
    
    /*--------------------------------------------------------------------------*/
    /*  SIZE FOR ITEM AT -> SET ELEMENT IN CONTENT FIT TO COLLECTION VIEW SIZE  */
    /*  IN THIS CASE-> IMAGE VIEW IS EXPANDED TO FIT THE COLLECTION VIEW SIZE   */
    /*--------------------------------------------------------------------------*/
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(
            width: collectionView.bounds.width,
            height: collectionView.bounds.height
        )
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImportantNews
        let index = indexPath.section
        
        let urlImage = importantnews[index]["imageUrl"] as? String
        
        AF.request(urlImage!).responseImage {
            (response) in
            
            if let image = response.value{
                
                DispatchQueue.main.async {
                    self.keptImage += [image]
                    cell.image_announce.image = image
                }
            }
            
        }
        
        
        //        cell.image_announce.image = UIImage(named: list_image_important_anouncement[indexPath.row])
        cell.image_announce.layer.cornerRadius = 0
        
        cell.image_announce.contentMode = .scaleToFill
        cell.image_announce.layer.masksToBounds = true
        let redate = importantnews[index]["announceDate"] as! String
        cell.date_lb.text = reformat(str: redate, toThis: "dd/MM/yyyy")
        cell.impannounce_lb.text = importantnews[index]["title"] as! String
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        page_controller.currentPage = indexPath.row
        
    }
    
    
    @objc func changeImage() {
        
        if counter < importantnews.count {
            let index = IndexPath.init(item: counter, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            page_controller.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            page_controller.currentPage = counter
            counter = 1
        }
    }
    
    
    
    
    /*-----------------------------------------------------------------*/
    /*                                                                 */
    /*                         VC to DetailNews                        */
    /*                                                                 */
    /*-----------------------------------------------------------------*/
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //        let vc = self.storyboard?.instantiateViewController(identifier: "detail_announce") as! DetailNews
        //
        ////        vc.image_from_tab_announcement = list_image_important_anouncement[indexPath.row]
        //        vc.detailRowAt = kept
        //        vc.newsList = generalnews
        //        vc.date = date
        //
        //
        //        self.navigationController?.pushViewController(vc, animated: true)
        //        print("Collection view at row \(indexPath.row)")
        
        
        let vc = self.storyboard?.instantiateViewController(identifier: "detail_announce") as! DetailNews
        
        //        vc.image_from_tab_announcement = list_image_important_anouncement[indexPath.row]
        vc.detailRowAt = indexPath.section
        vc.dataJ = importantnews
        vc.date = date
        vc.postid = importantnews[indexPath.section]["id"] as! Int
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        //        performSegue(withIdentifier: "showDetail", sender: self)
        
    }
    
    
    
    
    
    
    
}








/*-----------------------------------------------------------------*/
/*                                                                 */
/*                           TABLE VIEW                            */
/*                                                                 */
/*-----------------------------------------------------------------*/
///general news.swift


extension FirstViewController:  UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let index = indexPath.section
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GeneralNews
        //image_cell title_label general_label date_announce
        //        var datejson = newsList[index]["createdAt"] as! String
        
        
        //        let dateStr = str.toDate(dateFormat: "yyyy-MM-dd'T'HH:mm:ssZ")
        
        //        var str = "2021-05-23T06:35:47.409Z"
        //        var str2 = "12:16:45"
        //        let dateFormatter = DateFormatter()
        //        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        //        var dateFromStr = dateFormatter.date(from: str)!
        //        var timeFromDate = dateFormatter.string(from: dateFromStr)
        //        print("vdf2 \(timeFromDate)")
        
        var str = generalnews[index]["announceDate"] as! String
        
        
        //Set up a DateFormatter for input dates in "Internet" date format"
        var inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        //        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        
        
        //Set up an output date formatter (in the local time zone)
        var outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "d/MM/yyyy"
        
        if let formattedtoDate = inputFormatter.date(from: str) {
            let formattedtoString = outputFormatter.string(from: formattedtoDate)
            cell.date_announce.text = formattedtoString
            date = formattedtoString
            print("'\(str)' = '\(formattedtoString)'")
        } else {
            print("Can't convert the string \(str) to a Date")
        }
        //        var time = Date()
        //        var formatter = DateFormatter()
        //        formatter.dateFormat = "MMM d yyyy, h:mm:ss a"
        //        let formattedtoDate = formatter.string(from: time)
        //
        //
        //        let dateFormatterPrint = DateFormatter()
        //        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        //
        //        let date: NSDate? = dateFormatterPrint.string(from: "2016-02-29 12:24:26")
        
        //        let formattedtoString = formatter.string(from: formattedtoDate)
        
        //        print("cc12\(formattedtoDate)")
        
        cell.general_label.text = generalnews[index]["title"] as? String
        let urlImage = generalnews[index]["imageUrl"] as? String
        
        AF.request(urlImage!).responseImage {
            (response) in
            
            if let image = response.value{
                
                DispatchQueue.main.async {
                    self.keptImage += [image]
                    cell.image_cell.image = image
                }
            }
            
        }
        
        
        return cell
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return generalnews.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 11
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.clear
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        //        var num:Int = Int(screenSize.height / 14)
        //        heightConstant.constant = CGFloat(Double(newsList.count) * Double(num + 11))
        //
        //        return CGFloat(num)
        
        heightConstant.constant = CGFloat(Double(generalnews.count) * 81)
        
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        kept = indexPath.section
        
        let vc = self.storyboard?.instantiateViewController(identifier: "detail_announce") as! DetailNews
        
        //        vc.image_from_tab_announcement = list_image_important_anouncement[indexPath.row]
        vc.detailRowAt = kept
        vc.dataJ = generalnews
        vc.date = date
        vc.postid = generalnews[indexPath.section]["id"] as! Int
        
        
        self.navigationController?.pushViewController(vc, animated: true)
        //        print("Collection view at row \(indexPath.row)")
        //        performSegue(withIdentifier: "showDetail", sender: self)
        //        print("selected \(indexPath.section)")
        
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if let destination = segue.destination as? DetailNews {
    //            destination.detailRowAt = kept
    //            destination.newsList = newsList
    //            destination.date = date
    //
    //        }
    //    }
    //
    
    
    
}
extension String {
    func toDate(dateFormat: String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        
        let date: Date? = dateFormatter.date(from: self)
        return date
    }
}

