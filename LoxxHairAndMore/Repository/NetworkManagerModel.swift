import Foundation

class NetworkManagerModel {
    
    private let first_startup_message_tree_key = "first_startup_message"
    private let languages_tree_key = "languages"
    private let title_key = "title"
    private let startup_message_description_key = "description"
    private let text_in_app_tree_key = "text_in_app"
    private let text_in_app_home_description_key = "description"
    private let business_hours_button_text_key = "business_hours"
    private let home_tree_key = "home"
    private let hours_of_operation_tree_key = "hours_of_operation"
    private let menu_tree_key = "menu"
    private let prices_for_key = "prices_for"
    private let long_button_text_key = "long"
    private let short_button_text_key = "short"
    private let closed_key = "closed"
    private let open_twentyfour_seven_key = "open_twentyfour_seven"
    private let make_an_appointment_key = "make_an_appointment"
    private let call_us_key = "call_us"
    private let online_button_text_key = "online"
    private let information_tree_key = "information"
    private let address_tree_key = "address"
    private let show_in_map_tree_key = "show_in_map"
    private let time_notation_config_tree_key = "time_notation_config"
    private let am_pm_symbol_position_key = "am_pm_symbol_position"
    private let am_symbol = "am_symbol"
    private let pm_symbol = "pm_symbol"
    private let hour_number_restarts_after_midday_key = "hour_number_restarts_after_midday"
    private let show_minutes_if_zero_key = "show_minutes_if_zero"
    private let tariffs_tree_key = "tariffs"
    private let prices_tree_key = "prices"
    private let names_key = "names"
    private let short_key = "short"
    private let long_key = "long"
    
    private let home_menu_item_key = "home"
    private let hours_of_operation_menu_item_key = "hours_of_operation"
    private let information_menu_item_key = "information"
    private let make_an_appointment_menu_item_key = "make_an_appointment"
    private let tariffs_menu_item_key = "tariffs"
    
    private let monday_key = "monday"
    private let tuesday_key = "tuesday"
    private let wednesday_key = "wednesday"
    private let thursday_key = "thursday"
    private let friday_key = "friday"
    private let saturday_key = "saturday"
    private let sunday_key = "sunday"
    
    private let start_time_key = "start_time"
    private let close_time_key = "close_time"
    
    // keys for Database/JSONNode tables
    
    var business_hours_open: [String?] = []
    var business_hours_close: [String?] = []
    
    var days_in_week: [String] = []
    
    static var appLanguageCode = "en_US"
    
    private var userDefaults = UserDefaults()
        
    func getAndSaveSupportedLanguages(jsonNode: JSONNode){
        
        let supportedLanguagesDict = jsonNode[MyConstants.supported_languages_tree_key].dictionary ?? ["error" : JSONNode.null]
        
        MyLogger.logMessage(message: "supported languages: \(supportedLanguagesDict)", category: MyLogger.log_category_info)
        
        var supportedLanguagesArray = [String]()
        
        print("LANGUAGE KEY VALUE: \(supportedLanguagesDict.keys)")
        
        for language in supportedLanguagesDict {
            
            supportedLanguagesArray.append(language.key)
            
            let localizer = MyLocalizer()
            
            localizer.localizeText(supportedLocales: supportedLanguagesArray)
                                    
        }
        
        print("current app language code: \(NetworkManagerModel.appLanguageCode)")
                
    }
    
