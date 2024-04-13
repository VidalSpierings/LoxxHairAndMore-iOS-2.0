import CoreTelephony
import UIKit

struct MyCallUtil {
    
    func checkIfCallCapabilityAvailable() -> Bool{
                        
        let isCapableToCall: Bool
            if UIApplication.shared.canOpenURL(URL(string: "tel://123456789")!) {
                // Check if iOS Device supports phone calls
                // User will get an alert error when they will try to make a phone call in airplane mode
                if let mnc = CTTelephonyNetworkInfo().subscriberCellularProvider?.mobileNetworkCode, !mnc.isEmpty {
                    // iOS Device is capable for making calls
                    isCapableToCall = true
                } else {
                    // Device cannot place a call at this time. SIM might be removed
                    isCapableToCall = false
                }
            } else {
                // iOS Device is not capable for making calls
                isCapableToCall = false
            }
        
        MyLogger.logMessage(message: "Checked capability for making phone calls", category: MyLogger.log_category_info)

        return isCapableToCall
        
    }
    
    // Check users' capability for making phone calls according to whether or not the user is currently actively making use of a call/SMS carrier service
    
}
