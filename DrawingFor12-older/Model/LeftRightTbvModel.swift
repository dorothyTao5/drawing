//
//  LeftRightTbvModel.swift
//  DrawingFor12-older
//
//  Created by dorothyLiu on 2021/7/4.
//

import UIKit

struct LeftRightTbvModel {
    var arrData = ["First","Second","Third"]
    
    //detect arr total count，return +1 current index
    func increaseIndexPressed(arrCount: Int, currentIndex: inout Int) {
        let dataCount = arrCount - 1
        if currentIndex < dataCount {
            currentIndex += 1
        }else {
            currentIndex = 0
        }
    }
    
    //detect arr total count，return -1 current index
    func decreaseIndexPressed(arrCount: Int, currentIndex: inout Int) {
        let dataCount = arrCount - 1
        if currentIndex > 0 {
            currentIndex -= 1
        }else {
            currentIndex = dataCount
        }
    }
    
    //UITableView.RowAnimation
    func animateForTitleTbv(tbv:UITableView, animation: UITableView.RowAnimation, row: Int, section: Int){
        var indexPathsToReload = [IndexPath]()
        let indexPathToDelete = IndexPath(row: row, section: section)
        indexPathsToReload.append(indexPathToDelete)
        let animationStyle = animation
        tbv.reloadRows(at: indexPathsToReload, with: animationStyle)
    }
    
}
