//
//  ImpactFeedback.swift
//  DrawingFor12-older
//
//  Created by dorothyLiu on 2021/4/8.
//

import Foundation
import UIKit
//Human Interface Guidelines
//https://developer.apple.com/design/human-interface-guidelines/ios/user-interaction/haptics/

class HapticsUtil {
    
    static func feedbackMedium() {
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()

    }
    
    
    static func feedbackHeavy() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.prepare()
        generator.impactOccurred()

    }
    
    //長按點擊觸覺回饋 有雙重震動
    static func feedbackMtoH() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            HapticsUtil.feedbackMedium()
        }
        HapticsUtil.feedbackHeavy()
    }
    
}
