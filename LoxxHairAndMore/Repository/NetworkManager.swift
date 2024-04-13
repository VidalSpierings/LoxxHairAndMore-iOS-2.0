import Reachability
import Foundation

class NetworkManager {
    
    private var model = NetworkManagerModel()
    
    func fetchAllData(_ completed: (() -> Void)?) -> () {
                
    guard let url = URL(string: MyConstants.databaseLink) else {return}
        
     URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
         
         self.fetchSupportedLanguages(error: error, data: data)
         
         self.logHttpResponse(message: "Server reponse for fetching all available app languages:", response: response as! HTTPURLResponse)
                  
         if completed != nil {
             
             self.fetchLocalizedData(completed)
             
             //return completed!()
             
             // PAS ALS  COMPLETED IN FETCHLOCALIZEDDATA NIET MEER NIL IS, DAN return completed!() HIER, IN FETCHALLDATA, TRIGGEREN
             
             
         }
         
         //TODO: TEST IF ABOVE WORKS; FIRST RETRIEVE APP LANGUAGE, WHEN DONE, RETRIEVE REMAINING DATA, WHEN DONE, RUN ONCOMPLETION CODE TYPED OUT IN APPDELEGATE (METHOD WITH ARGUMENT WITHIN METHOD (NetworkManager().fetchAllData) THAT CALLS CODE TO BE EXECUTED WHEN EVERYTHING IS DONE LOADING)
                  
     }).resume()
        
    }
    
    func fetchSupportedLanguages(error: Error?, data: Data?){
        
        if error == nil && data != nil {
                            
            do {
                
                if let error = error {
                    
                    MyLogger.logMessage(message: "Something went wrong while trying to get info about supported languages from database. Error description: \(error.localizedDescription)", category: MyLogger.log_category_error)
                    
                } else {
                                                                                             
                    let jsonNode = try JSONNode(data: data ?? Data())
                                         
                    self.model.getAndSaveSupportedLanguages(jsonNode: jsonNode)
                                         
                    //MyLocalizer.localizeText(self.model.getSupportedLanguages(jsonNode: jsonNode))
                                                                
                }
                                
            }catch{
                
                MyLogger.logMessage(message: "error parsing database's JSON object", category: MyLogger.log_category_error)
                
            }
                        
        }
        
    }
    
    func fetchAllData2(_ completed: (() -> Void)?) -> () {

        
        /*
        
        guard let url = URL(string: MyConstants.databaseLink) else {return}
                
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            
            if error == nil && data != nil {
                                
                do {
                    
                    if let error = error {
                        
                        MyLogger.logMessage(message: "Something went wrong while trying to get info from database. Error description: \(error.localizedDescription)", category: MyLogger.log_category_error)
                        
                    } else {
                                                       
                        let jsonNode = try JSONNode(data: data ?? Data())
                        
                        self.model.getAndSaveValuesJsonSerialization(jsonNode: jsonNode)
                        
                        self.getAndSaveValuesFromDecodable(data: data)
                        
                        DispatchQueue.global(qos: .userInitiated).async {
                            
                            self.formatAndSaveBusinessHours()
                            
                        }
                                                
                    }
                    
                }catch{
                    
                    MyLogger.logMessage(message: "error parsing database's JSON object", category: MyLogger.log_category_error)
                    
                }
                            
            }
            
            self.logHttpResponse(message: "Server response for fetching all data:",response: response as! HTTPURLResponse)
            
            if completed != nil {return completed!()}


        }).resume()
         
         */
        
        
        
    }
    
    private func fetchLocalizedData(_ completed: (() -> Void)?) -> () {
        
        guard let url = URL(string: MyConstants.databaseLink) else {return}
                
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            
            if error == nil && data != nil {
                                
                do {
                    
                    if let error = error {
                        
                        MyLogger.logMessage(message: "Something went wrong while trying to get info from database. Error description: \(error.localizedDescription)", category: MyLogger.log_category_error)
                        
                    } else {
                                                       
                        let jsonNode = try JSONNode(data: data ?? Data())
                        
                        self.model.getAndSaveValuesJsonSerialization(jsonNode: jsonNode)
                        
                        self.getAndSaveValuesFromDecodable(data: data)
                        
                        DispatchQueue.global(qos: .userInitiated).async {
                            
                            self.formatAndSaveBusinessHours()
                            
                        }
                                                
                    }
                    
                }catch{
                    
                    MyLogger.logMessage(message: "error parsing database's JSON object", category: MyLogger.log_category_error)
                    
                }
                            
            }
            
            if completed != nil {return completed!()}
            
            self.logHttpResponse(message: "Server response for fetching all data:", response: response as! HTTPURLResponse)
            
        }).resume()
        
    }
    
    private func formatAndSaveBusinessHours(){
        
        let businessHoursArray = DateFormatterHelper(openingTimes: self.model.business_hours_open , closingTimes: self.model.business_hours_close).convertISO8601ObjectsToTimesArray()
        
        self.model.saveBusinessHours(businessHours: businessHoursArray)
        
    }
    
    private func getAndSaveValuesFromDecodable (data: Data?){
        
        let allData = try? JSONDecoder().decode(model.getDatabaseStruct(), from: data!)
                                                        
        if (allData == nil) {
                                        
            print("allData is nil")
                                                                                
        } else {
            
            print("allData is not nil")
            
            model.saveAndProcessDecodableData(allData: allData)
                        
        }
                
    }
    
    func logHttpResponse(message: String, response: HTTPURLResponse){
                
        MyLogger.logMessage(message: "\(message) '\(response.statusCode)'", category: MyLogger.log_category_network)
        
    }

}
