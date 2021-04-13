//
//  UIImageExtension.swift
//  DrawingFor12-older
//
//  Created by dorothyLiu on 2021/4/10.
//

import Foundation
import UIKit

//MARK:- extension UIImage
extension UIImage {
  func mergeWith(_ topImage: UIImage) -> UIImage {
    let bottomImage = self

    UIGraphicsBeginImageContext(size)

    let areaSize = CGRect(x: 0, y: 0, width: bottomImage.size.width, height: bottomImage.size.height)
    bottomImage.draw(in: areaSize)

    topImage.draw(in: areaSize, blendMode: .normal, alpha: 1.0)

    let mergedImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return mergedImage
  }
    
    
  
}
