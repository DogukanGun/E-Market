//
//  FirebaseDelete.swift
//  E-Market
//
//  Created by Dogukan Ali Gundogan on 27.10.2021.
//

import Foundation



func deleteFromFirebase(item:Item){
    item.isDeleted=true
    saveItemToFirebase(item)
    
}