    func saveAndProcessDecodableData(allData: DatabaseStruct?) {
        
        business_hours_open = [allData?.hours_of_operation?.monday?.start_time,
                               allData?.hours_of_operation?.tuesday?.start_time,
                               allData?.hours_of_operation?.wednesday?.start_time,
                               allData?.hours_of_operation?.thursday?.start_time,
                               allData?.hours_of_operation?.friday?.start_time,
                               allData?.hours_of_operation?.saturday?.start_time,
                               allData?.hours_of_operation?.sunday?.start_time]
        
        business_hours_close = [allData?.hours_of_operation?.monday?.close_time,
                                allData?.hours_of_operation?.tuesday?.close_time,
                                allData?.hours_of_operation?.wednesday?.close_time,
                                allData?.hours_of_operation?.thursday?.close_time,
                                allData?.hours_of_operation?.friday?.close_time,
                                allData?.hours_of_operation?.saturday?.close_time,
                                allData?.hours_of_operation?.sunday?.close_time]
        
        // Get every individual start and closing time for every day of the week for the business
        
        self.userDefaults.set(allData?.first_startup_message?.show_first_startup_message.show, forKey: MyConstants.show_first_startup_message_boolean_key)
        
        self.userDefaults.set(allData?.first_startup_message?.show_first_startup_message.new_entry_count, forKey: MyConstants.show_first_startup_message_entry_key)
        
        print("server value at model: \(String(describing: allData?.first_startup_message?.show_first_startup_message.new_entry_count))")
        
        self.userDefaults.set(allData?.text_in_app?.appointment?.link_to_appointment_webpage ?? MyConstants.standard_webpage_error_value, forKey: MyConstants.link_to_webpage_key)
        // Link to webpage that contains the web-based booking protocol
        
        self.userDefaults.set(allData?.text_in_app?.information?.maps_url?.apple_maps_url ?? MyConstants.standard_amaps_error_value, forKey: MyConstants.apple_maps_url_key)
        // Link to business' address in Apple Maps in case user doesn't have Google Maps installed

        self.userDefaults.set(allData?.text_in_app?.information?.maps_url?.google_maps_url ?? MyConstants.standard_gmaps_error_value, forKey: MyConstants.google_maps_url_key)
        // Link to business' address in Google Maps
        
        self.userDefaults.set(allData?.text_in_app?.information?.email ?? MyConstants.standard_error_value, forKey: MyConstants.email_key)
        // Link to business' general contact e-mail address
        
        self.userDefaults.set(allData?.text_in_app?.information?.facebook_url ?? MyConstants.standard_error_value, forKey: MyConstants.facebook_url_key)
        // Link to business' Facebook page
        
        self.userDefaults.set(allData?.text_in_app?.information?.tel ?? MyConstants.standard_error_value_phone_number, forKey: MyConstants.phone_number_key)
        // Link to business' general contact telephone number
        
    }
    
