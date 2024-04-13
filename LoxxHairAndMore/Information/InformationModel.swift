import Foundation

//TODO: WHEN FINISHED: CHECK IMPORTS

class InformationModel {
    
    private let userDefaults = UserDefaults()
    
    var email: String {
        
        get {return userDefaults.string(forKey: MyConstants.email_key) ?? MyConstants.standard_error_value}
        
    }
    
    var phoneNumber: String {
        
        get {return userDefaults.string(forKey: MyConstants.phone_number_key) ?? MyConstants.standard_error_value_phone_number}
        
    }
    
    var address: String {
        
        get {return userDefaults.string(forKey: MyConstants.address_key) ?? MyConstants.standard_address_error_value}
        
    }
    
    var show_in_map_button_localized_text: String {
        
        get {return userDefaults.string(forKey: MyConstants.show_in_map_key) ?? MyConstants.standard_show_in_map_text_error_value}
        
    }
    
    var aMapsURL: String {
        
        get {return userDefaults.string(forKey: MyConstants.apple_maps_url_key) ?? MyConstants.standard_amaps_error_value}
        
    }
    
    var gMapsURL: String {
        
        get {return userDefaults.string(forKey: MyConstants.google_maps_url_key) ?? MyConstants.standard_gmaps_error_value}
        
    }
    
    var facebookURL: String {
        
        get {return userDefaults.string(forKey: MyConstants.facebook_url_key) ?? MyConstants.standard_error_value}
        
    }
    
    // Get values from key, if not available, return pre-defined error value
    
}
