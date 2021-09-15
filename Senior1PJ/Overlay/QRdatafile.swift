//
//  QRdatafile.swift
//  Senior1PJ
//
//  Created by Krittamet Chuwongworaphinit on 29/6/2564 BE.
//

import Foundation

var billid = 0
var amountToPay = "0.50"
var phonePromptpay = "943542367"
let forPromtpayAndIdcard = "700"
let forEwallet = "900"
var eWalletid = "004999021296693"

let once = 12
let duplicate = 11

let c1 = "0002010102\(once)293\(forPromtpayAndIdcard)16A000000677010111"
let c1forE = "0002010102\(once)293\(forEwallet)16A000000677010111"

let c2forPhone = "01"
let c2forIDcard = "02"
let c2ForEwallet = "03"
let c3 = "13"
let bankaccount = "0533181945"

let c3forEwallet = "15"
let c4ifPhone = "0066"
let c4ifPhoneNo = phonePromptpay
let c4ifIdcard = "1104700023811"
let c5 = "5802TH"
let c6ifamountnotEmpty = "54"
let c6ifempty = "53"
let c6AddYourmoney = "0\(amountToPay.count)"
let c6amount = amountToPay
let c7 = "5303764"
let c8 = "6304"

//For promptpay
let withoutCrc16 = c1 + c2forPhone + c3 + c4ifPhone + c4ifPhoneNo + c5 + c6ifamountnotEmpty + c6AddYourmoney + c6amount + c7 + c8

//For Ewallet
//let withoutCrc16Ewallet = c1forE + c2ForEwallet + c3forEwallet + eWalletid + c5 + c6ifempty + "03" + "76454\(c6AddYourmoney)" + c6amount + c8

//Ewallet test mock with fakebank
let withoutCrc16Ewallet = String(amountToPay.count) + amountToPay + "amount" + "id" + String(billid) + String(String(billid).count)


//For promptpay
let cend = String(format:"%02X", crccccc16(s: withoutCrc16))
//For Ewallet
let ewallet = String(format:"%02X", crccccc16(s: withoutCrc16Ewallet))

var crcTable = [0x0000, 0x1021, 0x2042, 0x3063, 0x4084, 0x50a5,
0x60c6, 0x70e7, 0x8108, 0x9129, 0xa14a, 0xb16b,
0xc18c, 0xd1ad, 0xe1ce, 0xf1ef, 0x1231, 0x0210,
0x3273, 0x2252, 0x52b5, 0x4294, 0x72f7, 0x62d6,
0x9339, 0x8318, 0xb37b, 0xa35a, 0xd3bd, 0xc39c,
0xf3ff, 0xe3de, 0x2462, 0x3443, 0x0420, 0x1401,
0x64e6, 0x74c7, 0x44a4, 0x5485, 0xa56a, 0xb54b,
0x8528, 0x9509, 0xe5ee, 0xf5cf, 0xc5ac, 0xd58d,
0x3653, 0x2672, 0x1611, 0x0630, 0x76d7, 0x66f6,
0x5695, 0x46b4, 0xb75b, 0xa77a, 0x9719, 0x8738,
0xf7df, 0xe7fe, 0xd79d, 0xc7bc, 0x48c4, 0x58e5,
0x6886, 0x78a7, 0x0840, 0x1861, 0x2802, 0x3823,
0xc9cc, 0xd9ed, 0xe98e, 0xf9af, 0x8948, 0x9969,
0xa90a, 0xb92b, 0x5af5, 0x4ad4, 0x7ab7, 0x6a96,
0x1a71, 0x0a50, 0x3a33, 0x2a12, 0xdbfd, 0xcbdc,
0xfbbf, 0xeb9e, 0x9b79, 0x8b58, 0xbb3b, 0xab1a,
0x6ca6, 0x7c87, 0x4ce4, 0x5cc5, 0x2c22, 0x3c03,
0x0c60, 0x1c41, 0xedae, 0xfd8f, 0xcdec, 0xddcd,
0xad2a, 0xbd0b, 0x8d68, 0x9d49, 0x7e97, 0x6eb6,
0x5ed5, 0x4ef4, 0x3e13, 0x2e32, 0x1e51, 0x0e70,
0xff9f, 0xefbe, 0xdfdd, 0xcffc, 0xbf1b, 0xaf3a,
0x9f59, 0x8f78, 0x9188, 0x81a9, 0xb1ca, 0xa1eb,
0xd10c, 0xc12d, 0xf14e, 0xe16f, 0x1080, 0x00a1,
0x30c2, 0x20e3, 0x5004, 0x4025, 0x7046, 0x6067,
0x83b9, 0x9398, 0xa3fb, 0xb3da, 0xc33d, 0xd31c,
0xe37f, 0xf35e, 0x02b1, 0x1290, 0x22f3, 0x32d2,
0x4235, 0x5214, 0x6277, 0x7256, 0xb5ea, 0xa5cb,
0x95a8, 0x8589, 0xf56e, 0xe54f, 0xd52c, 0xc50d,
0x34e2, 0x24c3, 0x14a0, 0x0481, 0x7466, 0x6447,
0x5424, 0x4405, 0xa7db, 0xb7fa, 0x8799, 0x97b8,
0xe75f, 0xf77e, 0xc71d, 0xd73c, 0x26d3, 0x36f2,
0x0691, 0x16b0, 0x6657, 0x7676, 0x4615, 0x5634,
0xd94c, 0xc96d, 0xf90e, 0xe92f, 0x99c8, 0x89e9,
0xb98a, 0xa9ab, 0x5844, 0x4865, 0x7806, 0x6827,
0x18c0, 0x08e1, 0x3882, 0x28a3, 0xcb7d, 0xdb5c,
0xeb3f, 0xfb1e, 0x8bf9, 0x9bd8, 0xabbb, 0xbb9a,
0x4a75, 0x5a54, 0x6a37, 0x7a16, 0x0af1, 0x1ad0,
0x2ab3, 0x3a92, 0xfd2e, 0xed0f, 0xdd6c, 0xcd4d,
0xbdaa, 0xad8b, 0x9de8, 0x8dc9, 0x7c26, 0x6c07,
0x5c64, 0x4c45, 0x3ca2, 0x2c83, 0x1ce0, 0x0cc1,
0xef1f, 0xff3e, 0xcf5d, 0xdf7c, 0xaf9b, 0xbfba,
0x8fd9, 0x9ff8, 0x6e17, 0x7e36, 0x4e55, 0x5e74,
0x2e93, 0x3eb2, 0x0ed1, 0x1ef0];

