//
//  Item.swift
//  E-Market
//
//  Created by Dogukan Ali Gundogan on 7.10.2021.
//

import Foundation

class Item {
    var id:Int!
    var categoryId:String!
    var name:String!
    var description:String!
    var price:String!
    var imageLink:[String]!
    
    init(dictionary:NSDictionary) {
        self.id=dictionary[kOBJECTID] as! Int
        self.categoryId=dictionary[kCATEGORYID] as! String
        self.name=dictionary[kNAME] as! String
        self.description=dictionary[kDESCRIPTION] as! String
        self.price=dictionary[kPRICE] as! String
        self.imageLink=dictionary[kIMAGELINKS] as! [String]
    }
    
    
}
