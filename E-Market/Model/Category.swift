//
//  Category.swift
//  E-Market
//
//  Created by Dogukan Ali Gundogan on 3.10.2021.
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
//MARK: Save category function

func saveCategoryToFirebase(_ category: Category) {
    
    let id = UUID().uuidString
    category.id = id
    FirebaseReference(.Category).document(id).setData(categoryDictionaryFrom(category) as! [String : Any])
}
//MARK: Save item function

func saveItemToFirebase(_ item: Item) {
    
    let id = UUID().uuidString
    item.categoryId = id
    FirebaseReference(.Items).document(id).setData(itemDictionaryFrom(item) as! [String : Any])
}


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

//MARK: Helpers

func categoryDictionaryFrom(_ category: Category) -> NSDictionary {
    
    return NSDictionary(objects: [category.id, category.name, category.imageName], forKeys: [kOBJECTID as NSCopying, kNAME as NSCopying, kIMAGENAME as NSCopying])
}

func itemDictionaryFrom(_ item: Item) -> NSDictionary {
    
    return NSDictionary(objects: [item.id,item.categoryId, item.name, item.description,item.price,item.imageLink], forKeys: [kOBJECTID as NSCopying, kCATEGORYID as NSCopying, kNAME as NSCopying, kDESCRIPTION as NSCopying, kPRICE as NSCopying, kIMAGELINKS as NSCopying])
}
//use only one time
func createCategorySet() {

    let womenClothing = Category("Women's Clothing & Accessories", "womenCloth")
    let footWaer = Category("Footwaer", "footWaer")
    let electronics = Category("Electronics", "electronics")
    let menClothing = Category("Men's Clothing & Accessories" , "menCloth")
    let health = Category("Health & Beauty", "health")
    let baby = Category("Baby Stuff", "baby")
    let home = Category("Home & Kitchen", "home")
    let car = Category("Automobiles & Motorcyles", "car")
    let luggage = Category("Luggage & bags", "luggage")
    let jewelery = Category("Jewelery", "jewelery")
    let hobby =  Category("Hobby, Sport, Traveling", "hobby")
    let pet = Category("Pet products", "pet")
    let industry = Category("Industry & Business", "industry")
    let garden = Category("Garden supplies", "garden")
    let camera = Category("Cameras & Optics", "camera")

    let arrayOfCategories = [womenClothing, footWaer, electronics, menClothing, health, baby, home, car, luggage, jewelery, hobby, pet, industry, garden, camera]

    for category in arrayOfCategories {
        saveCategoryToFirebase(category)
    }

}





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
public let kIMAGELINKS = "imageLinks"

