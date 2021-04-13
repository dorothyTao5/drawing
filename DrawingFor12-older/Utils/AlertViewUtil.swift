//
//  AlertView.swift
//  DrawingFor12-older
//
//  Created by 2010011NB01 on 2021/1/20.
//

import Foundation
import UIKit

class AlertViewUtil{

    static func show(vc:UIViewController, message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
              switch action.style{
              case .default:
                    print("default")

              case .cancel:
                    print("cancel")

              case .destructive:
                    print("destructive")


        }}))
        vc.present(alert, animated: true, completion: nil)
    }
    
    
}
