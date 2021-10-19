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
    @IBOutlet var descriptionOfItem: UILabel!
    @IBOutlet var amount:UILabel!
    
    
    func refresh(imageOfItem:UIImage,name:String,descriptionOfItem:String,amount:String) {
        self.name.text=name
        self.amount.text=amount
        self.descriptionOfItem.text=description
        self.imageOfItem.image=imageOfItem
    }
}
