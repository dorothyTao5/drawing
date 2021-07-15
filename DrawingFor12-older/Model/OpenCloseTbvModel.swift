//
//  OpenCloseTbvModel.swift
//  DrawingFor12-older
//
//  Created by dorothyLiu on 2021/7/2.
//

import Foundation
import UIKit

struct BtnControTbvModel{
    var showTbv = false

    
    mutating func detectExpenedOrShrinkTbv( btn:UIButton, view:UIView, tbvConstraint:NSLayoutConstraint, expendHeight:CGFloat, expendStr:String, expend:()->(), shrinkHeight:CGFloat, shrinkStr:String, shrink:()->()){
        if showTbv == false{
            btn.clipsToBounds = true
            btn.layer.cornerRadius = 10
            btn.setTitle(expendStr, for: .normal)
            showTbv = true
            UIView.animate(withDuration: 0.5) {
                tbvConstraint.constant = expendHeight
                view.layoutIfNeeded()
            }
            expend()
        }else{
            btn.clipsToBounds = true
            btn.layer.cornerRadius = 10
            btn.setTitle(shrinkStr, for: .normal)
            showTbv = false
            UIView.animate(withDuration: 0.5) {
                tbvConstraint.constant = shrinkHeight
                view.layoutIfNeeded()
            }
           
            shrink()
        }
    }
    
    
    mutating func detectExpenedOrShrinkTbv(expend:()->(), shrink:()->()){
        if showTbv == false{
            showTbv = true
            expend()

        }else{
            showTbv = false
            shrink()

        }
    }
    
    // tbv.reloadData() to uadate UI after call this func
    mutating func setSectionExpenedDataAsFalse(arr: [[String: Any]]) -> [[String: Any]]{
        var temarr = arr
        for i in 0..<temarr.count{
            var isOpen = temarr[i]["open"] as! Bool
            if isOpen == true {
                isOpen = !isOpen
            }
            temarr[i]["open"] = isOpen
        }
        return temarr
    }
    
    
}


struct OpenCloseTbvModel {
//    api: OpenCloseTbvModel.arrData = apiarr
    var arrData : [[String: Any]] =
        [
            ["title":"水",
             "content":["淡水1","海水2","自來水3","山泉水4"],
             "open":false],
            ["title":"書",
             "content":["工具書","教科書","漫畫書"],
             "open":false],
            ["title":"公司",
             "content":["PP","果思"],
             "open":false]
        ]
    

    //MARK: - TableView Funcs
    func getNumberOfSections() -> Int {
        let count = arrData.count
        return count
    }
    
    func getNumberOfRowsInSection(at section: Int) -> Int {
        let open = arrData[section]["open"] as? Bool ?? true
        let arr = arrData[section]["content"] as! [String]
        if !open {
            return 0
        }else {
            return arr.count
        }
    }
    
    func getCellTitle(indexPath: IndexPath) -> String {
        let cellArr = arrData[indexPath.section]["content"] as! [String]
        let str = cellArr[indexPath.row]
        return str
    }
   
    
    
}
