//
//  ComingFromUpRightVC.swift
//  DrawingFor12-older
//
//  Created by dorothy on 2021/6/27.
//

import UIKit

class ComingFromUpRightVC: UIViewController {
    var viewIsHidden = true
   
//    let squareBlue = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItems = [add]
        
        
    }
    
    

    @IBAction func btnAddPressed(_ sender: UIButton) {

    }
    
    @objc func addTapped() {
        if viewIsHidden {
            viewIsHidden = false
            showView()
        }else {
            viewIsHidden = true
            showView()
        }
    }
    
  

  
    func showView () {
//        AnimationUtil.scaleShowCenter(view: InfoDescripView.shared, fromObject: (self.navigationController?.view)!)
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        let navigY = navigationController?.navigationBar.center.y
        let cgpoint = CGPoint(x: screenWidth/2 - 25 , y: -screenHeight/2 + navigY!)
//        let cgpoint = CGPoint(x: screenWidth/2 - 25, y: 100)
        InfoDescripView.setUpView(on: view)
        AnimationUtil.scaleShowCenter(view: InfoDescripView.shared, fromCenter: cgpoint)
    }
    func bbb() {
        
    }
   
   
}

struct AnimationUtil {

    public static func scaleShowCenter(view:UIView,fromCenter customcenter:CGPoint){
        let x = view.superview!.center.x
        let y = view.superview!.center.y
        let cgpoint = CGPoint(x: x, y: y)
        if view.tag == 0 {
            view.tag = 99
            view.alpha = 1
            
            let originalTransform = view.transform
            let scaledTransform = originalTransform.translatedBy(x: customcenter.x, y: customcenter.y)
            let scaledAndTranslatedTransform = scaledTransform.scaledBy(x: 0.1, y: 0.1)
            view.transform = scaledAndTranslatedTransform
            
            view.layoutIfNeeded()
            UIView.animate(withDuration: 0.5, delay: 0,usingSpringWithDamping: 1,
                           initialSpringVelocity: 2, options:.curveEaseInOut, animations: {
                            view.transform = .identity
                            view.layoutIfNeeded()
                            view.alpha = 1
            }, completion:{action in
                view.tag = 0
            })
        }
    }
    
    public static func scaleHide(view:UIView){
        view.layoutIfNeeded()
        //當view只顯示在中間時
        let rect = CGRect(x: view.superview!.center.x * 2 - 25,
                          y: 50,
                          width: 0,
                          height: 0)
        startScaleHideAnimate(view: view, rect: rect)
    }
    
    private static func startScaleHideAnimate(view:UIView, rect:CGRect){
        
        if view.tag == 0 {
            view.tag = 99
            let originWidth = view.frame.width
            let originHeight = view.frame.height

            UIView.animate(withDuration: 0.5, delay: 0,usingSpringWithDamping: 0.6,
                               initialSpringVelocity: 0.0, options:[], animations: {
                                view.frame = rect
                                view.layoutIfNeeded()
                                view.alpha = 0
                }, completion:{ action in
                    view.frame.size.width = originWidth
                    view.frame.size.height = originHeight
                    view.tag = 0
                })
        }
    }
}





/*
 
 
 @objc func addTapped() {
     if viewIsHidden {
//            InfoDescripView.setUpView(on: (self.navigationController?.view)!)
         
         InfoDescripView.setUpView(on: view)
         addShowAnimation(targetVW: InfoDescripView.shared)
         viewIsHidden = false
       
     }else {
         addHidingAnimation(targetVW: InfoDescripView.shared)
         viewIsHidden = true
         
       
     }
 }
 
 func setUpInfoCardView() {
     let screenRect = UIScreen.main.bounds
     let screenWidth = screenRect.size.width
     let screenHeight = screenRect.size.height
     let navigY = navigationController?.navigationBar.center.y
     squareBlue.isHidden = false
     self.squareBlue.layer.cornerRadius = 0.2
     
     
//        addCenterdot(mainView:self.view)
     squareBlue.center = CGPoint(x: screenWidth - navigY! , y: navigY!)
//        squareBlue.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
     
     squareBlue.backgroundColor = UIColor.blue
  
     self.navigationController?.view.addSubview(squareBlue)

    
//        addLabel(mainView:squareBlue)
     
//        addAnimate ()
 }
 func addCenterdot(mainView:UIView) {
     let centerDot = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.0))
     centerDot.center = mainView.center
     centerDot.backgroundColor = UIColor.clear
     mainView.addSubview(centerDot)
    
 }
 func addLabel(mainView:UIView) {
     let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0))
     label.center = mainView.center
     label.text = "G"
     label.textColor = UIColor.black
     label.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
     mainView.addSubview(label)
 }
 
 func addShowAnimation(targetVW vw:UIView) {
     let screenRect = UIScreen.main.bounds
     let screenWidth = screenRect.size.width
     let screenHeight = screenRect.size.height
     let navigY = navigationController?.navigationBar.center.y
     let offset = CGPoint(x: screenWidth/2 - 25 , y: -screenHeight/2 + navigY!)
     let originalTransform = vw.transform
     let scaledTransform = originalTransform.translatedBy(x: offset.x, y: offset.y)
     let scaledAndTranslatedTransform = scaledTransform.scaledBy(x: 0.1, y: 0.1)
     vw.transform = scaledAndTranslatedTransform
     vw.isHidden = false
     vw.clipsToBounds = true
     UIView.animate(
         withDuration: 1.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 2,
         options: .curveEaseIn, animations: { [self] in
             vw.transform = .identity
             vw.alpha = 1
//                vw.layoutIfNeeded()
         })
     
 }
 
 func addHidingAnimation(targetVW vw:UIView) {
     let screenRect = UIScreen.main.bounds
     let screenWidth = screenRect.size.width
     let screenHeight = screenRect.size.height
     let navigY = navigationController?.navigationBar.center.y
     // Finally the animation!
     let offset = CGPoint(x: screenWidth/2 - 25 , y: -screenHeight/2 + navigY!)
     let originalTransform = vw.transform
     let scaledTransform = originalTransform.translatedBy(x: offset.x, y: offset.y)
     let scaledAndTranslatedTransform = scaledTransform.scaledBy(x: 0.1, y: 0.1)
     
     vw.isHidden = false
     vw.clipsToBounds = true
     
     UIView.animate(
         withDuration: 1.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 2,
         options: .curveEaseOut, animations: { [self] in
            
             vw.alpha = 1
             
             vw.transform = scaledAndTranslatedTransform
//                vw.layoutIfNeeded()
            
         })
     
 }
 
 
 
 // 右上至中間
 func recordXY() {
     let screenRect = UIScreen.main.bounds
     let screenWidth = screenRect.size.width
     let screenHeight = screenRect.size.height
     let navigY = navigationController?.navigationBar.center.y
     squareBlue.center = CGPoint(x: screenWidth/2 + 150 , y: navigY!)
     
     // 中間
     let offset = CGPoint(x: -view.center.x / 2 , y: view.center.y)
 }
 */
