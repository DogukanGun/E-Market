//
//  ItemDetailViewController.swift
//  E-Market
//
//  Created by Dogukan Ali Gundogan on 22.10.2021.
//

import Foundation
import UIKit


struct ItemDetailViewControllerVariables {
    static let topInset = CGFloat(40)
    static let bottomInset = CGFloat(40)
    static let leftInset = CGFloat(0)
    static let rigthInset = CGFloat(0)
}

class ItemDetailViewController:UIViewController{
    
    @IBOutlet var scrollView:UIScrollView!
    
    @IBOutlet var image:UIImageView!
    @IBOutlet var decription:UILabel!
    @IBOutlet var price:UILabel!
    
    var item:Item?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshView()
//        scrollView.automaticallyAdjustsScrollIndicatorInsets = false
        self.scrollView.contentInset = UIEdgeInsets(top:ItemDetailViewControllerVariables.topInset ,
                                                    left: ItemDetailViewControllerVariables.leftInset,
                                                    bottom: ItemDetailViewControllerVariables.bottomInset,
                                                    right: ItemDetailViewControllerVariables.rigthInset);
     }
    private func refreshView(){
        getImage()
        self.decription.text = item!.description
        
//        self.decription.text =
//            """
//                        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus sagittis volutpat augue sit amet porta. Nulla molestie, diam eu interdum convallis, dolor lectus scelerisque turpis, sit amet porttitor odio ipsum et nibh. Curabitur massa orci, gravida nec sagittis eget, sollicitudin eu tellus. Praesent molestie enim in volutpat accumsan. Interdum et malesuada fames ac ante ipsum primis in faucibus. Morbi sit amet erat quis nulla tempor cursus. Nulla et lacus eros. Sed nec tempor turpis. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Fusce tincidunt, velit quis dapibus feugiat, lacus turpis volutpat nunc, vitae mollis ipsum odio sit amet orci. Nullam a magna elit.
//
//                        In accumsan ut nulla in ullamcorper. Nam arcu est, efficitur at volutpat vitae, gravida et tortor. Vestibulum mi nunc, sagittis vitae tempor sit amet, viverra id augue. Curabitur id enim finibus mauris laoreet dictum. Suspendisse interdum lacus id dolor faucibus molestie. Aenean quis accumsan sem. Fusce quis felis dapibus, vehicula ante in, maximus neque. Donec diam massa, lobortis sit amet iaculis at, elementum eu purus. Vivamus egestas lacus dui. Aliquam dapibus ligula nulla, at aliquet turpis pellentesque id. Vestibulum metus eros, dapibus a nisi ultricies, aliquet finibus est. Pellentesque scelerisque augue sed iaculis interdum. Donec consequat auctor aliquam.
//            """
        self.price.text = "Price : \(String(item!.price))"
    }
    
    private func getImage(){
        var image = UIImage(systemName: "star")
        if   let url = URL(string: item!.imageLink){
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard let data = data else {
                    return
                }
                DispatchQueue.main.async {
                    self.image.image = UIImage(data: data)
                }
            }
            task.resume()
        }
    }
}
