//
//  Extension.swift
//  DrawingFor12-older
//
//  Created by dorothyLiu on 2021/1/21.
//

import UIKit

struct TouchPointsAndColor {
    var color: UIColor?
    var width: CGFloat?
    var opacity: CGFloat?
    var points: [CGPoint]?
 
    init(color: UIColor, points: [CGPoint]?) {
        self.color = color
        self.points = points
    }
}

class CanvasView: UIView {

    var lines = [TouchPointsAndColor]()
    var strokeWidth: CGFloat = 1.0
    var strokeColor: UIColor = .black
    var strokeOpacity: CGFloat = 1.0
    
    var textFieldStatus = 0
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }

        lines.forEach { (line) in
//            let lineP = line.points
            
            for (i, p) in (line.points?.enumerated())! {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
                context.setStrokeColor(line.color?.withAlphaComponent(line.opacity ?? 1.0).cgColor ?? UIColor.black.cgColor)
                context.setLineWidth(line.width ?? 1.0)
            }
            
            context.setLineCap(.round)
            context.strokePath()
        }
        
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//
//            lines.append(TouchPointsAndColor(color: UIColor(), points: [CGPoint]()))
//
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first?.location(in: nil) else {
//            return
//        }
//
//        guard var lastPoint = lines.popLast() else {return}
//        lastPoint.points?.append(touch)
//        lastPoint.color = strokeColor
//        lastPoint.width = strokeWidth
//        lastPoint.opacity = strokeOpacity
//        lines.append(lastPoint)
//        setNeedsDisplay()
//    }
    
    
    @objc func move(gesture : UIPanGestureRecognizer)
        {
            let state = gesture.state
            switch state  {
            case .began:
                lines.append(TouchPointsAndColor(color: UIColor(), points: [CGPoint]()))
            case .ended:
                fallthrough

            case .changed:
                gesture.setTranslation(gesture.location(in: self), in: self)
                let p = gesture.translation(in: self)

                guard var lastPoint = lines.popLast() else {return}
                lastPoint.points?.append(p)
                print(p)
                lastPoint.color = strokeColor
                lastPoint.width = strokeWidth
                lastPoint.opacity = strokeOpacity
                lines.append(lastPoint)

                setNeedsDisplay()
            default:
                break
            }
        }
    
    func clearCanvasView() {
        lines.removeAll()
        setNeedsDisplay()
    }
    
    func undoDraw() {
        if lines.count > 0 {
            lines.removeLast()
            setNeedsDisplay()
        }
    }
   
    
}
