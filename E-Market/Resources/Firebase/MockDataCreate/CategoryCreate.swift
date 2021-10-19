//
//  CategoryCreate.swift
//  E-Market
//
//  Created by Dogukan Ali Gundogan on 19.10.2021.
//

import Foundation
import UIKit


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

