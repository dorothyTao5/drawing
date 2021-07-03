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

        setUpCustomSegment()
        
    }

    func setUpCustomSegment() {
        ////把View的高與寬給Segment，初始化segment
        customSegment.connectCustomSegment(lcBGViewH: lcViewH, lcBGViewW: lcViewW)
        ////
        customSegment.segmentSwitched = self.setUpSwitchBeheaver

    }
    
    func setUpSwitchBeheaver() {
        customSegment.switchRightToLeft {
            print(" switchedToLeft =",customSegment.isOnLeftSide )
            self.view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        } switchLeftToRight: {
            print(" switchedToRight =",customSegment.isOnLeftSide )
            self.view.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }

    }
    
   
    
    
    
    

}
