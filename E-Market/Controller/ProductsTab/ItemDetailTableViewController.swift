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
    
    private func downloadData(){
        downloadItems(from: category.id) { itemsFromFirebase in
            self.items=itemsFromFirebase
            self.backupItems=itemsFromFirebase
            self.tableView.reloadData()
        }
    }
     
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.delegate=self
        self.tableView.dataSource=self
        downloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ItemDetailViewController"{
 
            if let index = tableView.indexPathForSelectedRow?.row{
                let item = items[index]
                let vc = segue.destination as! ItemDetailViewController

                 vc.item = item
                
             } 
            
        }else if segue.identifier == "EditItemViewController"{
                 let item = sender as! Item
                let vc = segue.destination as! EditItemViewController

                vc.item = item
                 
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
     
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete=UIContextualAction(style: .destructive, title: "Delete") { action, view, bool in
                self.items.remove(at: indexPath.row)
                self.backupItems.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                deleteFromFirebase(item:self.items[indexPath.row])
            
        }
        let update=UIContextualAction(style: .normal, title: "Update") { action, view, bool in
         
            self.performSegue(withIdentifier: "EditItemViewController", sender: self.items[indexPath.row])
                self.downloadData()
            
        }
        update.backgroundColor = UIColor.blue
        let swipeActions = UISwipeActionsConfiguration(actions: [delete,update])
        return swipeActions
    }
}
