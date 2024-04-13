import Foundation

class TariffsModel {
    
    private let userDefaults = UserDefaults()
    
    var tariffsList: [[String]] {
                
        get {
            
            return userDefaults.value(forKey: MyConstants.tariffs_key) as? [[String]] ?? MyConstants.standard_tariffs_error_value}
        
    }
    
    var prices_for_text: String {get {return userDefaults.string(forKey: MyConstants.prices_for_text_key) ?? MyConstants.standard_prices_for_error_value}}
    
    var long_button_text: String {get {return userDefaults.string(forKey: MyConstants.long_button_text_key) ?? MyConstants.standard_long_button_text_error_value}}
    
    var short_button_text: String {get {return userDefaults.string(forKey: MyConstants.short_button_text_key) ?? MyConstants.standard_short_button_text_error_value}}
    
    // Get value from key, if not available, return pre-defined error value
    
}