    func getAndSaveValuesJsonSerialization (jsonNode: JSONNode){
                                                                                
        let tariffsDict = jsonNode[self.tariffs_tree_key].dictionary ?? ["error" : JSONNode.null]
                                                        
        var tariffsArray = [[String]]()
                
        MyLogger.logMessage(message: "tariffs dictionairy: \(tariffsDict)", category: MyLogger.log_category_info)
        
        for service in tariffsDict {
                        
            let nameForLocale = jsonNode[self.tariffs_tree_key][service.key][self.names_key][NetworkManagerModel.appLanguageCode].string ?? "error"
            
            // extract name for locale at index from JSSON Object
                                     
            let priceShort = jsonNode[self.tariffs_tree_key][service.key][self.prices_tree_key][NetworkManagerModel.appLanguageCode][self.short_key].string ?? "error"
            
            // extract price for short hair at index from JSSON Object
            
            let priceLong = jsonNode[self.tariffs_tree_key][service.key][self.prices_tree_key][NetworkManagerModel.appLanguageCode][self.long_key].string ?? "error"
            
            // extract price for long hair at index from JSSON Object
            
            tariffsArray.append([nameForLocale, priceShort, priceLong])
            
            // insert all extracted values into new tariffs array entry
                        
        }
        
        //TODO: CHECK ABOVE STATEMENT, CHECK WHETHER OR NOT DICTIONAIRY PROTOCOL CAN BE USED TO REDUCE TYPOS IN FETCHING VALUES FROM COMMONLY USED TREES!
                                        
        self.userDefaults.set(
            [jsonNode[self.hours_of_operation_tree_key][self.monday_key][NetworkManagerModel.appLanguageCode].string, jsonNode[self.hours_of_operation_tree_key][self.tuesday_key][NetworkManagerModel.appLanguageCode].string, jsonNode[self.hours_of_operation_tree_key][self.wednesday_key][NetworkManagerModel.appLanguageCode].string, jsonNode[self.hours_of_operation_tree_key][self.thursday_key][NetworkManagerModel.appLanguageCode].string, jsonNode[self.hours_of_operation_tree_key][self.friday_key][NetworkManagerModel.appLanguageCode].string, jsonNode[self.hours_of_operation_tree_key][self.saturday_key][NetworkManagerModel.appLanguageCode].string, jsonNode[self.hours_of_operation_tree_key][self.sunday_key][NetworkManagerModel.appLanguageCode].string], forKey: MyConstants.days_in_week_key)
        
        // localized texts of days in the week for specified app language
        
        self.userDefaults.set(jsonNode[self.first_startup_message_tree_key][self.languages_tree_key][NetworkManagerModel.appLanguageCode][self.title_key].string, forKey: MyConstants.first_startup_message_title_key)
        
        // first startup message title in locale
        
        self.userDefaults.set(jsonNode[self.first_startup_message_tree_key][self.languages_tree_key][NetworkManagerModel.appLanguageCode][self.startup_message_description_key].string, forKey: MyConstants.first_startup_message_description_key)
        
        // first startup message description in locale
                
        self.userDefaults.set(tariffsArray, forKey: MyConstants.tariffs_key)
        
        // array containing tariff names in locale and all prices
        
        self.userDefaults.set(jsonNode[self.text_in_app_tree_key][self.home_tree_key][NetworkManagerModel.appLanguageCode][self.text_in_app_home_description_key].string, forKey: MyConstants.home_screen_description_key)
        
        // home screen description in locale
        
        self.userDefaults.set(jsonNode[self.text_in_app_tree_key][self.home_tree_key][NetworkManagerModel.appLanguageCode][self.business_hours_button_text_key].string, forKey: MyConstants.business_hours_button_text_key)
        
        // business hours button localized text

        self.userDefaults.set(jsonNode[self.text_in_app_tree_key][self.hours_of_operation_tree_key][NetworkManagerModel.appLanguageCode][self.closed_key].string, forKey: MyConstants.closed_notation_key)
        
        // closed notation in locale

        self.userDefaults.set(jsonNode[self.text_in_app_tree_key][self.hours_of_operation_tree_key][NetworkManagerModel.appLanguageCode][self.open_twentyfour_seven_key].string, forKey: MyConstants.opened_twentyfour_seven_key)
        
        // localized 'opened 24/7' notation
        
        self.userDefaults.set(jsonNode[self.text_in_app_tree_key][self.hours_of_operation_tree_key][NetworkManagerModel.appLanguageCode][self.make_an_appointment_key].string, forKey: MyConstants.make_an_appointment_text_key)
        
        // localized 'make an appointment' notation
        
        self.userDefaults.set(jsonNode[self.text_in_app_tree_key][self.hours_of_operation_tree_key][NetworkManagerModel.appLanguageCode][self.call_us_key].string, forKey: MyConstants.call_us_text_key)
        
        // localized 'call us' text notation
        
        self.userDefaults.set(jsonNode[self.text_in_app_tree_key][self.hours_of_operation_tree_key][NetworkManagerModel.appLanguageCode][self.online_button_text_key].string, forKey: MyConstants.online_button_text_key)
        
        // localized 'online' text notation

        self.userDefaults.set(jsonNode[self.text_in_app_tree_key][self.information_tree_key][self.address_tree_key][NetworkManagerModel.appLanguageCode].string, forKey: MyConstants.address_key)
        
        // address of establishment
        
        self.userDefaults.set(jsonNode[self.text_in_app_tree_key][self.information_tree_key][self.show_in_map_tree_key][NetworkManagerModel.appLanguageCode].string, forKey: MyConstants.show_in_map_key)
        
        // localized 'show in map' button text
        
        self.userDefaults.set(jsonNode[self.text_in_app_tree_key][self.tariffs_tree_key][NetworkManagerModel.appLanguageCode][self.prices_for_key].string, forKey: MyConstants.prices_for_text_key)
        
        // localized 'Prices for' text
        
        self.userDefaults.set(jsonNode[self.text_in_app_tree_key][self.tariffs_tree_key][NetworkManagerModel.appLanguageCode][self.long_button_text_key].string, forKey: MyConstants.long_button_text_key)
        
        // localized 'Long' button text
        
        self.userDefaults.set(jsonNode[self.text_in_app_tree_key][self.tariffs_tree_key][NetworkManagerModel.appLanguageCode][self.short_button_text_key].string, forKey: MyConstants.short_button_text_key)
        
        // localized 'Short' button text
        
        self.userDefaults.set(jsonNode[self.text_in_app_tree_key][self.menu_tree_key][NetworkManagerModel.appLanguageCode][self.home_menu_item_key].string, forKey: MyConstants.home_menu_item_key)
        
        // localized 'Home' menu item notation
        
        self.userDefaults.set(jsonNode[self.text_in_app_tree_key][self.menu_tree_key][NetworkManagerModel.appLanguageCode][self.hours_of_operation_menu_item_key].string, forKey: MyConstants.hours_of_operation_menu_item_key)
        
        // localized 'Hours of operation' menu item notation
        
        self.userDefaults.set(jsonNode[self.text_in_app_tree_key][self.menu_tree_key][NetworkManagerModel.appLanguageCode][self.information_menu_item_key].string, forKey: MyConstants.information_menu_item_key)
        
        // localized 'Information' menu item notation
        
        self.userDefaults.set(jsonNode[self.text_in_app_tree_key][self.menu_tree_key][NetworkManagerModel.appLanguageCode][self.make_an_appointment_menu_item_key].string, forKey: MyConstants.make_an_appointment_menu_item_key)
        
        // localized 'Make an appointment' menu item notation
        
        self.userDefaults.set(jsonNode[self.text_in_app_tree_key][self.menu_tree_key][NetworkManagerModel.appLanguageCode][self.tariffs_menu_item_key].string, forKey: MyConstants.tariffs_menu_item_key)
        
        // localized 'Tariffs' menu item notation

        self.userDefaults.set(jsonNode[self.time_notation_config_tree_key][NetworkManagerModel.appLanguageCode][self.am_pm_symbol_position_key].string, forKey: MyConstants.am_pm_symbol_position_key)
        
        // AM/PM symbol position

        self.userDefaults.set(jsonNode[self.time_notation_config_tree_key][NetworkManagerModel.appLanguageCode][self.am_symbol].string, forKey: MyConstants.am_symbol_key)
        
        // AM symbol in locale

        self.userDefaults.set(jsonNode[self.time_notation_config_tree_key][NetworkManagerModel.appLanguageCode][self.pm_symbol].string, forKey: MyConstants.pm_symbol_key)
        
        // PM symbol in locale
        
        self.userDefaults.set(jsonNode[self.time_notation_config_tree_key][NetworkManagerModel.appLanguageCode][self.hour_number_restarts_after_midday_key].boolean, forKey: MyConstants.hour_number_restarts_after_midday_key)
        
        // hour number restarts after midday boolean (Decides whether time number resets to 1 after midday. For example: When turned off, shows 1 o'clock in the afternoon as 13PM. When turned on, shows 1 o'clock in the afternoon as 1PM)
        
        self.userDefaults.set(jsonNode[self.time_notation_config_tree_key][NetworkManagerModel.appLanguageCode][self.show_minutes_if_zero_key].boolean, forKey: MyConstants.show_minutes_if_zero_key)
        
        // show minutes if 0 boolean (decides whether or not minutes are shown if equal to :00. For example, if turned on, shows 1 o'clock in the afternoon as 1:00PM, if turned off, shows 1 o'clock in the afternoon as 1PM)
                
    }
    
