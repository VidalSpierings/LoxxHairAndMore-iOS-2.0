final class AppointmentViewModel {
    
    private let model = AppointmentModel()
    
    var webURLString: String {get {return model.webURLString}}
    
    // Get value from model
    
    func logUrlInvalidMessage() {
        
        MyLogger.logMessage(message: "could not initiliase url, address might be invalid", category: MyLogger.log_category_data_processing)
        
    }
    
}
