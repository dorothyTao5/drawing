//
//  ViewController.swift
//  FakeMoveSection
//
//  Created by 劉爾婷 on 2020/10/16.
//

import UIKit

class SettingVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var SectionTVCellID = "SectionTVCell"
    let userDefaultKey = "saveReorderedArray"
    
   var sectionOneArray = ["SectionOne【cannot reorder】","SectionTwo【cannot reorder】"]
    var sectionTwoArray = [
                            ["SectionA-4 reorderable ", "a1","a2","a3","a4"],
                            ["SectionB-3 reorderable ","b1", "b2","b3"],
                            ["SectionC-2 reorderable  ","c1","c2"],
                            ["SectionD-1 reorderable  ","d1"],
                                ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.isEditing = true
        tableView.register(UINib.init(nibName: SectionTVCellID, bundle: nil), forCellReuseIdentifier: SectionTVCellID)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorColor = UIColor.clear
        
        let saveWholeTVDataArray = UserDefaults.standard.object(forKey:userDefaultKey)
        
        if(saveWholeTVDataArray != nil) {
            sectionTwoArray = saveWholeTVDataArray as! [[String]]
        }
        
    }
    
}

extension SettingVC: UITableViewDataSource, UITableViewDelegate {
    
//    不顯示刪除按鈕
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
// Change default reorder icon in UITableViewCell
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let imageView = cell.subviews.first(where: { $0.description.contains("Reorder") })?.subviews.first(where: { $0 is UIImageView }) as? UIImageView
        imageView?.image = UIImage(named: "your_custom_reorder_icon.(empty)")
        
        imageView?.frame.size = .zero
    }
    
    
// MARK:- TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            print("sectionOneArray.count \(sectionOneArray.count)")
            return sectionOneArray.count
        case 1:
            print("wholeTVDataArray.count \(sectionTwoArray.count)")
            return sectionTwoArray.count
        default : fatalError()
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SectionTVCellID, for: indexPath) as! SectionTVCell
        
        switch indexPath.section {

        case 0 :
            cell.selectionStyle = .none
            cell.lbSectionTitle.text = sectionOneArray[indexPath.row]
            
        case 1:
//        Section title
        cell.selectionStyle = .none
        cell.lbSectionTitle.text = sectionTwoArray[indexPath.row][0]
        
//        客製化reorder sign
        let imgReorder = UIImage(named: "burger")
        let reorderview = UIImageView(image: imgReorder)
        reorderview.frame = CGRect(x: view.frame.width-40, y: 5, width: 40, height: 40)
        cell.addSubview(reorderview)
        
//        畫section部分的底線
        let cellBottomLine = UIView(frame: CGRect(x: view.frame.width-45, y: CGFloat((Double(49))), width: 52, height: 0.5))
        cellBottomLine.backgroundColor = #colorLiteral(red: 0.8541176915, green: 0.8542615175, blue: 0.8540987968, alpha: 1)
        cell.addSubview(cellBottomLine)
        
//        加入Xib View
        let arrayCount = sectionTwoArray[indexPath.row].count
        
        for xibOrder in 1..<arrayCount {

            let xibView3 = XibViewForCell (frame: CGRect(x: 0, y: xibOrder*50+1, width: Int(view.frame.width), height: 50))
            xibView3.lbCellItem.text = "you got \(sectionTwoArray[indexPath.row][0])-- \(sectionTwoArray[indexPath.row][xibOrder])"
            cell.addSubview(xibView3)
        }
        default:
            fatalError()
        }
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let movedItem = sectionTwoArray[sourceIndexPath.row]
        
        sectionTwoArray.remove(at: sourceIndexPath.row)
        sectionTwoArray.insert(movedItem, at: destinationIndexPath.row)
        
        DispatchQueue.main.async {
            tableView.reloadData()
        }
        
        UserDefaults.standard.set(self.sectionTwoArray, forKey: userDefaultKey )
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
       
        switch indexPath.section {
        case 0:
            return false
        case 1:
            return true
        default:
            fatalError()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 50
        case 1:
            return CGFloat(Double(sectionTwoArray[indexPath.row].count*50)+0.5)
        default:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        
        if sourceIndexPath.section != proposedDestinationIndexPath.section {
            var row = 0
            if sourceIndexPath.section < proposedDestinationIndexPath.section {
                row = self.tableView(tableView, numberOfRowsInSection: sourceIndexPath.section) - 1
            }

            return IndexPath(row: row, section: sourceIndexPath.section)
        }
        return proposedDestinationIndexPath
    }
    
}