    func saveBusinessHours(businessHours: [String]) {
        
        self.userDefaults.set(businessHours, forKey: MyConstants.business_hours_key)
        
    }
    
    func getDatabaseStruct() -> DatabaseStruct.Type {
        
        return DatabaseStruct.self
        
    }
        
    struct DatabaseStruct: Decodable {
        
    var first_startup_message: FirstStartupMessage?
        
    var hours_of_operation: HoursOfOperationDays?
                                                
    var text_in_app: TextInApp?
                                                
    }
    
    struct TariffStruct {
        
        var prices: PricesStruct
        
    }
    
    struct PricesStruct {
        
        var long: String
        var short: String
        
    }
    
    struct FirstStartupMessage: Decodable {
                            
    var show_first_startup_message: ShowFirstStartupMessage
                        
    }
    
    struct ShowFirstStartupMessage: Decodable {
        
        var show: Bool?
        var new_entry_count: Int?
        
    }
    
    struct HoursOfOperationDays: Decodable {

    var monday: HoursOfOperationTimes?
    var tuesday: HoursOfOperationTimes?
    var wednesday: HoursOfOperationTimes?
    var thursday: HoursOfOperationTimes?
    var friday: HoursOfOperationTimes?
    var saturday: HoursOfOperationTimes?
    var sunday: HoursOfOperationTimes?
                
    }
    
    struct HoursOfOperationTimes: Decodable {
        
    var start_time: String?
    var close_time: String?
        
    }
    
    struct TextInApp: Decodable {
                
    var information: InformationStruct?
        
    var appointment: AppointmentStruct?
                                        
    }
    
    struct AppointmentStruct: Decodable {
        
    var link_to_appointment_webpage: String?
        
    }
    
    struct InformationStruct: Decodable {
        
    var maps_url: MapsStruct?
        
    var email, tel, facebook_url: String?
                            
    }
    
    struct MapsStruct: Decodable {
    
    var apple_maps_url: String?
    var google_maps_url: String?
        
    }
    
    // Decodable structs for tables that are called absolutely and not dynamically
    // (for example, the decodable structs do not contain language-specific tables like 'en_US' or 'nl', since it will only be known at runtime for what specific language values have to be retrieved)
    
}
