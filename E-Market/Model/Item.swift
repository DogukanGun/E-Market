//
//  Item.swift
//  E-Market
//
//  Created by Dogukan Ali Gundogan on 19.10.2021.
//

import Foundation

class Item {
    var id:String!
    var categoryId:String!
    var name:String!
    var description:String!
    var price:Double!
    var imageLink:String!
    var isDeleted:Bool!
    var createdDate:String!
    
    init(dictionary:NSDictionary) {
        self.id=dictionary[kOBJECTID] as! String
        self.categoryId=dictionary[kCATEGORYID] as! String
        self.name=dictionary[kNAME] as! String
        self.description=dictionary[kDESCRIPTION] as! String
        self.price=dictionary[kPRICE] as! Double
        self.imageLink=dictionary[kIMAGELINK] as! String
        self.isDeleted=dictionary[kISDELETED] as! Bool
        self.createdDate=dictionary[kCREATEDDATE] as! String
    }
    init() {
        
    }
    
    
}



func itemDictionaryFrom(_ item: Item) -> NSDictionary {
    
    return NSDictionary(objects: [item.id,item.categoryId, item.name, item.description,item.price,item.imageLink,item.isDeleted,item.createdDate], forKeys: [kOBJECTID as NSCopying, kCATEGORYID as NSCopying, kNAME as NSCopying, kDESCRIPTION as NSCopying, kPRICE as NSCopying, kIMAGELINK as NSCopying,kISDELETED as NSCopying,kCREATEDDATE as NSCopying])
}

