

// in appDelegate
/*
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let styleArray = userDefaultLoadBool(key: .ThemeIsRed)
    if styleArray == true { //紅色主題
        Theme.current = RedTheme()
    }else{ //綠色主題
        Theme.current = BlueTheme()
    }
    
}
*/

import Foundation

class Theme {
//    static var current: ThemeProtocol = BlueTheme(){
//        didSet{
//            ThemeManager.shared.update()
//        }
//    }
}

//func getCurrentTheme() {
//    let styleArray = userDefaultLoadBool(key: .ThemeIsRed)
//    if styleArray == true { //紅色主題
//        Theme.current = RedTheme()
//    }else{ //綠色主題
//        Theme.current = BlueTheme()
//    }
//}


class ThemeManager{
//    private static let _shared = ThemeManager()
//    public static var shared: ThemeManager {
//        return _shared
//    }
    
    //MARK: - 列管所有更換風格的VC
    
//    static var settingVC: SettingVC?{
//        didSet{
//            ThemeManager.settingVC?.lb.textColor = Theme.current.mainColor
//            ThemeManager.settingVC?.vTitleLine.backgroundColor = Theme.current.mainColor
//            ThemeManager.settingVC?.imvBack.image = Theme.current.imgBack
//        }
//    }
    
    
//    static var menuVC: MenuVC?{
//        didSet{
//            ThemeManager.menuVC?.arrItems = Theme.current.menuCVItems
//            ThemeManager.menuVC?.cv.reloadData()
//            ThemeManager.menuVC?.btnClose.setImage(Theme.current.imgClose, for: .normal)
//        }
//    }
    
//    static var warningViewController: WarningViewController?{
//        didSet{
//
//
//        }
//    }
    
    //MARK: - 列管所有更換風格的VC
    
    func update(){
        /// - tag: SettingVC
//        ThemeManager.settingVC?.lb.textColor = Theme.current.mainColor
//        ThemeManager.settingVC?.vTitleLine.backgroundColor = Theme.current.mainColor
//        ThemeManager.settingVC?.imvBack.image = Theme.current.imgBack
        
        /// - tag: MenuVC
//        ThemeManager.menuVC?.arrItems = Theme.current.menuCVItems
//        ThemeManager.menuVC?.cv.reloadData()
//        ThemeManager.menuVC?.btnClose.setImage(Theme.current.imgClose, for: .normal)
        
    }
    
    
    
    
}


