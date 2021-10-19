//
//  CategoryCell.swift
//  E-Market
//
//  Created by Dogukan Ali Gundogan on 4.10.2021.
//

import Foundation
import UIKit

class CategoryCell:UICollectionViewCell{
    
    @IBOutlet var image:UIImageView!
    
    @IBOutlet var text:UILabel!
    
    func refresh(category:Category){
        self.image.image=category.image
        self.text.text=category.name
    }
    
}
