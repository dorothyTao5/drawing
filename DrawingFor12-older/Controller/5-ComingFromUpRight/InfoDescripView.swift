//  Created by dorothyLiu on 2021/1/27.
//

import UIKit

class InfoDescripView: UIView {
    
    private static let _shared =  Bundle.main.loadNibNamed("InfoDescripView", owner: self, options: nil)?[0] as? InfoDescripView
    public static var shared: InfoDescripView {
        return _shared!
    }
    
    @IBOutlet weak var textView: UITextView!
    
    
    override public func awakeFromNib() {

        //設定圓角
        self.layer.cornerRadius = 22
        
        customizeTextView(for: textView)
       
        
    }
    
    
    //MARK: - IBAction
    @IBAction func btnDismissPressed(_ sender: UIButton) {
        AnimationUtil.scaleHide(view: self)
//        AnimationUtil.scaleHide(view: self)
//        DarkBGView.dismissView()
       
    }
    
  
    //MARK: - 建立 View
    static func setUpView( on view:UIView){
        view.addSubview(InfoDescripView.shared)
        InfoDescripView.shared.frame = CGRect(x: 0, y: 0, width: 300, height: 200)
        InfoDescripView.shared.center = view.center
        InfoDescripView.shared.alpha = 1
    }
    
    static func dismissView( on view:UIView) {
        
    }
    
    //MARK: - Functions
    func customizeTextView (for textView : UITextView) {
        //設定文字與textView邊框距離
        textView.textContainerInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        //設定圓角
        textView.clipsToBounds = true
        textView.layer.cornerRadius = 20
        textView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    

}


