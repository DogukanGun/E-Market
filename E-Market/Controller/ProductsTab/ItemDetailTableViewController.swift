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
    var category:Category!
    var items:[Item]=[]
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.delegate=self
        self.tableView.dataSource=self
        downloadItems(from: category.id) { itemsFromFirebase in
            self.items=itemsFromFirebase
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemViewController"{
            let vc = segue.destination as! AddItemViewController
            vc.category=category
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
