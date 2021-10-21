//
//  SearchItemViewController.swift
//  E-Market
//
//  Created by Dogukan Ali Gundogan on 21.10.2021.
//

import Foundation

import UIKit


struct SearchItemViewControllerVariables {
    static let cellIdentifier="ItemTableViewCell"

}
class SearchItemViewController: UIViewController,UISearchResultsUpdating, UISearchBarDelegate {

    @IBOutlet weak var tableView:UITableView!

let searchController = UISearchController()
var items:[Item]=[]
var timer:Timer?
var searchItem:String?
override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UINib.init(nibName: SearchItemViewControllerVariables.cellIdentifier, bundle: nil), forCellReuseIdentifier:SearchItemViewControllerVariables.cellIdentifier )
    initSearchButton()
    tableView.delegate = self
    tableView.dataSource = self
    searchController.searchBar.delegate=self
    
    // Do any additional setup after loading the view.
}
func initSearchButton(){
    searchController.searchBar.enablesReturnKeyAutomatically=true
    searchController.obscuresBackgroundDuringPresentation=false
    searchController.searchBar.returnKeyType=UIReturnKeyType.done
    searchController.searchResultsUpdater=self
    searchController.searchBar.delegate=self
    definesPresentationContext=true
     navigationItem.searchController=searchController
}
func search(string text:String){
       
    downloadItemsFromSearchController(text) { itemsFromFirebase in
        self.items = itemsFromFirebase
        self.tableView.reloadData()
    }
    
}
func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    guard let text=searchController.searchBar.text else {
        return
    }
    if text != ""{
        self.search(string: text)
    }

}
func updateSearchResults(for searchController: UISearchController) {
    guard let text=searchController.searchBar.text else {
        return
    }
    if text != ""{
        if let _ = timer {
            timer?.invalidate()
            timer=nil
        }
        self.searchItem=text
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(fire), userInfo: nil, repeats: false)
    }else{
        timer?.invalidate()
        items.removeAll()
        tableView.reloadData()
    }
}
    
    

@objc func fire()
{
    print("Patladi")
    guard let searchItem = self.searchItem else {
        return
    }
    search(string:searchItem.lowercased())
    
}

}

extension SearchItemViewController:UITableViewDelegate,UITableViewDataSource{
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if(searchController.isActive){
        return items.count
    }else{
        return 0
    }
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let tableViewCell=tableView.dequeueReusableCell(withIdentifier: SearchItemViewControllerVariables.cellIdentifier, for: indexPath) as? ItemTableViewCell else {
            return UITableViewCell()
        }
        let currentItem = self.items[indexPath.row]
        tableViewCell.refresh(item: currentItem)
        return tableViewCell

    
}
func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if items.count==0 {
        return nil
    }else{
        return "Items"
    }
         
    
}
func numberOfSections(in tableView: UITableView) -> Int {
    return 1
}


}

extension SearchItemViewController{
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    if segue.identifier=="MovieDetailbySearch"{
//        let vc=segue.destination as! MovieDetailViewController
//        guard let cell = sender as? MovieTableViewCell else {
//            return
//        }
//        guard let index = tableView.indexPath(for: cell) else {
//            return
//        }
//        vc.movie=movies[index.row]
//    }
}
}

