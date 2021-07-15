//
//  OpenCloseTbvVC.swift
//  DrawingFor12-older
//
//  Created by dorothyLiu on 2021/7/2.
//

import UIKit

class OpenCloseTbvVC: UIViewController {

    
    @IBOutlet weak var tbvTitle: UITableView!
    @IBOutlet weak var vwLeftBtn: UIView!
    @IBOutlet weak var vwRightBtn: UIView!
    
    @IBOutlet weak var tbv: UITableView!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var lcTbv_H: NSLayoutConstraint!
    
    var titleTbvModel = LeftRightTbvModel()
    var tbvModel = OpenCloseTbvModel()
    var btnControlModel = BtnControTbvModel()
    
    var titleIndex = 0
    var strOpenTbvTitle = "click to Close tbv first"
    var strCloseTbvTitle = "click to Open tbv first"
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTitleTBView()
        setUpTableView()
        setupAppearence()
    }

    //MARK: - IBAction
    @IBAction func btnShowTbvPressed(_ sender: UIButton) {
        btnControlModel.detectExpenedOrShrinkTbv(btn: sender,
                                                 view: self.view,
                                                 tbvConstraint: lcTbv_H,
                                                 expendHeight: 300,
                                                 expendStr: strOpenTbvTitle,
                                                 expend: {
                                                    btn.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                                                    
                                                 },
                                                 shrinkHeight: 0,
                                                 shrinkStr: strCloseTbvTitle) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
                btn.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner,.layerMinXMaxYCorner]
                tbvModel.arrData = btnControlModel.setSectionExpenedDataAsFalse(arr: tbvModel.arrData)
                tbv.reloadData()
            }
        }
    }
    
    @IBAction func btnTitleRightPressed(_ sender: UIButton) {
        let dataCount = titleTbvModel.arrData.count 
        titleTbvModel.increaseIndexPressed(arrCount: dataCount, currentIndex: &titleIndex)
        changeTbvTitleLabel()
        tbvModel.arrData = btnControlModel.setSectionExpenedDataAsFalse(arr: tbvModel.arrData)
        tbv.reloadData()
    }
   
    @IBAction func btnLeftPressed(_ sender: UIButton) {
        let dataCount = titleTbvModel.arrData.count 
        titleTbvModel.decreaseIndexPressed(arrCount: dataCount, currentIndex: &titleIndex)
        changeTbvTitleLabel()
        tbvModel.arrData = btnControlModel.setSectionExpenedDataAsFalse(arr: tbvModel.arrData)
        tbv.reloadData()
    }
    
    
   
    //MARK: - Functions
    func setUpTitleTBView() {
        tbvTitle.dataSource = self
        tbvTitle.delegate = self
        tbvTitle.register(UINib(nibName: "TitleTbvCell", bundle: nil),
                     forCellReuseIdentifier: "TitleTbvCell")
        tbvTitle.sectionFooterHeight = 0
        tbvTitle.sectionHeaderHeight = 0
    }
    
    func setUpTableView() {
        tbv.dataSource = self
        tbv.delegate = self
        tbv.register(UINib(nibName: "TableViewCell", bundle: nil),
                     forCellReuseIdentifier: "TableViewCell")
        tbv.register(UINib(nibName: "tbvHeaderView", bundle: nil),
                     forHeaderFooterViewReuseIdentifier: "tbvHeaderView")
        tbv.tableFooterView?.isHidden = true
        tbv.sectionFooterHeight = 0
    }
     
    func setupAppearence() {
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 10
        btn.setTitle(strCloseTbvTitle, for: .normal)
        //圓角
        vwRightBtn.clipsToBounds = true
        vwRightBtn.layer.cornerRadius = 22
        vwRightBtn.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        vwLeftBtn.clipsToBounds = true
        vwLeftBtn.layer.cornerRadius = 22
        vwLeftBtn.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
    }
    
    func changeTbvTitleLabel() {
        titleTbvModel.animateForTitleTbv(tbv: tbvTitle, animation:  UITableView.RowAnimation.left, row: 0, section: 0)
        if btnControlModel.showTbv == true {
            strOpenTbvTitle = "click to close tbv \(titleTbvModel.arrData[titleIndex])"
            btn.setTitle(strOpenTbvTitle, for: .normal)
        }else {
            strCloseTbvTitle = "click to Open tbv \(titleTbvModel.arrData[titleIndex])"
            btn.setTitle(strCloseTbvTitle, for: .normal)
        }
    }
   

}

//MARK: - UITableView
extension OpenCloseTbvVC: UITableViewDelegate, UITableViewDataSource {
    
    
    //MARK: - Section
      func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == tbvTitle {
            return 1
        }else {
            return tbvModel.getNumberOfSections()
        }
      }
    
    //MARK: - Row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tbvTitle {
            return 1
        }else {
            return tbvModel.getNumberOfRowsInSection(at: section)
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tbvTitle {
            let titleCell = tbvTitle.dequeueReusableCell(withIdentifier: "TitleTbvCell", for: indexPath) as! TitleTbvCell
            titleCell.lb.text = titleTbvModel.arrData[titleIndex]
            titleCell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            return titleCell
            
        }else {
            let cell = tbv.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
            cell.lbTitle?.text = tbvModel.getCellTitle(indexPath: indexPath)
            
            return cell
        }
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    //MARK: - Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == tbv {
            let headerView = tbv.dequeueReusableHeaderFooterView(withIdentifier: "tbvHeaderView") as! tbvHeaderView
            
            headerView.contentView.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.9146896171, blue: 0.8012113608, alpha: 1)
            headerView.btn.tag = section
            headerView.btn.addTarget(self, action: #selector(self.handleExpandClose), for: .touchUpInside)
            let isOpen = tbvModel.arrData[section]["open"] as? Bool ?? false
            headerView.imgArrow.image = UIImage(named: (isOpen ? "arrowUp":"down-arrow"))
            headerView.lb.text =  tbvModel.arrData[section]["title"] as? String ?? ""
            return headerView
        }else {
            return nil
        }
        
        
    }
    
    //點擊header展開或收起tableview section
    @objc func handleExpandClose(button: UIButton) {
//        print("btn.tag:", button.tag)
        let section = button.tag
        var indexPaths = [IndexPath]()
        let dataArr = tbvModel.arrData[section]["content"] as! [String]

        for row in dataArr.indices {
            let indexPathToDelete = IndexPath(row: row, section: section)
            indexPaths.append(indexPathToDelete)
        }
//        print(indexPaths)
        var isOpen = tbvModel.arrData[section]["open"] as! Bool
        isOpen = !isOpen
        tbvModel.arrData[section]["open"] = isOpen

        if isOpen {
            self.tbv.insertRows(at: indexPaths, with: .fade)
        }else {
            self.tbv.deleteRows(at: indexPaths, with: .fade)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.tbv.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == tbv {
            return 44
        }else {
            return 0
        }
   }
  
}
