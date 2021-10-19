//
//  Category.swift
//  E-Market
//
//  Created by Dogukan Ali Gundogan on 19.10.2021.
//

import Foundation
import UIKit
import Firebase


class Category {
    var id:String
    var name:String
    var image:UIImage?
    var imageName:String?
    
    init(_ name:String,_ imageName:String) {
        self.id=""
        self.name=name
        self.imageName=imageName
        self.image=UIImage(named: imageName)
    }
    
    init(dictionary:NSDictionary) {
        self.id=dictionary[kOBJECTID] as! String
        self.name=dictionary[kNAME] as! String
        self.image=UIImage(named: dictionary[kIMAGENAME] as! String)
    }
}



//MARK: Helpers

func categoryDictionaryFrom(_ category: Category) -> NSDictionary {
    
    return NSDictionary(objects: [category.id, category.name, category.imageName], forKeys: [kOBJECTID as NSCopying, kNAME as NSCopying, kIMAGENAME as NSCopying])
}
