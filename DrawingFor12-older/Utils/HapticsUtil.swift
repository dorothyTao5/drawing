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

/// - tag: final 防止class 被繼承，被override
public final class HapticsUtil {
    
    public static func feedbackLight() {
        
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        generator.impactOccurred()

    }
    
    public static func feedbackMedium() {
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()

    }
    
    
    public static func feedbackHeavy() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.prepare()
        generator.impactOccurred()

    }
    
    //長按點擊觸覺回饋 有雙重震動
    public static func feedbackMtoH() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            HapticsUtil.feedbackMedium()
        }
        HapticsUtil.feedbackHeavy()
    }
    
}
