//
//  CustomSegmentManager.swift
//  DrawingFor12-older
//
//  Created by dorothyLiu on 2021/4/16.
//

import Foundation
import UIKit

open class CustomSegmentManager : UIView {
    //Slider 滑動軌道（Track）的高
    @IBInspectable open var trackWidth:CGFloat = 2 {
        didSet {setNeedsDisplay()}
    }
    // Slider 圓形拖拉按鈕（Thumb）的大小
    @IBInspectable var thumbSize: CGFloat = 20
    @IBInspectable var allowCornerRadius : Bool = true
    
    // Slider 拖拉的Image，可能nil
    @IBInspectable var thumbImage: UIImage?
    
    
    // Slider 無圖片時的顏色
    @IBInspectable var thumbBgCol: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    private lazy var thumbView: UIImageView = {
        let thumb = UIImageView()
        
        //如果沒有客製化圖片 image的部分將以顏色代替
        if thumbImage == nil {
            thumb.backgroundColor = thumbBgCol
        }else {
            thumb.image = thumbImage
        }
        
        return thumb
    }()
    
    open override func awakeFromNib() {
           super.awakeFromNib()
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.size.height/2
          
       }
    
    
//    private func thumbImage(radius: CGFloat) -> UIImage {
//        thumbView.frame = CGRect(x: 0, y: radius / 2, width: radius, height: radius)
//
//        thumbView.layer.masksToBounds = allowCornerRadius
//        thumbView.layer.cornerRadius = radius / 2
//
//        let renderer = UIGraphicsImageRenderer(bounds: thumbView.bounds)
//
//        return renderer.image { rendererContext in
//            thumbView.layer.render(in: rendererContext.cgContext)
//        }
//    }
    

    
}
