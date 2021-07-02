//
//  File.swift
//  DrawingFor12-older
//
//  Created by dorothy on 2021/6/10.
//

import Foundation
import UIKit

struct ColorModel {
    let arrColors: [UIColor] = [#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
    var currentColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    mutating func setUpInitColor(color: UIColor,firstSlider:UISlider,secondSlider:UISlider,canvasView:CanvasView) {
        currentColor = color
        firstSlider.tintColor = currentColor
        secondSlider.tintColor = currentColor.withAlphaComponent(CGFloat( secondSlider.value))
        canvasView.strokeColor = currentColor
    }
    
    
}


struct HexModel{
    var hexViewUp: CGPoint! = CGPoint(x: 228.0 ,y: 616.5 )
    var hexViewDown: CGPoint!  = CGPoint(x: 228.0 ,y: 700.5 )
    var trayOriginalCenter: CGPoint! = CGPoint(x: 228.0 ,y: 616.5 )
    var movedPosition :CGPoint!
    
    
}
