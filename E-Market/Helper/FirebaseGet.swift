//
//  FirebaseGet.swift
//  E-Market
//
//  Created by Dogukan Ali Gundogan on 19.10.2021.
//

import Foundation

//MARK: Download categories

func downloadCategories(completion: @escaping (_ categoryArray:[Category])->Void) {
    var categoryArray:[Category]=[]
    
    FirebaseReference(.Category).getDocuments(completion: {
        (snapshot,error) in
        
        guard let snapshot = snapshot else{
            completion(categoryArray)
            return
        }
        if !snapshot.isEmpty{
            for categoryDict in snapshot.documents{
                categoryArray.append(Category(dictionary: categoryDict.data() as NSDictionary))
            }
        }
        
        completion(categoryArray)
        
    })
}
func downloadItems(from categoryId:String, completion: @escaping (_ categoryArray:[Item])->Void) {
    var itemArray:[Item]=[]
    
    FirebaseReference(.Items).getDocuments(completion: {
        (snapshot,error) in
        
        guard let snapshot = snapshot else{
            completion(itemArray)
            return
        }
        if !snapshot.isEmpty{
            for itemDict in snapshot.documents{
                let item = Item(dictionary: itemDict.data() as NSDictionary)
                if item.categoryId == categoryId {
                    itemArray.append(item)
                }
            }
        }
        
        completion(itemArray)
        
    })
}
