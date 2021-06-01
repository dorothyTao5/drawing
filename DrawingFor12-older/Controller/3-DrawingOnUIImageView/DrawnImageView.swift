//
//  DrawnImageView.swift
//  DrawingFor12-older
//
//  Created by dorothyLiu on 2021/4/19.
//

import Foundation
import UIKit

struct DrawnPointsAndColor {
    var color: UIColor?
    var width: CGFloat?
    var opacity: CGFloat?
    var paths: [CGPath]?
 
    init(color: UIColor, paths: [CGPath]?) {
        self.color = color
        self.paths = paths
    }
}

class DrawnImageView: UIImageView {
    var lines = [DrawnPointsAndColor]()
    var strokeWidth: CGFloat = 1.0
    var strokeColor: UIColor = .black
    var strokeOpacity: CGFloat = 1.0
    
    private lazy var path = UIBezierPath()
    private lazy var previousTouchPoint = CGPoint.zero
    lazy var shapeLayer = CAShapeLayer()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupView(){
        layer.addSublayer(shapeLayer)
        shapeLayer.lineWidth = 4
        shapeLayer.strokeColor = UIColor.white.cgColor
        isUserInteractionEnabled = true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let location = touches.first?.location(in: self) { previousTouchPoint = location }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if let location = touches.first?.location(in: self) {
            path.move(to: location)
            path.addLine(to: previousTouchPoint)
            previousTouchPoint = location
            shapeLayer.path = path.cgPath
        }
    }
}

// https://stackoverflow.com/a/40953026/4488252
extension UIView {
    var screenShot: UIImage?  {
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale)
        if let context = UIGraphicsGetCurrentContext() {
            layer.render(in: context)
            let screenshot = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return screenshot
        }
        return nil
    }
}
