//
//  CustomSegment.swift
//  DrawingFor12-older
//
//  Created by dorothy on 2021/4/18.

//https://suragch.medium.com/creating-custom-views-in-ios-for-multiple-reuse-b2307a57d792

/// - tag: 必須呼叫的Func
/// - tag: [var segmentSwitchedToLeft : (()->Void)?   var segmentSwitchedToRight : (()->Void)?] 控制移動過後的行為
/// - tag: [connectCustomSegment] 在viewdidload 建立介面
/// - tag: view‘s custom class 要設定成 CustomSegment
/// ex： in view did load
/*
 override func viewDidLoad() {
     super.viewDidLoad()
    customSegment.connectCustomSegment(lcBGViewH: lcBGViewH, lcBGViewW: lcViewW)
    customSegment.segmentSwitched = switchedBehaviorFunc
}
 
func switchedBehaviorFunc ( )    {
    switch vwSgc.isOnLeftSide {
    case true: //right to left = green
        print(" switchedToLeft =",vwSgc.isOnLeftSide )
        userDefaultSave(key: .ThemeIsRed, saveObj: false)
        
        Theme.current = BlueTheme()
        
    case false: //left to right = red
        print(" switchedToRight =",vwSgc.isOnLeftSide )
        
        userDefaultSave(key: .ThemeIsRed, saveObj: true)
        Theme.current = RedTheme()
    }  }
*/


import UIKit

//@IBDesignable
class CustomSegment: UIView {
    
    
    @IBInspectable var isOnLeftSide: Bool = true
    //segment【沒有選到的】normal text color
    @IBInspectable var ColBasicTxtR: UIColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
    @IBInspectable var ColBasicTxtL: UIColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
    //segment【選到的】Label text color
    @IBInspectable var ColSeletedR: UIColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    @IBInspectable var ColSeletedL: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    //segment 左右兩邊Label text
    @IBInspectable var LbTextR: String = "LbRight"
    @IBInspectable var LbTextL: String = "LbLeft"
    //所有label.text 大小
    @IBInspectable var TextSize: CGFloat = 20
    //Segment上可移動的背景顏色
    @IBInspectable var ColSubVwR: UIColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
    @IBInspectable var ColSubVwL: UIColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
    //segment 的外框
    @IBInspectable var borderWidth: CGFloat = 2
    @IBInspectable var borderColor: UIColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    
    //segment上可滑動的View&& Label
    let subView = UIView()
    var lbUp = UILabel()
    var lbDownR = UILabel()
    var lbDownL = UILabel()
    
   
    lazy var vOriginal : CGPoint!  = {
        if isOnLeftSide == true {
            return getLeftCGCenter()
        }else {
           return getRightCGCenter()
        }
    }()
    lazy var movedPosition :CGPoint! = {
        if isOnLeftSide == true {
            return getLeftCGCenter()
        }else {
           return getRightCGCenter()
        }
    }()
    
    
    lazy var leftEdge : CGPoint!  = {
        getLeftCGCenter()
    }()
    
    lazy var rightEdge : CGPoint!  = {
        getRightCGCenter()
    }()
    
    //MARK: - **必須設定的var**
    ///switch 後的行為
    var segmentSwitched : (()->Void)?
    ///給view的高和寬
    var lcHeight: NSLayoutConstraint!
    var lcWidth: NSLayoutConstraint!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    

    
    //MARK: - **必須呼叫的Func**
    ///建立segment
    func connectCustomSegment(lcBGViewH: NSLayoutConstraint, lcBGViewW:NSLayoutConstraint){
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        
        lcHeight = lcBGViewH
        lcWidth = lcBGViewW
        let rCenterPoint = getRightCGCenter()
        let lCenterPoint =  getLeftCGCenter()
        
        setUpDownLabel(lbDown: &lbDownR, lbText: LbTextR, getCenter: getRightCGCenter)
        setUpDownLabel(lbDown: &lbDownL, lbText: LbTextL, getCenter: getLeftCGCenter)
        
        switch isOnLeftSide {
        case true:
            setUpSelectedView(cgpoint: lCenterPoint)
            vOriginal = lCenterPoint
        case false:
            setUpSelectedView(cgpoint: rCenterPoint)
            vOriginal = rCenterPoint
        }

    }
    
    
    //    MARK: - Functions
    
    
    
    //MARK: - Get Position
    
