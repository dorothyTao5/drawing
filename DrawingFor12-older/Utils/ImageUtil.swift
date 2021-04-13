//
//  ImageUtil.swift
//  DrawingFor12-older
//
//  Created by dorothyLiu on 2021/4/10.
//

import Foundation
import UIKit

class ImageUtil {
    
   static func mergeTwoImg(targetView: UIView, imgButtom: UIImageView) -> UIImage{
//    使用方式：
//    let screenShotImg = targetView.takeScreenshot()
    
        UIGraphicsBeginImageContextWithOptions(targetView.bounds.size, false, UIScreen.main.scale)
        targetView.drawHierarchy(in: targetView.bounds, afterScreenUpdates: true)
        
        let imgTop = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIGraphicsBeginImageContextWithOptions(imgButtom.bounds.size, false, UIScreen.main.scale)
        imgButtom.drawHierarchy(in: imgButtom.bounds, afterScreenUpdates: true)
        let imgButtom = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let imgButtom = imgButtom, let imgTop = imgTop {
            let fionalImg = imgButtom.mergeWith(imgTop)
            return fionalImg
        }
        return UIImage()
    }
    
    
}
