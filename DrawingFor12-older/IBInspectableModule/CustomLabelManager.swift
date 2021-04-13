//
//  CustomLabelModule.swift
//  Qpesums
//
//  Created by dorothyLiu on 2021/4/9.
//  Copyright © 2021 IISI. All rights reserved.
//

import Foundation
import UIKit

open class CustomLabelManager : UILabel {
    @IBInspectable var topInset: CGFloat = 5.0
       @IBInspectable var bottomInset: CGFloat = 5.0
       @IBInspectable var leftInset: CGFloat = 7.0
       @IBInspectable var rightInset: CGFloat = 7.0

    open override func drawText(in rect: CGRect) {
           let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
           super.drawText(in: rect.inset(by: insets))
       }

    open override var intrinsicContentSize: CGSize {
           let size = super.intrinsicContentSize
           return CGSize(width: size.width + leftInset + rightInset,
                         height: size.height + topInset + bottomInset)
       }

    open override var bounds: CGRect {
           didSet {
               // ensures this works within stack views if multi-line
               preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
           }
       }
}