func crccccc16(s: String) -> Int  {
    var crc = 0xffff
    var j = 0
    
    for i in s.utf8 {
        j = (Int(i)^(crc >> 8)) & 0xFF
        crc = crcTable[j] ^ (crc << 8)
    }
    
    return (crc ^ 0) & 0xffff
}

let merchantIdentifier = "000201010212293"
let merchantPresented =  "A000000677010111"
let customerPresented = "A000000677010114"

let BOT = 001
let BBL = 002 //Bangkok Bank Public Company Limited (BBL)
let Kbank = 004 //Kasikorn Bank Company Limited
let KTB = 006 //Krung Thai Bank Public Company Limited (KTB)
let TMB = 011 //TMB Bank Public Company Limited ( TMB)
let SCB = 014 //Siam Commercial Bank Public Company Limited (SCB)
let UOBT = 024 //United Overseas Bank (Thai) PCL (UOBT)
let BAY = 025 //Bank of Ayudhya Public Company Limited (BAY)
let GOV = 030 //Government Saving Bank (GOV)
let HSBC = 031 //Hong Kong & Shanghai Corporation Limited Hong Kong & Shanghai Corporation Limited (HSBC)
let DEUTSCHE = 032   //Deutsche Bank Aktiengesellschaft (DEUTSCHE)
let GHB = 033 //Government Housing Bank (GHB)
let BAAC = 034 //BANK FOR AGRICULTURE AND AGRICULTURAL COOPERATIVES
let MHCB = 039 //Mizuho Bank Bangkok Branch (MHCB)


//let cend = String(format:"%02X", crccccc16(s: withoutCrc16))
//let ewallet = String(format:"%02X", crccccc16(s: withoutCrc16Ewallet))

//
//00020101021229370016A000000677010111 01 13 0066943542367 5802TH 54 05 30000 5303764 6304 423C
//00020101021229390016A000000677010111 03 15 004999021296693 5802TH 53 03 7645404 1.00 6304

//00020101021229390016A0000006770101110 3150049990212966935802TH53 03 76454041.00 6304 118E
//00020101021229390016A0000006770101110 3150049990212966935802TH53 03 76454041.00 6304118E -> original
//00020101021229390016A0000006770101110 3150049990212966935802TH53 04 76454041.00 63047911

//new 10 bath
//00020101021229390016A0000006770101110 3150049990212966935802TH53 03 7645405 10.00 6304D780

// 1 bath
//00020101021229390016A0000006770101110 3150049990212966935802TH53 03 7645404 1.00 6304118E

//10 bath from output
//00020101021229390016A0000006770101110 3150049990212966935802TH53 03 7645404 10.00 6304B8C5

//00020101021229370016A000000677010111011300669435423675802TH5405 5303764 630410A8
//00020101021129370016A000000677010111011300660000000005802TH53037646304


//00020101021229370016A000000677010111      1-> เลขซ้ำ
//01 -> เบอโทร, 02-> บัตรประชาชน,
//13 -> ซ้ำ

//0066 -> ถ้าเป็นเบอโทร ต่อด้วยหมายเลขโทรศัพ เอา0ตัวหน้าออก
//เลขบัตรประชาชน 13 หลัก

// 5802TH -> ซ้ำ

// 54 -> สำหรับเลขมีจำนวนเงิน {
//  0+(จำนวนตำแหน่ง) เช่น 523.23 -> 06 , 523 -> 03
//  ตามด้วยจำนวนเงิน เช่น 500
//} else {
//  53
//}


// 5303764 -> ซ้ำ
// 6304 -> ซ้ำ

// เลข4ตัว -> crc16

//11300669435423675303764540520.005802TH63041179
//
//0002010102 11 30810016 A00000067701011201150107536000315080214KB0000016578500320KPS004KB00000165785031690016A00000067701011301030040214KB0000016578500420KPS004KB000001657850530376454041.005802TH6304A1CE
//
//0002010102 12 29390016 A00000067701011103150049990212966935802TH530376454041.006304118E
