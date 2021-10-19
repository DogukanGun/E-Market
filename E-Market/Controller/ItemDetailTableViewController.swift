//
//  ItemDetailTableViewController.swift
//  E-Market
//
//  Created by Dogukan Ali Gundogan on 19.10.2021.
//

import Foundation
import UIKit

class ItemDetailTableViewController:UITableViewController{
    
    var category:Category!
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemViewController"{
            let vc = segue.destination as! AddItemViewController
            vc.category=category
        }
    }
}
