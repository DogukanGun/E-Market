//
//  Constant.swift
//  E-Market
//
//  Created by Dogukan Ali Gundogan on 19.10.2021.
//

import Foundation




//Path referance

public let kFILEREFERENCE="gs://category-6d2da.appspot.com"


//Firebase Headers
public let kUSER_PATH = "User"
public let kCATEGORY_PATH = "Category"
public let kITEMS_PATH = "Items"
public let kBASKET_PATH = "Basket"



//Category
public let kNAME = "name"
public let kIMAGENAME = "imageName"
public let kOBJECTID = "objectId"

//Item
public let kCATEGORYID = "categoryId"
public let kDESCRIPTION = "description"
public let kPRICE = "price"
public let kIMAGELINK = "imageLink"
public let kISDELETED = "isDeleted"
public let kCREATEDDATE = "createdDate"

func afterDelay(_ seconds:Double, run:@escaping () -> Void){
    DispatchQueue.main.asyncAfter(deadline: .now()+seconds) {
        run()
    }
}

var categories:[Category]!
    

