import Foundation

class HoursOfOperationModel {
    
    private let userDefs = UserDefaults()
    
    var phone_number: String{
        
        get {return userDefs.string(forKey: MyConstants.phone_number_key)
            ?? MyConstants.standard_error_value_phone_number}
        
    }
    
    var business_hours: [String]{
        
        get {return userDefs.stringArray(forKey: MyConstants.business_hours_key) ?? ["error"]}
        
    }
    
    var days_in_week_names: [String] {
        
        get {return userDefs.stringArray(forKey: MyConstants.days_in_week_key) ?? ["error"]}
        
    }
    
    var closed: String{
        
        get {return userDefs.value(forKey: MyConstants.closed_notation_key) as? String ?? MyConstants.standard_closed_error_value}
        
    }
    
    var opened_24_7: String{
        
        get {return userDefs.value(forKey: MyConstants.opened_twentyfour_seven_key) as? String ?? MyConstants.standard_opened_twentyfour_seven_error_value}
        
    }
    
    var make_an_appointment_text: String{
        
        get {return userDefs.string(forKey: MyConstants.make_an_appointment_text_key)
            ?? MyConstants.standard_make_an_appointment_text_error_value}
        
    }
    
    var call_us_button_text: String{
        
        get {return userDefs.string(forKey: MyConstants.call_us_text_key)
            ?? MyConstants.standard_call_us_text_error_value}
        
    }
    
    var online_button_text: String{
        
        get {return userDefs.string(forKey: MyConstants.online_button_text_key)
            ?? MyConstants.standard_online_button_text_error_value}
        
    }
    
    // Get values from key, if not available, return pre-defined error value
    
}
