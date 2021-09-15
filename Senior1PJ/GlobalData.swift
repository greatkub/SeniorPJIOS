//
//  GlobalJSONData.swift
//  Senior1PJ
//
//  Created by Krittamet Chuwongworaphinit on 29/6/2564 BE.
//

import Foundation


var currentJSON = "https://habitat1.azurewebsites.net"
var currentUserId = 10025
var db_currentPass = "123"
var currentProfile = ""

var allJSON_GB = [[String:Any]]()
var urlFile_GB = "https://536a20dd-fe69-4914-8458-6ad1e9b3ce18.mock.pstmn.io/test"
var datetoday = ""

var thisPerson_GB = [String:Any]()
var mysigninreverse = [[String:Any]]()


struct personalInfo {
    var firstName = thisPerson_GB["firstName"] as! String
    var lastName = thisPerson_GB["lastName"] as! String
    var building = thisPerson_GB["building"] as! String
    var room = thisPerson_GB["room"] as! String
    var birthDate = thisPerson_GB["birthDate"] as! String
    var phoneNumber = thisPerson_GB["phoneNo"] as! String
    var residenceInfo = thisPerson_GB["signin"] as? [[String:Any]]
    
}

var signin = personalInfo().residenceInfo
var index_GB = 0

struct residenceHistory {
    
    var month = signin?[index_GB]["month"] as! Int
    var status = signin?[index_GB]["status"] as! Int
    var datetoPay = signin?[index_GB]["dateToPay"] as! String
//    var bill = signin[0]["bill"] as AnyObject
    
}

struct reversedResedenceHistory {
    var month = mysigninreverse[index_GB]["month"] as! Int
    var status = mysigninreverse[index_GB]["status"] as! Int
    var datetoPay = mysigninreverse[index_GB]["dateToPay"] as! String
    var bill = mysigninreverse[index_GB]["bill"] as? [String:Any]

//    mysigninreverse
}

var billing = reversedResedenceHistory().bill

struct billingHistoryRV {
    var roomprice = billing?["roomPrice"] as! Int
    var elec = billing?["elec"] as! Int
    var water = billing?["water"] as! Int
    var deposit = billing?["deposit"] as! Int
    var punish = billing?["punish"] as! Int
    var total = billing?["fakeTotal"] as! Int
    var punishDetail = billing?["punishDetail"] as? [String:Any]
    
}


var punishing = billingHistoryRV().punishDetail

struct punishInfo {
    var object = punishing?["Object"] as! String
    var punishPrice = punishing?["punishPrice"] as! Int
}

func reformat(str:String, toThis:String) -> String {
    //Set up a DateFormatter for input dates in "Internet" date format"
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
    var thisStr = ""

    //Set up an output date formatter (in the local time zone)
    let outputFormatter = DateFormatter()
    outputFormatter.dateFormat = "\(toThis)"

    if let formattedtoDate = inputFormatter.date(from: str) {
        let formattedtoString = outputFormatter.string(from: formattedtoDate)
//            cell.monthLabel.text = formattedtoString
        thisStr = formattedtoString
//            date = formattedtoString
        print("'\(str)' = '\(formattedtoString)'")
    } else {
        print("Can't convert the string \(str) to a Date")
    }
    return thisStr
    
    
}


func reformat2(str:String, toThis:String) -> String {
    //Set up a DateFormatter for input dates in "Internet" date format"
    let inputFormatter = DateFormatter()
//    inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
    var thisStr = ""

    //Set up an output date formatter (in the local time zone)
    let outputFormatter = DateFormatter()
    outputFormatter.dateFormat = "\(toThis)"

    if let formattedtoDate = inputFormatter.date(from: str) {
        let formattedtoString = outputFormatter.string(from: formattedtoDate)
//            cell.monthLabel.text = formattedtoString
        thisStr = formattedtoString
//            date = formattedtoString
        print("'\(str)' = '\(formattedtoString)'")
    } else {
        print("Can't convert the string \(str) to a Date")
    }
    return thisStr
    
    
}

func insertComma(a: Double) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.minimumFractionDigits = 2
    numberFormatter.maximumFractionDigits = 2


    numberFormatter.numberStyle = .decimal
    return numberFormatter.string(from: NSNumber(value:a))!
}
