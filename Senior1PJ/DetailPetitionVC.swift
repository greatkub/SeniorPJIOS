//
//  DetailPetitionVC.swift
//  Senior1PJ
//
//  Created by Krittamet Chuwongworaphinit on 16/8/2564 BE.
//

import UIKit
import Alamofire
import AlamofireImage

class DetailPetitionVC: UIViewController {
    
    @IBOutlet var title_lb: UILabel!
    @IBOutlet var status_lb: UILabel!
    @IBOutlet var date_lb: UILabel!
    @IBOutlet var myimage: UIImageView!
    @IBOutlet var content_tv: UILabel!
    @IBOutlet var datesolve_lb: UILabel!
    
    
    var title2 = ""
    var status = ""
    var date = ""
    var content = ""
    var num = 0
    var dataJ = [[String:Any]]()
    var solvedDate = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()

        title_lb.text = title2
        status_lb.text = status
        date_lb.text = "Post at " + date
        content_tv.text = content
        
        if status_lb.text != "Unsolved" {
            status_lb.textColor = #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1)
            status_lb.text = "Status: Solved"

            datesolve_lb.text =  reformat2(str: solvedDate, toThis: "dd/MM/yyyy HH:mm") + " hrs."
        } else {
            status_lb.textColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
            status_lb.text = "Status: Unsolved"

            datesolve_lb.visibility = .gone
        }
        
        // Do any additional setup after loading the view.
        let urlImage = dataJ[num]["image"] as? String
        
        AF.request(urlImage!).responseImage {
            (response) in
            
            if let image = response.value{
                
                DispatchQueue.main.async {
    
                    self.myimage.image = image
                }
            }
            
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
