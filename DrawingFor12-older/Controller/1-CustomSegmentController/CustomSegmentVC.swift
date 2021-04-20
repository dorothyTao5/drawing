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
        customSegment.connectCustomSegment(lcBGViewH: lcViewH, lcBGViewW: lcViewW)
        customSegment.segmentSwitched = self.segmentSwitched
    }
    
    
    func segmentSwitched() {
        switch customSegment.isOnLeftSide {
        case true: //right to left
            print(" switchedToLeft =",customSegment.isOnLeftSide )
            self.view.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
            
        case false: //left to right
            print(" switchedToRight =",customSegment.isOnLeftSide )
            self.view.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        }
        
    }
    
   
    
    
    
    

}
