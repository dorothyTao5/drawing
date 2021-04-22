//
//  CustomSliderModule.swift
//  Qpesums
//
//  Created by dorothyLiu on 2021/4/7.
//  Copyright © 2021 IISI. All rights reserved.
//

import Foundation
import UIKit

open class CustomSliderManager : UISlider {
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
    
    //*** 最下方 注： 1
    open lazy var thumbView: UIImageView = {
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
        
            let thumb = thumbImage(radius: thumbSize)
            setThumbImage(thumb, for: .normal)
        
       }
    
    //*** 最下方 注： 1
    open func thumbImage(radius: CGFloat) -> UIImage {
        
        thumbView.frame = CGRect(x: 0, y: radius / 2, width: radius, height: radius)
        
        thumbView.layer.masksToBounds = allowCornerRadius
        thumbView.layer.cornerRadius = radius / 2
        
        let renderer = UIGraphicsImageRenderer(bounds: thumbView.bounds)
        
        return renderer.image { rendererContext in
            thumbView.layer.render(in: rendererContext.cgContext)
            
        }
    }
    
    override open func trackRect(forBounds bounds: CGRect) -> CGRect {
        let defaultBounds = super.trackRect(forBounds: bounds)
        return CGRect(
            x: defaultBounds.origin.x,
            y: defaultBounds.origin.y,
            width: defaultBounds.size.width,
            height: trackWidth
        )
    }
    
}


/// - tag: 注: 1
/*
 通常應該設為private； 在特殊情況下 比如 設定風格 的時候
 需要修改這裡達到即時更新圖片
 範例程式：
 ThemeManager.MyVc?.mySlider.thumbView.image = Theme.current.imgArrow
 let thumb = ThemeManager.MyVc?.mySlider.thumbImage(radius: CGFloat(25))
 ThemeManager.MyVc?.mySlider.setThumbImage(thumb, for: .normal)
 
 */
