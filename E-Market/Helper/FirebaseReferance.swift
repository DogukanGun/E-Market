//
//  FirebaseReferance.swift
//  E-Market
//
//  Created by Dogukan Ali Gundogan on 4.10.2021.
//

import Foundation


import Firebase
import FirebaseFirestore

enum FCollectionReference: String {
    case User
    case Category
    case Items
    case Basket
}

func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    
    return Firestore.firestore().collection(collectionReference.rawValue)
}

