//
//  ItemCell.swift
//  E-Market
//
//  Created by Dogukan Ali Gundogan on 19.10.2021.
//

import Foundation
import UIKit

class ItemCell: UITableViewCell {
    
    
    @IBOutlet var imageOfItem: UIImageView!
    @IBOutlet var name:UILabel!
//    @IBOutlet var descriptionOfItem: UILabel!
    @IBOutlet var amount:UILabel!
    
    
    func refresh(item:Item) {
        self.name.text=item.name
        self.amount.text=String(item.price)
//        self.descriptionOfItem.text=description
        getImage(imageLink: item.imageLink)
    }
    
    private func getImage(imageLink:String){
        let queue = DispatchQueue(label: "imageDownloadQueue")
        queue.async {
            
            var image = UIImage(systemName: "star")
            if   let url = URL(string: imageLink){
                let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                    guard let data = data else {
                        return
                    }
                    DispatchQueue.main.async {
                        self.imageOfItem.image = UIImage(data: data)
                    }
                }
                task.resume()
            }
        }
        
    }
}
