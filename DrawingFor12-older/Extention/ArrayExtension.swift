//
//  ArrayExtension.swift
//  DrawingFor12-older
//
//  Created by dorothyLiu on 2021/4/10.
//

import Foundation

// array 不改變順序 抽調重複的值
extension Array where Element: Hashable {
    
    // 使用：
    // newArr = oldArr.uniques
    var uniques: Array {
        var buffer = Array()
        var added = Set<Element>()
        for elem in self {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }
    
    
}
