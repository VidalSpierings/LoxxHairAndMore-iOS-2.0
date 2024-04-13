import Foundation

class AppointmentModel {
    
    private let userDefaults = UserDefaults()
    
    var webURLString: String {
        
        get {return userDefaults.value(forKey: MyConstants.link_to_webpage_key) as? String ?? MyConstants.standard_webpage_error_value}
        
    }
    
    // Get value from key, if not available, return pre-defined error value
    
}
