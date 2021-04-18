//
//  ViewController.swift
//  DrawingFor12-older
//
//  Created by 2010011NB01 on 2021/1/8.
//
//youtube link: https://www.youtube.com/watch?v=kAiknPhkWmc

// To Do List：
/// - tag:  1- 點擊view 取消編輯模式 【叉叉 isHiden = true】
/// - tag:  2- 編輯文字時， 當前label ishiden = true， editVC 半透明 進入編輯樣子， 參考ig
/// - tag:  3- 一進入畫面defaul顏色全調整成黑色
/// - tag:  4- 背景img可以從photo library 選擇

///  *****選擇*****
///新增分享功能
///字型選擇
///有文字底色


import UIKit

class DrawingVC: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var textEditorView: UIView!
    @IBOutlet weak var containerBtmConstrain: NSLayoutConstraint!
    @IBOutlet weak var imgButton: UIImageView!
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var canvasView: CanvasView!
    @IBOutlet var featuresView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnHex: UIButton!
    
    @IBOutlet weak var widthSlider: UISlider!
    @IBOutlet weak var opacitySlider: UISlider!
    
    @IBOutlet weak var viewHexColorBG: UIView!
    //輸入hex顏色
    @IBOutlet weak var textField: UITextField!{
        didSet {
            ///添加textfield Toolbar
            textField.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneButtonTappedForMyNumericTextField)), onCancel: ( target: self, action: #selector(cancelButtonTappedForMyNumericTextField)))
        }}
    
    ///hexView右下角Hex按鈕
    ///一進畫面定位viewHexColor 最高 最低 定位位置
    var hexViewUp: CGPoint! = CGPoint(x: 228.0 ,y: 616.5 )
    var hexViewDown: CGPoint!  = CGPoint(x: 228.0 ,y: 700.5 )
    var trayOriginalCenter: CGPoint! = CGPoint(x: 228.0 ,y: 616.5 )
    var movedPosition :CGPoint!
    
    ///text Label 相關
    var orderLb = 0
    var dicLabel : [Int : [Any]] = [:]
    var editModeOn = false
    
    
    var arrColors: [UIColor] = [#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
    var currentColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    ///originalFrame：不遮擋輸入框 紀錄輸入框原本位置
    var originalFrame : CGRect?
    
    
    
    //MARK: - *LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViewHexColorBG()
        setUpInitColor(color: #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1))// slider *2
        doubleTapEvent(view: canvasView)
        self.textField.delegate = self
       
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
      
        
    }
    
    //    MARK:- IBAction Gesture
    ///拖動viewHexColor動畫
    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
        GesturesAnimationUtil.upAndDown(sender,
                                in: view,
                                trayOriginalCenter: &trayOriginalCenter,
                                viewBG: viewHexColorBG,
                                targetBtn: btnHex,
                                trayUp: hexViewUp,
                                trayDown: hexViewDown)
    }
 
  
    
    
    //    MARK:- IBAction
    @IBAction func btnAddTextPressed(_ sender: UIButton) {
        
        let vc = EditTextVC()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func btnPreviewPressed(_ sender: UIButton) {
        HapticsUtil.feedbackMedium()
        hideHexView()
        
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "PreviewImgVC") as! PreviewImgVC
        vc.img = ImageUtil.mergeTwoImg(targetView: canvasView, imgButtom: img)
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
   
    
    //MARK: - 顏色工具欄
    
    @IBAction func onClickSave(_ sender: Any) {
        
        HapticsUtil.feedbackMedium()
        
        let imgMerged = ImageUtil.mergeTwoImg(targetView: canvasView, imgButtom: img)
        UIImageWriteToSavedPhotosAlbum(imgMerged, self, #selector(imageSaved(_:didFinishSavingWithError:contextType:)), nil)
        
    }
    
    @objc func imageSaved(_ image: UIImage, didFinishSavingWithError error: Error?, contextType: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    
    @IBAction func onClickUndo(_ sender: Any) {
        HapticsUtil.feedbackMedium()
        canvasView.undoDraw()
    }
    
    
    @IBAction func onClickClear(_ sender: Any) {
        HapticsUtil.feedbackMedium()
        canvasView.clearCanvasView()
    }
  
    // 點擊顯示Hex 輸入框
    @IBAction func onClickHideShowFeatureView(_ sender: UIButton) {

        if sender.tag == 0 {
            sender.tag = 1
            self.viewHexColorBG.isHidden = false
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                self.viewHexColorBG.center = self.hexViewUp
           })
            
        }else {
            sender.tag = 0
            
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                self.viewHexColorBG.center = self.hexViewDown
           })
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.viewHexColorBG.isHidden = true
            }
            
        }
    }
    
    @IBAction func onClickBrushWidth(_ sender: UISlider) {

        canvasView.strokeWidth = CGFloat(sender.value)

    }
    
    @IBAction func onClickOpacity(_ sender: UISlider) {
        canvasView.strokeOpacity = CGFloat(sender.value)
        opacitySlider.tintColor = currentColor.withAlphaComponent(CGFloat( opacitySlider.value))
    }
    
    
    //    MARK:- *textField
    
    @IBAction func textFieldPressed(_ sender: UITextField) {
        textField.text = ""
    }
    
    ///HexColor輸入欄位的Undo
    @IBAction func btnOKPressed(_ sender: Any) {
        //btn 觸發btn
//        self.onClickUndo(self)
//        let newImageWithOverlay = UIImage.createImageWithLabelOverlay(label: lbText, imageSize: CGSize(width: 100, height: 100), image: imgButton.image!)

    }
    
    @objc func doneButtonTappedForMyNumericTextField() {
        if let str = textField.text, str.count == 6 {
            let colorStr = "#" + (self.textField.text ?? "FFFFFF")
            currentColor = hexStringToUIColor(hex: colorStr)
            canvasView.strokeColor = currentColor
            hideHexView()
        }else {
            AlertViewUtil.show(vc: self, message: "請確認是否為6位字元或按Cancel離開")
        }
        textField.resignFirstResponder()
    }
    
    @objc func cancelButtonTappedForMyNumericTextField() {
        hideHexView()
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
//        txtFieldTitle.endEditing(true)
//        txtFieldTitle.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
//        txtFieldTitle.borderStyle = .none
        return false
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        //https://stackoverflow.com/questions/24263007/how-to-use-hex-color-values?page=1&tab=votes#tab-top
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    //MARK: - *functions
    func hideHexView(){
        btnHex.tag = 0
        viewHexColorBG.isHidden = true
    }
    
    func setUpViewHexColorBG() {
        viewHexColorBG.layer.cornerRadius = 9
        viewHexColorBG.isHidden = true
    }
    
    func setUpInitColor(color: UIColor) {
        currentColor = color
        widthSlider.tintColor = currentColor
        opacitySlider.tintColor = currentColor.withAlphaComponent(CGFloat( opacitySlider.value))
        canvasView.strokeColor = currentColor
    }
    

    //MARK: - * keyboard @objc func
    @objc func keyboardWillAppear(notification : Notification)  {
        let info = notification.userInfo!
        let currentKeyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        let duration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        let textFrame = self.viewHexColorBG.window!.convert(self.textField.frame, from: self.viewHexColorBG)
        var visibleRect = self.viewHexColorBG.frame;
        if self.originalFrame == nil {
            self.originalFrame = visibleRect
        }
        if (  textFrame.maxY > currentKeyboardFrame.minY ) {
            let difference = textFrame.maxY - currentKeyboardFrame.minY
            visibleRect.origin.y = visibleRect.origin.y - difference
            UIView.animate(withDuration: duration) {
                self.viewHexColorBG.frame = visibleRect
            }
        }
    }
    
    @objc func keyboardWillHide(notification : Notification)  {
        //        let info = notification.userInfo!
        UIView.animate(withDuration: 0.5) {
//            self.viewHexColorBG.frame = self.originalFrame!
        }
    }
    
    
}


//MARK:- *extension CollectionView
extension DrawingVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrColors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let view = cell.viewWithTag(111) {
            view.layer.cornerRadius = 3
            view.backgroundColor = arrColors[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        HapticsUtil.feedbackMedium()
        setUpInitColor(color: arrColors[indexPath.row])
    }
    
}

//MARK: - *EditTextVCDelegate

extension DrawingVC : EditTextVCDelegate {
    
    func updateGestureLabel(toText: String, lbTag: Int) {
        updateLabel(toText: toText, lbTag: lbTag)
    }
    
    func didFinishAddText(str: String) {
        createOneGestureLabel(withText: str)
    }
    
}



