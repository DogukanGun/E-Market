//
//  Array+Sort.swift
//  E-Market
//
//  Created by Dogukan Ali Gundogan on 23.10.2021.
//

import Foundation

func orderList(with order:Int, for items:inout [Item],default backupItems:[Item]){
    switch order {
    case 1:
        items.sort { item1, item2 in
            item1.price>item2.price
        }
    case 0:
        items.sort { item1, item2 in
            item2.price>item1.price
        }
    case 2:
        items=backupItems
    default:
        break
    }
}