    func commonInit() {
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.size.height/2
       
        lbDownL.text = LbTextL
        lbDownR.text = LbTextR
        
        if isOnLeftSide == true {
            lbUp.text = lbDownL.text
        }else {
            lbUp.text = lbDownR.text
        }
        
        let panH = UIPanGestureRecognizer(target: self, action: #selector(panHorizontal))
        subView.addGestureRecognizer(panH)
        
        lbDownL.isUserInteractionEnabled = true
        lbDownR.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapRecognize))
        lbDownL.addGestureRecognizer(tapGesture)
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(tapRecognize))
        lbDownR.addGestureRecognizer(tapGesture2)
        
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
    
    func animateSubViewFromLeftToRight() {
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
        self.segmentSwitched!()
       
    }
    
    func animateSubViewFromRightToLeft() {
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.subView.center = self.leftEdge
        })
        isOnLeftSide = true
        setUpUnselectedLabel(downLabel: lbDownR, basicColor: ColBasicTxtR)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [self] in
            setUpSelectedLabel( downLabel: lbDownR,
                               selectedLabel: lbDownL,
                               basicColor: ColBasicTxtR,
                               activeTxtCol: ColSeletedL,
                               colorSubViewBG: ColSubVwL)
        }
        self.segmentSwitched!()
        
    }
    
    //    MARK: - SetUpLabelAlike
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
    
    //    MARK: - setUpViews
    func setUpSelectedView(cgpoint:CGPoint) {
        
        subView.frame = CGRect(x: 0, y: 0, width: lcWidth.constant / 2, height: lcHeight.constant )
        subView.center = cgpoint
        lbUp.center = cgpoint
        
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
    
    
    func setUpDownLabel(lbDown: inout UILabel,lbText:String, getCenter: ()->CGPoint) {
        lbDown = setUpLabel(label: lbDown)
        lbDown.font = lbDown.font.withSize(TextSize)
        lbDown.center = getCenter()
        lbDown.text = lbText
        self.addSubview(lbDown)
    }
    
    func setUpLabel(label:UILabel) -> UILabel {
        label.frame = CGRect(x: 0, y: 0, width: lcWidth.constant / 2, height: lcHeight.constant)
        label.font = label.font.withSize(TextSize)
        label.textAlignment = .center
        label.backgroundColor = .clear
        
        return label
    }
    
  ///已經合併成 setUpDownLabel（）
    //    func setupDownRightLabel(cgpoint:CGPoint) {
    //        lbDownR = setUpLabel(label: lbDownR)
    //        lbDownR.center = getRightCGCenter()
    //        lbDownR.text = LbTextR
    //        self.addSubview(lbDownR)
    //    }
    //    func setupDownLeftLabel(cgpoint:CGPoint) {
    //        lbDownL = setUpLabel(label: lbDownL)
    //        lbDownL.center = getLeftCGCenter()
    //        lbDownL.text = LbTextL
    //        self.addSubview(lbDownL)
    //    }
    
    
    //MARK: - @objc func
    

   
    //MARK: - 點擊label移動segment
    @objc func tapRecognize(sender:UITapGestureRecognizer) {
        guard let label = sender.view as? UILabel else {return}
 
        switch label.text {
        case LbTextL:
            animateSubViewFromRightToLeft()

        case LbTextR:
            animateSubViewFromLeftToRight()

        default:
            print("tapRecognize got error")
        }
        
    }
    
    //MARK: - Pan label左右移動
    @objc func panHorizontal(sender: UIPanGestureRecognizer) {
            ///get how far have moved
            let translation = sender.translation(in: self)
            ///get velocity in view
            let velocity = sender.velocity(in: self)
        let x = vOriginal.x + translation.x
        
        switch isOnLeftSide {
        case true:  //left to right
           
            if sender.state == UIGestureRecognizer.State.began {
                vOriginal = subView.center
                lbDownL.isHidden = true
                
            } else if sender.state == UIGestureRecognizer.State.changed {
                
                guard velocity.x > 0 else {return}
                
                if x > rightEdge.x {
                    subView.center = CGPoint(x: rightEdge.x, y: vOriginal.y)
                } else if x > 0 {
                    subView.center = CGPoint(x: x, y: vOriginal.y)
                }
                
                print("is on right Side")
                
            } else if sender.state == UIGestureRecognizer.State.ended {
                if velocity.x > 0 {
                    animateSubViewFromLeftToRight()

                }else {
                    subView.center = leftEdge
                }
               
            }
           
            
        case false :  //right to left
            
            if sender.state == UIGestureRecognizer.State.began {
                vOriginal = subView.center
                lbDownR.isHidden = true
                
            } else if sender.state == UIGestureRecognizer.State.changed {
//                guard subView.center.x > rightEdge.x else { return subView.center = rightEdge}
//                subView.center = CGPoint(x: vOriginal.x + translation.x, y: vOriginal.y)
                guard velocity.x < 0 else {return}
                
                if x < leftEdge.x {
                    subView.center = CGPoint(x: leftEdge.x, y: vOriginal.y)
                } else if x < rightEdge.x {
                    subView.center = CGPoint(x: x, y: vOriginal.y)
                }
                
                print("is on left Side")
                
            } else if sender.state == UIGestureRecognizer.State.ended {
                if velocity.x < 0 {
                    animateSubViewFromRightToLeft()

                }else {
                    subView.center = rightEdge
                }
               
            }
             
        }
        
        
    }
    
    
    
    
}
