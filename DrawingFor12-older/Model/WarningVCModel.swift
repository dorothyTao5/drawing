

import Foundation
import UIKit

struct CusCellCorModel {
    let lbCar: UIColor?
    let bgCor: UIColor?
}

struct WarningModel {
   
    //MARK: - Variables
   
    var arrWarningList: [[String:Any]] =
        [
            ["title":"sampleTitleOne",
             "data":["5","10","15","20","25","30","35","40","45","50"],
             "warningType":"dbz"],
            ["title":"sampleTitleTwo" ,
             "data":["0.5","1","5","10","15","20","30","50","70","100"],
             "warningType":"rain01"],
            ["title":"sampleTitleThree",
             "data":[],
             "warningType":"dbz"],
            ["title":"sampleTitleFour",
             "data":[],
             "warningType":"dbz"]
        ]
    
    var selectedCellIndex:Int?

   
    
    //MARK: - *Functions
    
    func getNextPageData() -> [String] {
        var dicStr : [String] = []
        arrWarningList.forEach { dic in
            let str = dic["title"]
            dicStr.append(str as! String)
        }
        
        return dicStr
    }
    
    ///進入警戒VC 如果warning type有值 就要給selectedCellIndex值
    func getSavedSelectedCellIndex(titleStr: String, valueStr: String) -> Int {
        let index = getDataIndexByComparWithStr(titleStr: titleStr, compairedStr: valueStr)
        return index
    }
    
    //MARK: - *Func CV numberOfItemsInSection
    func getCVItemsCount(title str:String) -> Int {
        let dic = getCellListDic(compairWithStr: str)
        let arr = dic["data"] as! [String]
        let count = arr.count
        
        return count
    }
    
    //MARK: - *Func CV CellForItemAt
    func getCellText(selectedTitle:String, indexPath: IndexPath) -> String {
        let dic = getCellListDic(compairWithStr: selectedTitle)
        let arr = dic["data"] as! [String]
        let str = arr[indexPath.row]
        return str
    }
    
    func getCellBgColor(selectedTitle:String, indexPath: IndexPath) -> UIColor{
        let arrCor = getCellColorArr(compairWithStr: selectedTitle, indexPath: indexPath)
        return arrCor.bgCor!
    }
 
    func getCellTextColor(selectedTitle:String, indexPath: IndexPath) -> UIColor{
        let arrCor = getCellColorArr(compairWithStr: selectedTitle, indexPath: indexPath)
        return arrCor.lbCar!
    }
    
    func getCellBorderCor(indexpath:IndexPath, titleStr: String) -> CGColor {
        if selectedCellIndex == nil {
            let index = getDataIndexByComparWithStr(titleStr: titleStr, compairedStr: "50")
            let strRadar = arrWarningList[0]["title"] as! String
            let strOneHrRainfall = arrWarningList[1]["title"] as! String
            var defaultBorderCol:CGColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            
            ///如果是"回波值" or "1小時雨量(mm)"，// default value 為 50
            if titleStr == strRadar || titleStr == strOneHrRainfall {
                defaultBorderCol = getColByDetectIndex(indexpath: indexpath, compairedNum: index)
                return defaultBorderCol
            }
            return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            
        }else {
            let col = getColByDetectIndex(indexpath: indexpath, compairedNum: selectedCellIndex!)
            return col
        }
    }
    
   
    //MARK: - *Func CV didSelectItemAt
    func getWarningTypeStr(of title: String) -> String {
        let dic = getCellListDic(compairWithStr: title)
        let str = dic["warningType"] as! String
        return str
       
    }
    
    ///對比數字找出compairedStr 在arrWarningList[0]["data"] 中是第幾個位子
    func getDataIndexByComparWithStr(titleStr: String, compairedStr: String) -> Int {
        let dic = getCellListDic(compairWithStr: titleStr)
        let arr = dic["data"] as! [String]
        var index = 0
        for i in 0..<arr.count {
            if arr[i] == compairedStr {
                index = i
                break
            }
        }
        return index
    }
    
    func getWarningValue(of title: String, indexpath: IndexPath)-> String {
        let dic = getCellListDic(compairWithStr: title)
        let arr = dic["data"] as! [String]
        let str = arr[indexpath.row]
        return str
        
    }
    
    
    //MARK: - *Func CV layout
    func getCellWidthHeight(collectionView: UICollectionView,  currentCVW : CGFloat) -> CGSize {
        var width : Double = 0
        let height = Double( (collectionView.frame.height - 10) / 2)

        if UIDevice.current.orientation.isLandscape {
            width = Double( (currentCVW  - 140)  /  5 )
            
        } else {
            width = Double( (currentCVW  - 60) / 5 )
        }
        
        return CGSize(width: width, height: height)
    }
    
