import Foundation

class DateFormatterHelper {
    
    private let userDefaults = UserDefaults()
    
    private let parser = DateFormatter()
    
    private let calendar = Calendar(identifier: .iso8601)
        
    private var openingTimes, closingTimes: [String?]
        
    init (openingTimes: [String?], closingTimes: [String?]) {
        
        self.openingTimes = openingTimes
        self.closingTimes = closingTimes
                
    }
    
    func convertISO8601ObjectsToTimesArray() -> [String] {
        
        var businessHours = convertISO8601_objectsToCurrentLanguage()
                
        let userDefaults = UserDefaults()
                
        let closed = userDefaults.string(forKey: MyConstants.closed_notation_key) ?? MyConstants.standard_closed_error_value
        let opened_24_7 = userDefaults.string(forKey: MyConstants.opened_twentyfour_seven_key) ?? MyConstants.standard_opened_twentyfour_seven_error_value
                
        for time in 0..<businessHours.count {
                        
            if businessHours[time].lowercased() == "\(closed) - \(closed)".lowercased() {
                
                businessHours[time] = closed
                
            } else if businessHours[time].lowercased() == "\(opened_24_7) - \(opened_24_7)".lowercased(){
            
                businessHours[time] = opened_24_7
                        
        }
    }
                
        return businessHours
        
    }
    
    private func convertISO8601_objectsToCurrentLanguage() -> [String]{
        
        // converts all retrieved timestamps for opening and closing times in ISO8601 format to localised string array readable to user, with the following approximate syntax: ["\(openingTime) - \(closingTime)", "\(openingTime) - \(closingTime)", etc...]
                
        var businessHours = [String]()
            
        if (openingTimes.count == closingTimes.count) {
            
            print("openingTimes Length equals closingTimes length")
            
            for time in 0..<openingTimes.count {
                
                businessHours.append("\(convertTimeToAppropriateTimeFormatting(iso8601_object: openingTimes[time] ?? "error", index: time)) - \(convertTimeToAppropriateTimeFormatting(iso8601_object: closingTimes[time] ?? "error", index: time))")
                
                // configure and append hours of operation string for length of opening times array (which is always 7)
                
            }
            
        }
        
        return businessHours
            
    }
        
    internal func convertTimeToAppropriateTimeFormatting(iso8601_object: String, index: Int) -> String {
        
        //TODO: ADD CHECKS FOR OPENED CLOSED AND OPENEND 24/7
                
        MyLogger.logMessage(message: "Retrieved ISO 8601 Object: \(iso8601_object)", category: MyLogger.log_category_info)
                        
        parser.dateFormat = "HH:mm:ss"
        let parsedTimestamp = parser.date(from: iso8601_object) ?? Date(timeIntervalSince1970: 0)
                
        MyLogger.logMessage(message: "parsed a timestamp: \(parsedTimestamp)", category: MyLogger.log_category_info)
        // error value is Jan 1st, 1970, 12:00 AM
        
        // convert iso8061 object to date object to later extract the hours and minutes from it
        
        let amSymbol = userDefaults.value(forKey: MyConstants.am_symbol_key) as? String ?? MyConstants.standard_am_error_value
        let pmSymbol = userDefaults.value(forKey: MyConstants.pm_symbol_key) as? String ?? MyConstants.standard_pm_error_value
        let am_pm_symbol_position = userDefaults.value(forKey: MyConstants.am_pm_symbol_position_key) as? String ?? MyConstants.hour_notation_position_end
        let hour_number_restarts_after_midday = userDefaults.value(forKey: MyConstants.hour_number_restarts_after_midday_key) as? Bool ?? MyConstants.standard_hour_number_restarts_after_midday_error_value
        let show_minutes_if_0 = userDefaults.value(forKey: MyConstants.show_minutes_if_zero_key) as? Bool ?? MyConstants.standard_show_minutes_if_zero_error_value
        let currentLocaleCode = "en_US"
                            
        //parser.locale = Locale(identifier: currentLocaleCode)
        parser.amSymbol = amSymbol
        parser.pmSymbol = pmSymbol
        
        // init date formatting for locale, use custom AM and PM notations according to data retrieved from database

        let calendarComp = calendar.dateComponents([.hour, .minute, .second], from: parsedTimestamp)
        
        MyLogger.logMessage(message: "converted calendar object: \(calendarComp)", category: MyLogger.log_category_info)
        
        // As we want to display a set time to the user and not a set date, init Calendar object that only contains the hour and minute from the date object
        
        var convertedString = ""
        
        parser.dateFormat = "h:mm a"
        
        // time will be shown as, for example, if 11 in the morning: '11AM'
                                                    
        if !show_minutes_if_0 && calendarComp.minute == 0 {
                
            MyLogger.logMessage(message: "show minutes is false, calendarcomp minutes is 0", category: MyLogger.log_category_info)
            
            parser.dateFormat = "ha"
            
            // time will be shown as, for example, if 11 in the morning: '11:00AM'
                                        
            convertedString = parser.string(from: parsedTimestamp)
                
        }
        
        else {
                
            MyLogger.logMessage(message: "show minutes is true", category: MyLogger.log_category_info)
            
            parser.dateFormat = "h:mm a"
            
            // time will be shown as, for example, if 11 in the morning: '11AM'
                                
            convertedString = parser.string(from: parsedTimestamp)
                
            // create string for time in the following format: <hour>:<Minute> <single space> <AM/PM Notation>
                
        }
        
        if iso8601_object == MyConstants.closed_timestamp_notation {
            
            convertedString = userDefaults.value(forKey: MyConstants.closed_notation_key) as? String ?? MyConstants.standard_closed_error_value
            
            // create string saying 'Closed' in locale If hours equals 0, minutes equals 0 and seconds equals 12. This is a time notation scheme used exlusively in this application, since seconds are never shown in real-world notation of business hours.
            
        }
        
        else if iso8601_object == MyConstants.opened_twentyfour_seven_timestamp_notation {
            
            convertedString = userDefaults.value(forKey: MyConstants.opened_twentyfour_seven_key) as? String ?? MyConstants.standard_opened_twentyfour_seven_error_value
            
            // create string saying 'opened 24/7' in locale If hours equals 0, minutes equals 0 and seconds equals 24. This is a time notation scheme used exclusively in this application, since seconds are never shown in real-world notation of business hours.
            
        }
        
        else if calendarComp.hour == 1 && calendarComp.minute == 0 && calendarComp.second == 0 {
                            
        convertedString = MyConstants.date_formatting_error_value
            
        }
        
        // init whether or not the minutes are shown to the user when minutes are 0 (for example: Display 8AM or 8:00AM)
                                
        let currentDayInWeek = MyConstants.all_days_in_week_array[index]
                                                
        MyLogger.logMessage(message: "converted date from a \(currentDayInWeek) to \(currentLocaleCode) :  \(convertedString)", category: MyLogger.log_category_info)
            
        // above line improves readability and makes it easier to spot date formatting and processing errors/irregularities
        
        return convertedString
            
        }
    
    // This function is explicitly created as an 'internal' function as so to make it extra clear that the only instance where this function is run outside of this file is within the DateFormatterHelperTests file
    
}
