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
