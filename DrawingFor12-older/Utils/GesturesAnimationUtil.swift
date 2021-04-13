//
//  TrayAnimation.swift
//  DrawingFor12-older
//
//  Created by 2010011NB01 on 2021/1/25.
//

import Foundation
import UIKit

class GesturesAnimationUtil {
    
/*   sender：判斷手勢狀態
     var： trayOriginalCenter: CGPoint!;
     viewBG- 要被做動畫的背景View；
     targetBtn- 控制背景view上下的Btn；
     var trayUp: CGPoint! ；
     var trayDown: CGPoint!
 */
    
    static func upAndDown (_ sender:UIPanGestureRecognizer, in view:UIView,  trayOriginalCenter:  inout CGPoint,  viewBG:  UIView, targetBtn:UIButton,  trayUp: CGPoint,  trayDown: CGPoint ) {
        //https://guides.codepath.com/ios/Moving-and-Transforming-Views-with-Gestures
        let translation = sender.translation(in: view)
        ///get velocity in view
        let velocity = sender.velocity(in: view)
        
        if sender.state == UIGestureRecognizer.State.began {
            trayOriginalCenter = viewBG.center
//            print(trayOriginalCenter)
            
            
        } else if sender.state == UIGestureRecognizer.State.changed {
            viewBG.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
//            print(viewBG.center)
            
            
        } else if sender.state == UIGestureRecognizer.State.ended {
            
            if velocity.y > 0 {
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    viewBG.center = trayDown
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { // Change `2.0` to the
                    targetBtn.tag = 0
                    viewBG.isHidden = true
                }
                
            }
//            else {
//                UIView.animate(withDuration: 0.3, animations: { () -> Void in
//                    viewBG.center = trayDown
//                })
//
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { // Change `2.0` to the
//                    targetBtn.tag = 0
//                    viewBG.isHidden = true
//                }
//            }
            
            
        }
    }
    
    
    func hideHexView(_ btnArrow:UIButton,_ viewHexColor:UIView){
        btnArrow.tag = 0
        viewHexColor.isHidden = true
    }
    
    static func moveAround(_ sender:UIPanGestureRecognizer, in view:UIView, viewOriginalCenter: inout CGPoint, movedPosition: inout CGPoint, object: inout UITextField) {
        
        let translation = sender.translation(in: view)
        
        if sender.state == UIGestureRecognizer.State.began {
            HapticsUtil.feedbackMedium()
            viewOriginalCenter = object.center
            
        } else if sender.state == UIGestureRecognizer.State.changed {
            object.center = CGPoint(x: viewOriginalCenter.x + translation.x, y: viewOriginalCenter.y + translation.y)
            movedPosition = object.center
            
        } else if sender.state == UIGestureRecognizer.State.ended {
            HapticsUtil.feedbackMedium()
            object.center = CGPoint(x: viewOriginalCenter.x + translation.x, y: viewOriginalCenter.y + translation.y)
        }
        
    }
}


// 使用範例：
/*

 ///一進畫面定位viewHexColor 最高 最低 定位位置
 var hexViewUp: CGPoint! = CGPoint(x: 228.0 ,y: 616.5 )
 var hexViewDown: CGPoint!  = CGPoint(x: 228.0 ,y: 700.5 )
 var trayOriginalCenter: CGPoint! = CGPoint(x: 228.0 ,y: 616.5 )
 var movedPosition :CGPoint!
 
 ///左上角TextEditor
 var txtvOriginal : CGPoint! = CGPoint(x: 200.0 ,y: 100 )
 var txtMovedPosition :CGPoint! = CGPoint(x: 200.0 ,y: 100 )
 var arrLb : [UILabel] = []
 
 ///如果不嫩移動需添加 isUserInteractionEnabled = true
 self.txtFieldTitle.delegate = self
 txtFieldTitle.isUserInteractionEnabled = true
 txtFieldTitle.center = txtvOriginal
 
 
///拖動viewHexColor動畫
@IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
    GesturesAnimationUtil.upAndDown(sender,
                            in: view,
                            trayOriginalCenter: &trayOriginalCenter,
                            viewBG: viewHexColorBG,
                            targetBtn: btnHex,
                            trayUp: hexViewUp,
                            trayDown: hexViewDown)
}



///移動文字輸入框
@IBAction func handleTxt(_ sender: UIPanGestureRecognizer) {
    GesturesAnimationUtil.moveAround(sender,
                             in: view,
                             viewOriginalCenter: &txtvOriginal,
                             movedPosition: &txtMovedPosition,
                             object: &txtFieldTitle)
}

*/
