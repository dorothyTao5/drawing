//
//  CustomSegment.swift
//  DrawingFor12-older
//
//  Created by dorothy on 2021/4/18.

//https://suragch.medium.com/creating-custom-views-in-ios-for-multiple-reuse-b2307a57d792

import UIKit

@IBDesignable
class CustomSegment: UIView {
    
    //segment【沒有選到的】normal text color
    @IBInspectable var ColBasicTxtR: UIColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
    @IBInspectable var ColBasicTxtL: UIColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
    //segment【選到的】Label text color
    @IBInspectable var ColSeletedR: UIColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    @IBInspectable var ColSeletedL: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    //segment 左右兩邊Label text
    @IBInspectable var LbTextR: String = "LbRight"
    @IBInspectable var LbTextL: String = "LbLeft"
    //Segment上可移動的背景顏色
    @IBInspectable var ColSubVwR: UIColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
    @IBInspectable var ColSubVwL: UIColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
    //segment 的外框
    @IBInspectable var borderWidth: CGFloat = 2
    @IBInspectable var borderColor: UIColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)

    @IBInspectable var isOnLeftSide = true
    
    var lcHeight: NSLayoutConstraint!
    var lcWidth: NSLayoutConstraint!
    
    
//    var lcHeightC: CGFloat = 80
//    var lcWidthC: CGFloat = 240
    
    //segment上可滑動的View&& Label
    let subView = UIView()
    var lbUp = UILabel()
    var lbDownR = UILabel()
    var lbDownL = UILabel()
    
   
    lazy var vOriginal : CGPoint!  = {
        getLeftCGCenter()
    }()
    lazy var movedPosition :CGPoint! = {
        getLeftCGCenter()
    }()
    
    
    lazy var leftEdge : CGPoint!  = {
        getLeftCGCenter()
    }()
    
    lazy var rightEdge : CGPoint!  = {
        getRightCGCenter()
    }()
    
  
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    
    
    
    //    MARK: - functions
    func commonInit() {
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.size.height/2
        self.layer.borderWidth = 2
        self.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
       
        lbDownL.text = LbTextL
        lbDownR.text = LbTextR
        
       
        
        if isOnLeftSide == true {
            lbUp.text = lbDownL.text
        }else {
            lbUp.text = lbDownR.text
        }
        
        
        let panH = UIPanGestureRecognizer(target: self, action: #selector(panHorizontal))
        subView.addGestureRecognizer(panH)
        
    }
    
   
    
    
    func getLeftCGCenter() -> CGPoint {
        let yCenterPoint = lcHeight.constant / 2
        let leftXPoint = lcWidth.constant / 4
       return CGPoint(x: leftXPoint ,y: yCenterPoint )
        
    }
    
    func getRightCGCenter() -> CGPoint {
        let yCenterPoint = lcHeight.constant / 2
        let rightXPoint = lcWidth.constant / 4 * 3
        return CGPoint(x: rightXPoint ,y: yCenterPoint )
    }
    
    //    MARK: - setUpViews
    func setUpSelectedView(cgpoint:CGPoint) {
        
        subView.frame = CGRect(x: 0, y: 0, width: lcWidth.constant / 2, height: lcHeight.constant )
        subView.center = cgpoint
        
        if isOnLeftSide == true {
            subView.backgroundColor = ColSubVwL
           
            lbDownR.textColor = ColBasicTxtR
            lbDownL.textColor = ColSeletedL
            lbDownL.text = LbTextL
            lbUp.text = lbDownL.text
            lbUp.textColor = lbDownL.textColor
        }else {
            subView.backgroundColor = ColSubVwR

            lbDownL.textColor = ColBasicTxtL
            lbDownR.textColor = ColSeletedR
            lbDownR.text = LbTextR
            lbUp.text = lbDownR.text
            lbUp.textColor = lbDownR.textColor
        }
        
        subView.layer.masksToBounds = true
        subView.layer.cornerRadius = subView.layer.frame.height / 2
        
        lbUp = setUpLabel(label: lbUp)
        
        subView.addSubview(lbUp)
        self.addSubview(subView)
    }
    
    func setupDownRightLabel(cgpoint:CGPoint) {
        lbDownR = setUpLabel(label: lbDownR)
        lbDownR.center = getRightCGCenter()
        lbDownR.text = LbTextR
        self.addSubview(lbDownR)
    }
    func setupDownLeftLabel(cgpoint:CGPoint) {
        lbDownL = setUpLabel(label: lbDownL)
        lbDownL.center = getLeftCGCenter()
        lbDownL.text = LbTextL
        self.addSubview(lbDownL)
    }
    
    func setUpLabel(label:UILabel) -> UILabel {
        label.frame = CGRect(x: 0, y: 0, width: lcWidth.constant / 2, height: lcWidth.constant)
        label.textAlignment = .center
        label.center = subView.center
        label.backgroundColor = .clear
        return label
    }
    
   //    MARK: - SetUpLabelLike
    func setUpSelectedLabel( downLabel:UILabel,
                            selectedLabel:UILabel,
                            basicColor: UIColor,
                            activeTxtCol: UIColor,
                            colorSubViewBG: UIColor) {
        
       
        selectedLabel.textColor = activeTxtCol
        lbUp.text = selectedLabel.text
        lbUp.textColor = selectedLabel.textColor
        subView.backgroundColor = colorSubViewBG
    }
    
    func setUpUnselectedLabel( downLabel:UILabel, basicColor: UIColor){
        downLabel.textColor = basicColor
        downLabel.isHidden = false
    }
   
    
    //MARK: - Pan label左右移動
    @objc func panHorizontal(sender: UIPanGestureRecognizer) {
            ///get how far have moved
            let translation = sender.translation(in: self)
            ///get velocity in view
            let velocity = sender.velocity(in: self)
            
        switch isOnLeftSide {
        case true:  //left to right
           
            if sender.state == UIGestureRecognizer.State.began {
                vOriginal = subView.center
                lbDownL.isHidden = true
                
            } else if sender.state == UIGestureRecognizer.State.changed {
                guard subView.center.x >  leftEdge.x else { return subView.center = leftEdge}
                subView.center = CGPoint(x: vOriginal.x + translation.x, y: vOriginal.y)
                print("is on right Side")
               
            } else if sender.state == UIGestureRecognizer.State.ended {
               
                if velocity.x > 0 {
                    UIView.animate(withDuration: 0.3, animations: { () -> Void in
                        self.subView.center = self.rightEdge
                    })
                    isOnLeftSide = false
                    setUpUnselectedLabel(downLabel: lbDownL, basicColor: ColBasicTxtL)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [self] in
                    setUpSelectedLabel( downLabel: lbDownL ,
                                       selectedLabel: lbDownR,
                                       basicColor: ColBasicTxtL,
                                       activeTxtCol: ColSeletedR,
                                       colorSubViewBG: ColSubVwR)
                    }
                }else {
                    subView.center = leftEdge
                }
               
                
            }
           
            
        case false :  //right to left
            
            if sender.state == UIGestureRecognizer.State.began {
                vOriginal = subView.center
                lbDownR.isHidden = true
                
            } else if sender.state == UIGestureRecognizer.State.changed {
                guard subView.center.x > rightEdge.x else { return subView.center = rightEdge}
                subView.center = CGPoint(x: vOriginal.x + translation.x, y: vOriginal.y)
                print("is on left Side")
            } else if sender.state == UIGestureRecognizer.State.ended {
                
                if velocity.x < 0 {
                    UIView.animate(withDuration: 0.3, animations: { () -> Void in
                        self.subView.center = self.leftEdge
                    })
                    isOnLeftSide = true
                    print("//right to left",velocity.x)
                    setUpUnselectedLabel(downLabel: lbDownR, basicColor: ColBasicTxtR)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [self] in
                        setUpSelectedLabel( downLabel: lbDownR,
                                           selectedLabel: lbDownL,
                                           basicColor: ColBasicTxtR,
                                           activeTxtCol: ColSeletedL,
                                           colorSubViewBG: ColSubVwL)
                    }
                    
                }else {
                    subView.center = rightEdge
                }
               
            }
            
            
       
        }
       
        
    }
}
