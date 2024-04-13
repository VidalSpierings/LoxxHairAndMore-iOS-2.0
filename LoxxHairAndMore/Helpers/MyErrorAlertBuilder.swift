import UIKit

class MyErrorAlertBuilder{
    
    var myAlert: UIAlertController? = nil
    
    func displayStandardErrorAlert(logText: String, logCategory: String, viewController vc: UIViewController, errorTitle: String, errorMessage: String) {
        
        initDialog(title: errorTitle, message: errorMessage)
        
        vc.present(myAlert ?? UIAlertController(), animated: true)
        // Build and show error alert
        
        MyLogger.logMessage(message: logText, category: logCategory)
        
    }
    
    func displayStandardAlertFromUIWindow(title: String, message: String) -> UIAlertController{
        
        initDialog(title: title, message: message)
        // function returns object to ensure that dialog can be programmatically dismissed later on
        
        showUIWindowDialog()
                
        return myAlert ?? UIAlertController()
    }
    
    func displayStandardErrorAlertFromUIWindowNonVoid(errorTitle: String, errorMessage: String, logText: String, logCategory: String) -> UIAlertController{
        
        // this function builds and displays a custom  error-related UIAlert, as well as logging the error paradigm trough the MyLogger custom logger class. This is a non-void that returns the used UIAlert instance as a value, which allows for use cases such as, but not limited to, dismissing the UIAlert programmatically later on if need be
        
        displayStandardErrorAlertFromUIWindowVoid(errorTitle: errorTitle, errorMessage: errorMessage, logText: logText, logCategory: logCategory)
        
        return myAlert ?? UIAlertController()
        
    }
    
    func displayStandardErrorAlertFromUIWindowVoid(errorTitle: String, errorMessage: String, logText: String, logCategory: String) {
        
        // this function builds and displays a custom  error-related UIAlert, as well as logging the error paradigm trough the MyLogger custom logger class. This is a void method that does not return the UIAlert as a value, increasing coding efficency for instances such as, but not limited to, working with UIAlerts that do not have to be programmatically dismissed later on
        
        initDialog(title: errorTitle, message: errorMessage)
        // function returns object to ensure that dialog can be programmatically dismissed later on
        
        showUIWindowDialog()
        
        MyLogger.logMessage(message: errorTitle, category: errorMessage)
                
    }
    
    private func showUIWindowDialog(){
        
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController

        rootViewController?.present(myAlert ?? UIAlertController(), animated: true, completion: nil)
        
    }
    
    private func initDialog(title: String, message: String) {
        
        myAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        myAlert?.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        
    }
    
}