    func getLcCvHeight(indexpath:Int) -> CGFloat {
        let arrData = arrWarningList[indexpath]["data"] as! [String]
        if arrData.count == 0 {
            return 15
        }else {
            return 110
        }
    }
    
    
    
    //MARK: - private funcs for CV
    ///cell 的indexpath.row 等於我們要的compairedNum 才設定border color 為黑色
    private func getColByDetectIndex(indexpath:IndexPath, compairedNum: Int) -> CGColor {
        if indexpath.row == compairedNum {
            return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }else {
            return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        }
    }
    
    private func getCellListDic(compairWithStr str: String ) -> [String:Any]{
        var dicData:[String:Any] = [:]
        arrWarningList.forEach { dic in
            if dic["title"] as! String == str {
                dicData = dic
            }
        }
        return dicData
    }
   
    private func getCellColorArr(compairWithStr str: String, indexPath: IndexPath ) -> CusCellCorModel {
        switch str {
        case "sampleTitleOne":
            // 回波值
            return radarValueColor(indexPath: indexPath)
            
        case "sampleTitleTwo":
            // "1小時雨量(mm)"
            return oneHrRainfallColor(indexPath: indexPath)
            
        default:
            return oneHrRainfallColor(indexPath: indexPath)
        }
    }
    
    /// arr = cell 的背景顏色以及數字的lb顏色
    /// Radar Value 回波值
    private func radarValueColor(indexPath: IndexPath) -> CusCellCorModel { // 回波值
        switch indexPath.row {
        case 0,1,2:
            return CusCellCorModel(lbCar: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), bgCor: #colorLiteral(red: 0.8897684216, green: 0.894185245, blue: 0.8940454125, alpha: 1))
        case 3,4,5:
            return CusCellCorModel(lbCar: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), bgCor: #colorLiteral(red: 0.2989208698, green: 0.5226628184, blue: 0.1880151331, alpha: 1))
        case 6,7,8:
            return CusCellCorModel(lbCar: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), bgCor: #colorLiteral(red: 0.9279792309, green: 0.7068830729, blue: 0, alpha: 1))
        case 9:
            return CusCellCorModel(lbCar: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), bgCor: #colorLiteral(red: 0.9801701903, green: 0, blue: 0, alpha: 1))
        default:
            print("radarValueColor got error")
            return  CusCellCorModel(lbCar: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), bgCor: #colorLiteral(red: 0.8897684216, green: 0.894185245, blue: 0.8940454125, alpha: 1))
        }
    }
    /// "1小時雨量(mm)"
    private func oneHrRainfallColor(indexPath: IndexPath) -> CusCellCorModel { /// 1小時雨量(mm)
        switch indexPath.row {
        case 0,1:
            return CusCellCorModel(lbCar: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), bgCor: #colorLiteral(red: 0.8897684216, green: 0.894185245, blue: 0.8940454125, alpha: 1))
        case 2,3,4:
            return CusCellCorModel(lbCar: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), bgCor: #colorLiteral(red: 0.2989208698, green: 0.5226628184, blue: 0.1880151331, alpha: 1))
        case 5,6,7:
            return CusCellCorModel(lbCar: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), bgCor: #colorLiteral(red: 0.9279792309, green: 0.7068830729, blue: 0, alpha: 1))
        case 8,9:
            return CusCellCorModel(lbCar: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), bgCor: #colorLiteral(red: 0.9801701903, green: 0, blue: 0, alpha: 1))
        default:
            print("oneHrRainfallColor got error")
            return CusCellCorModel(lbCar: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), bgCor: #colorLiteral(red: 0.8897684216, green: 0.894185245, blue: 0.8940454125, alpha: 1))
        }
    }
 


//MARK: - 以下保留給【警戒半徑】使用
    ///reset btn status to unclicked
    func setupUIView01ButtonsColor(_ arrRadBtns:[UIButton],_ arrRain01HBtns:[UIButton],_ arrConvectiveCellBtns:[UIButton]) {
        for btn in arrRadBtns {
            setBtnBorder(btn: btn, color:  #colorLiteral(red: 0.9936305732, green: 1, blue: 1, alpha: 0))
        }
        for btn in arrRain01HBtns {
            setBtnBorder(btn: btn, color:  #colorLiteral(red: 0.8893331885, green: 0.8925911188, blue: 0.8926478028, alpha: 0))
        }
        for btn in arrConvectiveCellBtns {
            setBtnBorder(btn: btn, color:  #colorLiteral(red: 0.8893331885, green: 0.8925911188, blue: 0.8926478028, alpha: 0))
        }
    }
    
    func setBtnBorder(btn: UIButton, color: UIColor) {
        btn.clipsToBounds = true
        btn.layer.borderWidth = 4
        btn.layer.borderColor = color.cgColor
    }
    
    


}
