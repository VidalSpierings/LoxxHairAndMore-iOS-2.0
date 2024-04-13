import Foundation
import os

struct MyLogger {
    
    @available(iOS 14.0, *)
    static let shared = Logger()
    
    static let log_category_error = "general error"
    static let log_category_data_processing = "data processing error"
    static let log_category_ui_functionality = "UI functionality error"
    static let log_category_system_functionality = "system functionality error"
    static let log_category_info = "general info"
    static let log_category_network = "network"
    static let log_category_sqlite = "SQLite database error"
    
    // all messages are categorised, ensuring improved log readability
    
    static func logMessage(message: String, category: String) {
                
        if #available(iOS 14.0, *), MyConstants.isUnderDevelopment == true {
            shared.info("\(message)")
        } else if (MyConstants.isUnderDevelopment == true){
            
            NSLog(message)
            
        }
        
        // above code ensures that the most recently available Log protocol will be used
        
    }
    
}
