//
//  鍵盤不遮擋文字框.swift
//  DrawingFor12-older
//
//  Created by 2010011NB01 on 2021/1/21.
//

import Foundation
import UIKit

class 鍵盤不遮擋文字框: UIViewController, UITextFieldDelegate {
    var originalFrame : CGRect?
    
    @IBOutlet weak var textField: UITextField!
    //輸入框所在的view上
    @IBOutlet weak var targetView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillAppear(notification : Notification)  {
        let info = notification.userInfo!
        let currentKeyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        let duration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        let textFrame = self.targetView.window!.convert(self.textField.frame, from: self.targetView)
        
        var visibleRect = self.targetView.frame;
        if self.originalFrame == nil {
            self.originalFrame = visibleRect
        }
        if (  textFrame.maxY > currentKeyboardFrame.minY ) {
            let difference = textFrame.maxY - currentKeyboardFrame.minY
            visibleRect.origin.y = visibleRect.origin.y - difference
            UIView.animate(withDuration: duration) {
                self.targetView.frame = visibleRect
            }
        }
    }
    
    @objc func keyboardWillHide(notification : Notification)  {
        //        let info = notification.userInfo!
        UIView.animate(withDuration: 0.5) {
            self.targetView.frame = self.originalFrame!
        }
    }
    
    
    
}
