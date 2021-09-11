import UIKit
import Charts
import Alamofire
import SwiftyJSON
import AlamofireImage

class ChartsViewController: UIViewController, ChartViewDelegate {
    
    
    
    @IBOutlet var buildingname: UILabel!
    @IBOutlet var roomname: UILabel!
    
    @IBOutlet var title_lavel: UILabel!
    @IBOutlet var date_lb: UILabel!
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)

        self.dismiss(animated: true)
    }
//    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet var lineChartView: BarChartView!
    
    //  if you want to use line chart you must to change BarChartDataEntry to ChartDataEntry
    
    var chartMonthList: [String] = []
    var chartTotalList: [Double] = []
    var arrayDiffer = [String]()
    let dispatchGroup = DispatchGroup()
    @IBOutlet var heightConstant: NSLayoutConstraint!
    
    
    @IBOutlet var myTableView: UITableView!
    var realurl = "\(currentJSON)/api/v1/filter/filter-overall/user/\(currentUserId)/Overall/history"
//    var realurl = "https://536a20dd-fe69-4914-8458-6ad1e9b3ce18.mock.pstmn.io/testhistory"

//    https://536a20dd-fe69-4914-8458-6ad1e9b3ce18.mock.pstmn.io/testhistory
    //    var lineChart = LineChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        date_lb.adjustsFontSizeToFitWidth = true
        title_lavel.adjustsFontSizeToFitWidth = true
        // Do any additional setup after loading the view.
        date_lb.text = datetoday

//        showJSON()
        getJSONData()
        order()
        getJSONProfile()
       

        
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.realurl = "\(currentJSON)/api/v1/filter/filter-overall/user/\(currentUserId)/Overall/history"
            
