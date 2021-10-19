//
//  FirebaseStorage.swift
//  E-Market
//
//  Created by Dogukan Ali Gundogan on 19.10.2021.
//

import Foundation
import FirebaseStorage

let storage = Storage.storage()



func uploadImages(image: UIImage?, itemId: String, completion: @escaping (_ imageLinks: String) -> Void) {
     
        
            var imageLink: String = ""
             
                
            let fileName = "ItemImages/" + itemId + "/" + ".jpg"
            let imageData = image!.jpegData(compressionQuality: 0.5)
                
            saveImageInFirebase(imageData: imageData!, fileName: fileName) { (imageLink) in
                    
                if imageLink != nil {
                    completion(imageLink!)
                }
            }
                
            
            

    
}


func saveImageInFirebase(imageData: Data, fileName: String, completion: @escaping (_ imageLink: String?) -> Void) {
    
    var task: StorageUploadTask!
    
    let storageRef = storage.reference(forURL: kFILEREFERENCE).child(fileName)
    
    task = storageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
        
        task.removeAllObservers()
        
        if error != nil {
            print("Error uploading image", error!.localizedDescription)
            completion(nil)
            return
        }
        
        storageRef.downloadURL { (url, error) in
            
            guard let downloadUrl = url else {
                completion(nil)
                return
            }
            
            completion(downloadUrl.absoluteString)
        }
    })
}



