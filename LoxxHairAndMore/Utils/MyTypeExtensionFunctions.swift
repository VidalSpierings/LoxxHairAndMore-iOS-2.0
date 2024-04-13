import UIKit
import MMDrawerController

infix operator |: AdditionPrecedence
public extension UIColor {
    
    // lightMode variable controls color for light mode,
    // darkMode variable controlers color for dark mode
    
    // following is an example of the operator's usage and syntax:
    
    // let lightModeColor = .black
    // let darkModeColor = .white
    // let dynamicColor = lightModeColor | darkModeColor
    
    static func | (lightMode: UIColor, darkMode: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else {
            
            MyLogger.logMessage(message: "Custom UIColor method called. Only light color will be returned (current iOS version < 13.0)", category: MyLogger.log_category_info)
            
            return lightMode
            
            
        }
            
        return UIColor { (traitCollection) -> UIColor in
            
            MyLogger.logMessage(message: "Custom UIColor method called. appropriate color for theme will be returned (light or dark, current iOS version > 13.0)", category: MyLogger.log_category_info)
            
            return traitCollection.userInterfaceStyle == .light ? lightMode : darkMode
        }
    }
}

extension UIActivityIndicatorView {
    
    func initStyle() {
                
        if #available(iOS 13.0, *) {} else {self.style = .gray}
        
        // automatically sets Activity Indicator style for iOS versions preceding 13.0.
        // Activity Indicator style for versions proceding iOS 13.0 are controlled through Main.storyboard
        
        MyLogger.logMessage(message: "An IndicatorView was inited", category: MyLogger.log_category_info)
                        
    }
    
}

extension UIViewController {
    
    func openMyMMDrawerControllerMenu(itemIndexPath: IndexPath){
        
        var menuDelegateApp: AppDelegate
        
        var menuDelegateScene: SceneDelegate
        
        let currentiOSVersionAvailability: String?
                        
        if #available(iOS 13.0, *) {
                        
            currentiOSVersionAvailability = "(> iOS 13.0)"
            
            MyLogger.logMessage(message: "Opened menu (> iOS 13.0)", category: MyLogger.log_category_info)
            
            menuDelegateScene = self.view.window?.windowScene?.delegate as! SceneDelegate
            
            for menuItem in menuDelegateScene.menuViewController.tableView.visibleCells {
                
                menuItem.contentView.backgroundColor = menuDelegateScene.dynamicTableViewAreaBackgroundColor
                
            }
                                    
            menuDelegateScene.menuViewController.tableView.cellForRow(at: itemIndexPath)?.contentView.backgroundColor = menuDelegateScene.dynamicViewBackgroundColor
            
            menuDelegateScene.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
            
            // show MenuViewController
            
        } else {
            
            currentiOSVersionAvailability = "(< iOS 13.0)"
            
            menuDelegateApp = UIApplication.shared.delegate as! AppDelegate
            
            for menuItem in menuDelegateApp.menuViewController.tableView.visibleCells {
                
                menuItem.contentView.backgroundColor = menuDelegateApp.dynamicTableViewAreaBackgroundColor
                
            }
                                    
            menuDelegateApp.menuViewController.tableView.cellForRow(at: itemIndexPath)?.contentView.backgroundColor = menuDelegateApp.dynamicViewBackgroundColor
            
            menuDelegateApp.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
            
            // show MenuViewController
        }
        
        MyLogger.logMessage(message: "Opened menu \(String(describing: currentiOSVersionAvailability ?? "error"))", category: MyLogger.log_category_info)
        
    }
    
}

