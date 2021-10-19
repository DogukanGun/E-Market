//
//  SearchCollectionViewController.swift
//  E-Market
//
//  Created by Dogukan Ali Gundogan on 3.10.2021.
//

import UIKit

private let reuseIdentifier = "CategoryCell"

class SearchCollectionViewController: UICollectionViewController {

    var categories:[Category]=[]
    private var selectedCategory:Category?
    var isDownloaded=false
    private let itemsPerRow:CGFloat=3
    private let sectionInsets = UIEdgeInsets(top: 20.0, left: 10.0, bottom: 20.0, right: 10.0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register cell classes
        if !isDownloaded {
            downloadCategories()
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return categories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategory=categories[indexPath.row]
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ItemDetailTableViewController" {
            let vc = segue.destination as? ItemDetailTableViewController
            if let vc = vc{
                vc.category=selectedCategory
            }else{
                // TODO: create error message model
                NSLog("%s", "Empty Controller")
            }
        }
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CategoryCell else {
            return UICollectionViewCell()
        }
        cell.refresh(category: categories[indexPath.row])
     
        return cell
    }

    
    // MARK: Download Categories
    
    private func downloadCategories(){
        E_Market.downloadCategories(completion: {
            categories in
            
            if !categories.isEmpty{
                self.categories=categories
                self.isDownloaded=true
                self.collectionView.reloadData()
            }
        })
    }
    

}


extension SearchCollectionViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow+1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
