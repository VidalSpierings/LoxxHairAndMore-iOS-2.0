final class HoursOfOperationViewModel {
    
    private let model = HoursOfOperationModel()
        
    var phone_number: String {get {return model.phone_number}}
    
    var business_hours : [String] {get {return model.business_hours}}
    
    var days_in_week_names: [String] {get {return model.days_in_week_names}}
    
    var closed: String {get {return model.closed}}
    
    var opened_24_7: String {get {return model.opened_24_7}}
    
    var make_an_appointment_text: String {get {return model.make_an_appointment_text}}
    
    var call_us_button_text: String {get {return model.call_us_button_text}}
    
    var online_button_text: String {get {return model.online_button_text}}

    // Get values from model
    
}
