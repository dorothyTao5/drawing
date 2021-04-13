//
//  DrawingExtensionGesture.swift
//  DrawingFor12-older
//
//  Created by dorothyLiu on 2021/4/13.
//

import Foundation
import UIKit

//MARK: - *CreateGestureLabel

extension DrawingVC {
    
    func updateLabel(toText str: String, lbTag: Int) {
        if let lb = dicLabel[lbTag]?.first as? UILabel {
            lb.text = str
            resizeLabelToText(labelName: lb)
        }
        
    }
    
    func createOneGestureLabel(withText str: String) {
        var arrLb : [Any] = []
        orderLb += 1
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.isUserInteractionEnabled = true
        label.center = CGPoint(x: 160, y: 285)
        label.textAlignment = .center
        label.text = str
        label.font = label.font.withSize(30)
        label.tag = orderLb
        label.textColor = currentColor.withAlphaComponent(CGFloat( opacitySlider.value))
        
        let deleIV = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        deleIV.isUserInteractionEnabled = true
        deleIV.image = UIImage(named: "cross_mark")
        deleIV.tag = orderLb
        deleIV.isHidden = true
        
        let scaleLb = CGFloat(30)
        
        arrLb.append(label)
        arrLb.append(deleIV)
        arrLb.append(scaleLb)
        label.addSubview(deleIV)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressRecognize))
        label.addGestureRecognizer(longPressGesture)
//        longPressGesture.delegate = self
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panRecognize))
        label.addGestureRecognizer(panGesture)
//        panGesture.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapRecognize))
        tapGesture.numberOfTapsRequired = 2
        label.addGestureRecognizer(tapGesture)
        
        
        let pinchnGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchedRecognize))
        label.addGestureRecognizer(pinchnGesture)
        pinchnGesture.delegate = self
        
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotateRecognize))
        label.addGestureRecognizer(rotateGesture)
        rotateGesture.delegate = self
        
        let tapGestureDelete = UITapGestureRecognizer(target: self, action: #selector(tapRecognizeDelete))
        deleIV.addGestureRecognizer(tapGestureDelete)

        resizeLabelToText(labelName: label)
        
        dicLabel[orderLb] = arrLb
        
        canvasView.addSubview(label)
        
    }
    
    func resizeLabelToText(labelName lb: UILabel) {
        let labelSize = lb.intrinsicContentSize
        let largerLbSize = CGSize(width: labelSize.width + 90, height: labelSize.height + 50)
        lb.bounds.size = largerLbSize
    }
    
    func doubleTapEvent(view : UIView ) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(doubleTapLeaveEditMode))
        tapGesture.numberOfTapsRequired = 2
        view.addGestureRecognizer(tapGesture)
    }
    
    //MARK: LongPress to delete Lb
    @objc func longPressRecognize(_ sender: UILongPressGestureRecognizer) {
       
        if sender.state == UIGestureRecognizer.State.began {
            HapticsUtil.feedbackMtoH() ///長按點擊觸覺回饋
            
        }else if sender.state == UIGestureRecognizer.State.ended {
            HapticsUtil.feedbackHeavy()
            let lb = sender.view as! UILabel
            let tagInt = lb.tag
            
            let arr = dicLabel[tagInt]
            let iv = arr![1]  as! UIImageView
            let lbTxt = arr![0] as! UILabel
            iv.isHidden = false
            
            // extension UIView -- animate
            // https://stackoverflow.com/questions/27987048/shake-animation-for-uitextfield-uiview-in-swift
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.2
            animation.repeatCount = 5
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: lbTxt.center.x - 10, y: lbTxt.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: lbTxt.center.x + 10, y: lbTxt.center.y))

            lbTxt.layer.add(animation, forKey: "position")
            editModeOn = true
        }
        
    }
    
    //MARK: Pan label任意移動
    @objc func panRecognize(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        let selectedLabel = sender.view!
    
        switch sender.state {
        case .began:
            HapticsUtil.feedbackMedium()
            
        case .changed:
            selectedLabel.center = CGPoint(x: selectedLabel.center.x + translation.x,
                                           y: selectedLabel.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: self.view)
            
        case .ended:
            HapticsUtil.feedbackMedium()
                    
        default:
            return
        }
        
    }
    
    @objc func tapRecognize(sender:UITapGestureRecognizer) {
        HapticsUtil.feedbackMedium()
        
        let vc = EditTextVC()
        vc.delegate = self
        
        if let label = sender.view as? UILabel {
            vc.str = label.text ?? ""
            vc.tagLabel = label.tag
        }
        
        navigationController?.pushViewController(vc, animated: true)
        
        let lb = sender.view as! UILabel
        let tagInt = lb.tag
        let arr = dicLabel[tagInt]
        let iv = arr![1]  as! UIImageView
        iv.isHidden = true
        
    }

    @objc func doubleTapLeaveEditMode(sender:UITapGestureRecognizer) {
//        HapticsUtil.feedbackMedium()
//        
//        if editModeOn == true {
//            editModeOn = false
//            for i in 0..<dicLabel.count {
//                
//                let arr = dicLabel
//                let dic = arr[i]
//                let iv = dic![1]  as! UIImageView
//                DispatchQueue.main.async{
//                    iv.isHidden = true
//                }
//            }
//        }
        
    }

    
    //MARK: double Tap label 刪除
    @objc func tapRecognizeDelete(sender:UITapGestureRecognizer) {
        print("tap on delete")
        let view = sender.view!
        let iv = view as! UIImageView
        let ivTag = iv.tag
        let lb = dicLabel[ivTag]?.first as! UILabel

        lb.removeFromSuperview()
        iv.removeFromSuperview()
        dicLabel.removeValue(forKey: ivTag)
         
    }

    //MARK: Pinch label放大縮小
    /// - tag: lbTextScale 初始值 要再修正
    @objc func pinchedRecognize(_ sender: UIPinchGestureRecognizer) {

        let selectedLb = sender.view as! UILabel
        let selectedTag = selectedLb.tag

        var arr = dicLabel[selectedTag]
        let lb = arr![0]  as! UILabel
        
        let origLbScale = arr![2] as! CGFloat
        
        switch sender.state {
        case .began:
            sender.scale = origLbScale
//            lb.transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
            lb.font = UIFont(name: lb.font.familyName, size: origLbScale)
            
        case .changed:
//            lb.transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
            lb.font = UIFont(name: lb.font.familyName, size: sender.scale)
            resizeLabelToText(labelName: selectedLb)
            
        case .ended:
            ///saving fional scale
            arr![2] = sender.scale
            dicLabel[selectedTag] = arr
                    
        default:
            return
        }

    }
    
    
    //MARK: Rotate label旋轉
    @IBAction func rotateRecognize(sender: UIRotationGestureRecognizer) {
        
        let rotation = sender.rotation
        let label = sender.view as! UILabel
        
        var arr = dicLabel[label.tag]
        let lb = arr![0] as! UILabel
        let previousTransform = lb.transform
        
        lb.transform = previousTransform.rotated(by: rotation)
        sender.rotation = 0
        
        arr![0] = lb
        dicLabel[label.tag] = arr

    }
    
    
}

//MARK: - UIGestureRecognizerDelegate
extension DrawingVC: UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        print(gestureRecognizer)
        return true
    }
}
