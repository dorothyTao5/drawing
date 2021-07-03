//
//  OpenCloseTbvVC.swift
//  DrawingFor12-older
//
//  Created by dorothyLiu on 2021/7/2.
//

import UIKit

class OpenCloseTbvVC: UIViewController {

    @IBOutlet weak var tbv: UITableView!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var lcTbv_H: NSLayoutConstraint!
    
    var tbvModel = OpenCloseTbvModel()
    var btnControlModel = BtnControTbvModel()
    
  
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setupAppearence()
    }

    //MARK: - IBAction
    @IBAction func btnShowTbvPressed(_ sender: UIButton) {
        btnControlModel.detectExpenedOrShrinkTbv(btn: sender,
                                                 view: self.view,
                                                 tbvConstraint: lcTbv_H,
                                                 expendHeight: 300,
                                                 expendStr: "click to close tbv",
                                                 expend: {
                                                    btn.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                                                 },
                                                 shrinkHeight: 0,
                                                 shrinkStr: "click to Open tbv") {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
                btn.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner,.layerMinXMaxYCorner]
            }
        }
        
    }
    
    //MARK: - Functions
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
    }

}

//MARK: - UITableView
extension OpenCloseTbvVC: UITableViewDelegate, UITableViewDataSource {
    
    
    //MARK: - Section
      func numberOfSections(in tableView: UITableView) -> Int {
        return tbvModel.getNumberOfSections()
     }
    
    //MARK: - Row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tbvModel.getNumberOfRowsInSection(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        cell.lbTitle?.text = tbvModel.getCellTitle(indexPath: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    //MARK: - Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tbv.dequeueReusableHeaderFooterView(withIdentifier: "tbvHeaderView") as! tbvHeaderView
        
        headerView.contentView.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.9146896171, blue: 0.8012113608, alpha: 1)
        headerView.btn.tag = section
        headerView.btn.addTarget(self, action: #selector(self.handleExpandClose), for: .touchUpInside)
        let isOpen = tbvModel.arrData[section]["open"] as? Bool ?? false
        headerView.imgArrow.image = UIImage(named: (isOpen ? "arrowUp":"down-arrow"))
        headerView.lb.text =  tbvModel.arrData[section]["title"] as? String ?? ""
        
        return headerView
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
       return 44
   }
  
}
