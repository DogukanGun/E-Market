//
//  AddItemViewController.swift
//  E-Market
//
//  Created by Dogukan Ali Gundogan on 19.10.2021.
//

import Foundation
import UIKit

class AddItemViewController:UIViewController{
    @IBOutlet var itemName:UITextField!
    @IBOutlet var itemPrice:UITextField!
    @IBOutlet var itemDescription:UITextView!
    @IBOutlet var takePhotoButton:UIButton!
    
    
    var image:UIImage!
    var category:Category!
    
    //MARK: IBActions
    
    @IBAction func doneBarButtonItemPressed(_ sender: Any) {
        
 
        if fieldsAreCompleted() {
            print("we have values")
            saveToFirebase()
        } else {
            print("Error all fields are required")
            //TODO: SHow error to the user

        }
    }
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        pickPhoto()
        
    }
    
    //MARK: Helper functions
    
    private func fieldsAreCompleted() -> Bool {
        
        return (itemName.text != "" && itemPrice.text != "" && itemDescription.text != "")
    }
    
    private func popTheView() {
         self.navigationController?.popViewController(animated: true)
     }

     
     //MARK: Save Item
     private func saveToFirebase() {
         
        let item = Item()
        item.id = UUID().uuidString
        item.name = itemName.text!
        item.categoryId = category.id
        item.description = itemDescription.text
        item.price = Double(itemPrice.text!)!
        setItemLink(to: item)
        popTheView()
          
         
     }
    private func setItemLink(to item:Item){
        uploadImages(image: image, itemId: item.id) { imageLink in
            item.imageLink=imageLink
            saveItemToFirebase(item)
        }
    }
    private func pickPhoto(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            showPhotoMenu()
        }else{
            choosePhotoFromLibrary()
        }
    }
    private func showPhotoMenu(){
        let alert = UIAlertController(title:nil, message: nil, preferredStyle: .actionSheet)
        let alertCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(alertCancel)
        let actionCamera = UIAlertAction(title: "Take Photo", style: .default, handler: {
            _ in
            self.takePhotoWithCamera()
        })
        alert.addAction(actionCamera)
        let actionLibrary = UIAlertAction(title: "Choose From Library", style: .default, handler: {_ in
            self.choosePhotoFromLibrary()
        })
        alert.addAction(actionLibrary)
        present(alert, animated: true, completion: nil)
    }

    
}
extension AddItemViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func takePhotoWithCamera(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    func choosePhotoFromLibrary(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.editedImage] as! UIImage?
        if let image = image {
            self.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
