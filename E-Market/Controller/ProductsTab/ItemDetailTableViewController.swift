//
//  ItemDetailTableViewController.swift
//  E-Market
//
//  Created by Dogukan Ali Gundogan on 19.10.2021.
//

import Foundation
import UIKit

struct ItemDetailTableViewControllerVariables {
    static let cellIdentifier="ItemDetailTableViewCell"
    static let nibName="ItemCell"
    
}
class ItemDetailTableViewController:UIViewController{
    
    @IBOutlet var tableView:UITableView!
    @IBOutlet var segmentedControl:UISegmentedControl!
    var category:Category!
    var items:[Item]=[]
    var backupItems:[Item]!
    
    
    @IBAction func segmentedControlItemSelected(_ sender:Any){
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            orderList(with:0, for:&items,default:backupItems)
        case 1:
            orderList(with:1, for:&items,default:backupItems)
        case 2:
            orderList(with:2, for:&items,default:backupItems)
        default:
            break
        }
        tableView.reloadData()
    }
     
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.delegate=self
        self.tableView.dataSource=self
        downloadItems(from: category.id) { itemsFromFirebase in
            self.items=itemsFromFirebase
            self.backupItems=itemsFromFirebase
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ItemDetailViewController"{
 
            if let index = tableView.indexPathForSelectedRow?.row{
                let item = items[index]
                let vc = segue.destination as! ItemDetailViewController

                 vc.item = item
                
             } 
            
        }
    }
}


extension ItemDetailTableViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: ItemDetailTableViewControllerVariables.cellIdentifier, for: indexPath) as! ItemCell
        let item = items[indexPath.row]
        cell.refresh(item: item)
        return cell
    }
    
}
