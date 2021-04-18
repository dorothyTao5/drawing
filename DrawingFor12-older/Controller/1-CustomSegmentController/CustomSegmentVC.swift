//
//  CustomSegmentVC.swift
//  DrawingFor12-older
//
//  Created by dorothyLiu on 2021/4/16.
//

import UIKit

class CustomSegmentVC: UIViewController {

    @IBOutlet weak var lcViewW: NSLayoutConstraint!
    @IBOutlet weak var lcViewH: NSLayoutConstraint!
    
    @IBOutlet weak var customSegment: CustomSegment!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customSegment.lcHeight = lcViewH
        customSegment.lcWidth = lcViewW
        
        let rCenterPoint = customSegment.getRightCGCenter()
        customSegment.setupDownRightLabel(cgpoint: rCenterPoint)
        let lCenterPoint =  customSegment.getLeftCGCenter()
        customSegment.setupDownLeftLabel(cgpoint: lCenterPoint)
        customSegment.setUpSelectedView(cgpoint: lCenterPoint)
        customSegment.vOriginal = lCenterPoint
        customSegment.isOnLeftSide = true
       
        
        
    }


    
    

}
