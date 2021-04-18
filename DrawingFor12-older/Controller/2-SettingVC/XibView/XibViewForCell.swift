//
//  XibViewForCell.swift
//  FakeMoveSection
//
//  Created by 劉爾婷 on 2020/10/16.
//

import UIKit

class XibViewForCell: UIView {

    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var lbCellItem: UILabel!
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        let viewFromXib = Bundle.main.loadNibNamed("XibViewForCell", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }
    
    
}
