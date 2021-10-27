//
//  EditItemViewController.swift
//  E-Market
//
//  Created by Dogukan Ali Gundogan on 27.10.2021.
//

import Foundation
import UIKit


class EditItemViewController: UIViewController {
    var item:Item!
    var newItem=Item()
    @IBOutlet var nameOfItem:UITextField!
    @IBOutlet var priceOfItem:UITextField!
    @IBOutlet var descriptionOfItem:UITextField!
    
    @IBAction func saveItem(){
        if let text = nameOfItem.text, !text.isEmpty{
            newItem.name = text
        }
        if let text = priceOfItem.text, !text.isEmpty{
            setPrice(text: text)
        }
        if let text = descriptionOfItem.text, !text.isEmpty{
            newItem.description = text
        }
        createNewItem()
    }
    
    func createNewItem(){
        newItem.categoryId=item.categoryId
        newItem.imageLink=item.imageLink
        newItem.id=item.id
        newItem.isDeleted=item.isDeleted
        saveItemToFirebase(newItem)
    }
    private func setPrice(text:String){
        let decimalCharacters = CharacterSet.decimalDigits

        let decimalRange = text.rangeOfCharacter(from: decimalCharacters)

        if decimalRange != nil {
            newItem.price = Double(text)
        }else{
            print("Numbers found")
        }
        navigationController?.popViewController(animated: true)
    }
}
