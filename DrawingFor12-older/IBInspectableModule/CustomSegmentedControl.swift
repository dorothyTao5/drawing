//
//  CustomSegmentedControl.swift
//  Qpesums
//
//  Created by dorothyLiu on 2021/4/15.
//  Copyright © 2021 IISI. All rights reserved.
//

import Foundation
import UIKit

class CustomSegmentedControl: UISegmentedControl{
    private let segmentInset: CGFloat = 5       //your inset amount
    private var segmentImage: UIImage? = UIImage(color: UIColor.red)    //your color

    override func layoutSubviews(){
        super.layoutSubviews()

        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        layer.backgroundColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
        //background
        layer.cornerRadius = bounds.height/2
        
        //foreground
        let foregroundIndex = numberOfSegments
        if subviews.indices.contains(foregroundIndex), let foregroundImageView = subviews[foregroundIndex] as? UIImageView
        {
            foregroundImageView.bounds = foregroundImageView.bounds.insetBy(dx: segmentInset, dy: segmentInset)
            foregroundImageView.image = segmentImage    //substitute with our own colored image
            foregroundImageView.layer.removeAnimation(forKey: "SelectionBounds")    //this removes the weird scaling animation!
            foregroundImageView.layer.masksToBounds = true
            foregroundImageView.layer.cornerRadius = foregroundImageView.bounds.height/2
        }
        
        if self.selectedSegmentIndex == 0 {
            segmentImage = UIImage(color: #colorLiteral(red: 0, green: 0.631372549, blue: 0.7098039216, alpha: 1) )
        }else {
            segmentImage = UIImage(color: #colorLiteral(red: 0.8980392157, green: 0.2823529412, blue: 0.4509803922, alpha: 1) )
        }
    }

    
}

extension UIImage{
    
    //creates a UIImage given a UIColor
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}



/*
 use：
 
 @IBOutlet weak var sgc: UISegmentedControl!
 
 
 @IBAction func sgcPressed(_ sender: Any) {
 //https://stackoverflow.com/questions/24666515/how-do-i-make-an-attributed-string-using-swift
     if sgc.selectedSegmentIndex == 0 {
         let normal : [NSAttributedString.Key : Any] = [
             .foregroundColor : UIColor.blue
         ]
         
         let selected : [NSAttributedString.Key : Any] = [
             .foregroundColor : UIColor.black
             
         ]
         sgc.setTitleTextAttributes(normal, for: .normal)
         sgc.setTitleTextAttributes(selected, for: .selected)
        
     }else {
         
         let normal : [NSAttributedString.Key : Any] = [
             .foregroundColor : UIColor.gray
             
         ]
         let selected : [NSAttributedString.Key : Any] = [
             .foregroundColor : UIColor.purple
             
         ]
         sgc.setTitleTextAttributes(normal, for: .normal)
         sgc.setTitleTextAttributes(selected, for: .selected)
         sgc.tintColorDidChange()
     }
 }
 */