//            self.chartMonthList = [String]()
//            self.chartTotalList = [Double]()
//            lineChartView.notifyDataSetChanged()
//            lineChartView.invalidate() // refresh
            
            
            self.getJSONData()
        }
        else if sender.selectedSegmentIndex == 1 {
            self.realurl = "\(currentJSON)/api/v1/filter/filter-electricity/user/\(currentUserId)/Electricity/history"
            
//            self.chartMonthList = [String]()
//            self.chartTotalList = [Double]()
//            lineChartView.notifyDataSetChanged() // let the chart know it's data changed

            
            self.getJSONData()
        }
        else if sender.selectedSegmentIndex == 2 {
            self.realurl = "\(currentJSON)/api/v1/filter/filter-water/user/\(currentUserId)/Water/history"
            
//            self.chartMonthList = [String]()
//            self.chartTotalList = [Double]()
//            lineChartView.notifyDataSetChanged() // let the chart know it's data changed

            
            self.getJSONData()
            
        }
        else if sender.selectedSegmentIndex == 3 {
            self.realurl = "  \(currentJSON)/api/v1/filter/filter-other/user/\(currentUserId)/Other/history"
            
//            self.chartMonthList = [String]()
//            self.chartTotalList = [Double]()
            lineChartView.notifyDataSetChanged() // let the chart know it's data changed

            
            self.getJSONData()
          
        }
    }

   
    func order() {
//        showJSON(selectPerson: 0)
        play()
        
        
        
        setChartforbar(dataPoints: chartMonthList.reversed(), values: chartTotalList.reversed())
//        setChart2(dataPoints: chartMonthList.reversed(), values: chartTotalList.reversed())
//        countBABA()

//        dispatchGroup.notify(queue: .main) {
//            print("done")
//
//        }
    }
    
    var dataJ : [[String:Any]] = []
    var getEveryRecordTotalFromThePersonWasSelected = [[String:Any]]()
    
    
    func getJSONData() {
        
        //option to use local json file
     
    
       
//        let urlFile = "http://haritibhakti.com/jsondata/vegetables.json"
        AF.request(realurl).responseJSON { (response) in
            switch response.result
            {
            case .success(_):

                
//                let jsondata = response.value as! [[String:Any]]?
//                self.dataJ = jsondata!
//
                if let jsondata = response.value as? [[String:Any]] {
                    self.dataJ = jsondata
                } else {
                    
                }
                print(self.dataJ)
                print(self.dataJ.count)
                print("Hi")

                self.myTableView.reloadData()
                self.order()

                
            case .failure(let error):
                print("Error Ovvured \(error.localizedDescription)")
            }
        }
    }
    
    func getJSONProfile() {

       
        let urlFile = "\(currentJSON)/api/v1/mobile/user/\(currentUserId)"
        AF.request(urlFile).responseJSON { (response) in
            switch response.result
            {
            case .success(_):

                if let jsondata = response.value as? [[String:Any]] {
                    self.dataJ = jsondata
                    
                    let inbuild = jsondata[0]["building"] as? [[String:Any]]
                    
                    self.buildingname.text = inbuild?[0]["buildingName"] as! String
                    self.roomname.text = "Room \(inbuild?[0]["roomNumber"] as! String)"
                } else {
                    
                }
           

                
            case .failure(let error):
                print("Error Ovvured \(error.localizedDescription)")
            }
        }
    }
 
    
    
    //The point on the polyline is selected and called back
    func chartValueSelected(_ chartView: ChartViewBase, entry: BarChartDataEntry,
                           highlight: Highlight) {
            print("Selected a data")
            //Display the MarkerView label of the point
        self.showMarkerView(value: "\(entry.y.insertComma())")
    }

    //Display MarkerView label
    func showMarkerView(value:String){
       let marker = MarkerView(frame: CGRect(x: 20, y: 20, width: 80, height: 20))
       marker.chartView = self.lineChartView
       let label = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 20))
            label.text = "\(value)"
        label.textColor = #colorLiteral(red: 0.2594431043, green: 0.3677232862, blue: 0.5306056142, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
        label.backgroundColor = UIColor.white
        label.textAlignment = .center
        label.layer.cornerRadius = 6
        label.layer.borderWidth = 1
        label.layer.borderColor = #colorLiteral(red: 0.4949062467, green: 0.5911551118, blue: 0.7381506562, alpha: 1)
        marker.addSubview(label)
        
        self.lineChartView.marker = marker
    }

    //The point on the polyline is unchecked and callback
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
            print("Cancel selected data")
    }

    //Callback after the chart is zoomed by gesture
    func chartScaled(_ chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat) {
            print("The chart is zoomed")
    }

    //Callback after the chart is dragged by gesture
    func chartTranslated(_ chartView: ChartViewBase, dX: CGFloat, dY: CGFloat) {
          print("Chart moved")
    }

    

    
    func play() {
        chartMonthList = []
        chartTotalList = []
        dataEntries = []

        for i in 0..<dataJ.count {
            var monthPay = dataJ[i]["paidDateTime"] as! String
            var total = dataJ[i]["payAmount"] as! Double
            
            chartMonthList += [reformat(str: monthPay, toThis: "M/yy")]
            chartTotalList += [total]
            
            
        }
        
        lineChartView.delegate = self

        
    }
    


    var dataEntries: [BarChartDataEntry] = []

    
    func setChart2(dataPoints: [String], values: [Double]) {
//        dispatchGroup.enter()
       for i in 0 ..< dataPoints.count {
           dataEntries.append(BarChartDataEntry(x: Double(i), y: values[i]))
       }
        
    
       let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: "Units Payment")
       lineChartDataSet.axisDependency = .left
       lineChartDataSet.setColor(#colorLiteral(red: 0.2815539241, green: 0.3631723225, blue: 0.5181257129, alpha: 1))
       lineChartDataSet.setCircleColor(#colorLiteral(red: 0.2815539241, green: 0.3631723225, blue: 0.5181257129, alpha: 1)) // our circle will be dark red
       lineChartDataSet.lineWidth = 2.0
       lineChartDataSet.circleRadius = 4.0 // the radius of the node circle
       lineChartDataSet.fillAlpha = 1
       lineChartDataSet.fillColor = #colorLiteral(red: 0.515963912, green: 0.5865255594, blue: 0.7255458832, alpha: 1)
        
       lineChartDataSet.highlightColor = UIColor.white
       lineChartDataSet.drawCircleHoleEnabled = true
       lineChartDataSet.drawValuesEnabled = false

        

     
        
       var dataSets = [LineChartDataSet]()
       dataSets.append(lineChartDataSet)

        
        

       let lineChartData = LineChartData(dataSets: dataSets)
        lineChartView.data = lineChartData
        lineChartView.rightAxis.enabled = false
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        lineChartView.legend.enabled = true
        
        
        lineChartView.xAxis.granularity = 1
//        dispatchGroup.leave()
   }
    
    func setChartforbar(dataPoints: [String], values: [Double]) {
        for i in 0 ..< dataPoints.count {
            dataEntries.append(BarChartDataEntry(x: Double(i), y: values[i]))
        }
         
         let barChartDataSet = BarChartDataSet(entries: dataEntries, label: "Units Payment")
         barChartDataSet.axisDependency = .left
         barChartDataSet.setColor(#colorLiteral(red: 0.2815539241, green: 0.3631723225, blue: 0.5181257129, alpha: 1))
         barChartDataSet.highlightColor = UIColor.white
         barChartDataSet.drawValuesEnabled = false
        
         var dataSets = [BarChartDataSet]()
         dataSets.append(barChartDataSet)
         

         let barChartData = BarChartData(dataSets: dataSets)
 
          lineChartView.data = barChartData
          lineChartView.rightAxis.enabled = false
          lineChartView.xAxis.drawGridLinesEnabled = false
          lineChartView.xAxis.labelPosition = .bottom
          lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
          lineChartView.legend.enabled = true
 
 
          lineChartView.xAxis.granularity = 1
        
          lineChartView.leftAxis.axisMinimum = 0.0
        
        
    }
    
    

    
    
    

}
extension ChartsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
//        dispatchGroup.enter()
        print(dataJ.count)
        return dataJ.count

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        dispatchGroup.enter()

        return 1

    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        dispatchGroup.enter()

        let index = indexPath.section
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellHistory
//        let inBill = getEveryRecordTotalFromThePersonWasSelected.reversed()[index]["bill"] as! [String: Any]
//        cell.date_label.text = getEveryRecordTotalFromThePersonWasSelected.reversed()[index]["dateToPay"] as! String
        let datethis = dataJ[index]["paidDateTime"] as! String
        print(datethis)
        cell.date_label.text = reformat(str: datethis, toThis: "dd/MM/yy")
//        var alltotal = inBill["fakeTotal"] as! Double
        var amountJson = dataJ[index]["payAmount"] as! Int
        print(amountJson)

        cell.amount_label.text = Double(amountJson).insertComma()

        return cell

    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        dispatchGroup.enter()
     
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        dispatchGroup.enter()
        let headView = UIView()
        headView.backgroundColor = UIColor.clear

        return headView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        dispatchGroup.enter()

        heightConstant.constant = CGFloat(Double(dataJ.count) * 62)
        return 52
    }
    
//    func insertComma(a: Double) -> String {
//        let numberFormatter = NumberFormatter()
//        numberFormatter.minimumFractionDigits = 2
//        numberFormatter.maximumFractionDigits = 2
//
//
//        numberFormatter.numberStyle = .decimal
//        return numberFormatter.string(from: NSNumber(value:a))!
//    }
    
}
extension Double {
    func insertComma() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2


        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}

