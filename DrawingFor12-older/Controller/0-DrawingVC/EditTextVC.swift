//
//  EditTextVC.swift
//  DrawingFor12-older
//
//  Created by dorothyLiu on 2021/4/12.
//

import UIKit


protocol EditTextVCDelegate {
    func didFinishAddText(str :String)
    func updateGestureLabel(toText :String, lbTag: Int)

}


class EditTextVC: UIViewController {

    var delegate : EditTextVCDelegate!
    var str = ""
    var tagLabel = 0
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        textField.text = str
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    
//MARK: - IBAction
    
    @IBAction func btnBackPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
   
    @IBAction func btnDonePressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        if tagLabel != 0 {
            self.delegate.updateGestureLabel(toText: textField.text ?? "",lbTag: tagLabel )
        }else {
            self.delegate.didFinishAddText(str: textField.text ?? "" )
        }
        
    }
    
    

}


extension UINavigationController {
  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
      popToViewController(vc, animated: animated)
    }
  }
}
