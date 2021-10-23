//
//  AddItemViewController.swift
//  E-Market
//
//  Created by Dogukan Ali Gundogan on 19.10.2021.
//

import Foundation
import UIKit


struct AddItemViewControllerCategoryVariables{
    var categories:[Category]=[]
    var selectedCategoryIndex=0
    
    var selectedCategoryItem:Category{
        return categories[selectedCategoryIndex]
    }
}
struct AddItemViewControllerVariables {
    static let topInset = CGFloat(40)
    static let bottomInset = CGFloat(40)
    static let leftInset = CGFloat(0)
    static let rigthInset = CGFloat(0)
}
class AddItemViewController:UIViewController{
    @IBOutlet var itemName:UITextField!
    @IBOutlet var itemPrice:UITextField!
    @IBOutlet var itemDescription:UITextField!
    @IBOutlet var takePhotoButton:UIButton!
    @IBOutlet weak var pickerViewButton: UIButton!
    @IBOutlet var datePicker:UIDatePicker!
    @IBOutlet var scrollView:UIScrollView!
    let screenWidth = UIScreen.main.bounds.width - 10
    let screenHeight = UIScreen.main.bounds.height / 2
    var pickerView:UIPickerView!
    var image:UIImage!
    
    
 
    var categoryVariables = AddItemViewControllerCategoryVariables()
    
    override func viewDidLoad() {
        self.pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width:self.screenWidth, height:self.screenHeight))
        downloadCategories { category in
            self.categoryVariables.categories=category
            self.pickerView.reloadAllComponents()
         }
        self.scrollView.contentInset = UIEdgeInsets(top:AddItemViewControllerVariables.topInset ,
                                                    left: AddItemViewControllerVariables.leftInset,
                                                    bottom: AddItemViewControllerVariables.bottomInset,
                                                    right: AddItemViewControllerVariables.rigthInset);
         
        
    }
    
    @IBAction func popUpPicker(_ sender: Any)
        {
            let vc = UIViewController()
            vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
            pickerView.dataSource = self
            pickerView.delegate = self
            
            pickerView.selectRow(categoryVariables.selectedCategoryIndex, inComponent: 0, animated: false)
 
            vc.view.addSubview(pickerView)
            pickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
            pickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
            
            let alert = UIAlertController(title: "Select Category", message: "", preferredStyle: .actionSheet)
            
            alert.popoverPresentationController?.sourceView = pickerViewButton
            alert.popoverPresentationController?.sourceRect = pickerViewButton.bounds
            
            alert.setValue(vc, forKey: "contentViewController")
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
            }))
            
            alert.addAction(UIAlertAction(title: "Select", style: .default, handler: { (UIAlertAction) in
                self.categoryVariables.selectedCategoryIndex = self.pickerView.selectedRow(inComponent: 0)
                 self.pickerViewButton.setTitle(self.categoryVariables.selectedCategoryItem.name, for: .normal)
             }))
            
            self.present(alert, animated: true, completion: nil)
        }
     
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
        item.categoryId = categoryVariables.selectedCategoryItem.id
        item.description = itemDescription.text
        item.price = Double(itemPrice.text!)!
        setItemLink(to: item)
        guard let mainView = navigationController?.parent?.view else{
            return
        }
        let hudView = HudView.hudView(inView: mainView, animated: true)
        showHideView(hudView: hudView)
         
     }
    private func showHideView(hudView:HudView){
        let delayInSecond = 1.5
        do{
            afterDelay(delayInSecond) {
                hudView.hide()
                self.navigationController?.popViewController(animated: true)
            }
        }catch{
        }
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

 

extension AddItemViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryVariables.categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryVariables.categories[row].name
    }
    
     
}
