final class HomeViewModel {
    
    private let model = HomeModel()
    
    var startupText: String {get {return model.mainDescription}}
    
    var business_hours_button_text: String {get {return model.business_hours_button_text}}
    
    // Get value from model
    
}
