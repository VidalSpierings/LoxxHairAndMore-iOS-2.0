import Foundation

class HomeModel {
    
    private let userDefaults = UserDefaults()
    
    var mainDescription: String {
        
        get {return userDefaults.string(forKey: MyConstants.home_screen_description_key) ?? MyConstants.standard_home_description_error_value}
        
    }
    
    var business_hours_button_text: String {
        
        get {return userDefaults.string(forKey: MyConstants.business_hours_button_text_key) ?? MyConstants.standard_business_hours_button_text_error_value}
        
    }
    
    // Get value from key, if not available, return pre-defined error value
    
}
