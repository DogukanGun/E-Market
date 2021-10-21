//
//  ItemTableViewCell.swift
//  E-Market
//
//  Created by Dogukan Ali Gundogan on 21.10.2021.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var priceOfItem: UILabel!
    @IBOutlet weak var nameOfItem: UILabel!
    @IBOutlet weak var imageOfItem: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func refresh(item:Item) {
        self.nameOfItem.text=item.name
        self.priceOfItem.text=String(item.price)
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
