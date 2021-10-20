//
//  UIImage+Resize.swift
//  E-Market
//
//  Created by Dogukan Ali Gundogan on 19.10.2021.
//

import UIKit

extension UIImage {
    func resize(with bounds:CGSize)->UIImage{
        let horizontalRatio = bounds.width / size.width
        let verticalRatio = bounds.height / size.height
        
        let ratio = min(horizontalRatio, verticalRatio)
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
        draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    
    }
}
