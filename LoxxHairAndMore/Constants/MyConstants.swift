enum MyConstants {
            
    static let homeViewControllerIdentifier = "HomeViewController"
    static let informationViewControllerIdentifier = "InformationViewController"
    static let hoursOfOperationViewControllerIdentifier = "HoursOfOperationViewController"
    static let tariffsViewControllerIdentifier = "TariffsViewController"
    static let appointmentViewControllerIdentifier = "AppointmentViewController"
    
    static var currently_active_center_viewController = homeViewControllerIdentifier
    
    static let home_viewcontroller_index = 0
    static let information_viewcontroller_index = 1
    static let hours_of_operation_viewcontroller_index = 2
    static let tariffs_viewcontroller_index = 3
    static let appointment_viewcontroller_index = 4
    
    static let hour_notation_position_start = "START"
    static let hour_notation_position_middle = "MIDDLE"
    static let hour_notation_position_end = "END"
    
    static let date_formatting_error_value = "(error)"
    
    // Hour notation constants
    
    static let standard_error_value = "UNKNOWN"
    static let standard_error_value_phone_number = "0"
    static let standard_startup_message_title_description_error_value = "NIL"
    static let standard_webpage_error_value = "https://loxxhairandmore.planetzelf.com/m/"
    // default value: redirects to the now non-existent LOXX Hair and More appointment booking system (Business terminated at time of writing)
    static let standard_gmaps_error_value = "https://www.google.com/search?q=LOXX+Hair+and+More+Tilburg"
    // default value: search query 'LOXX Hair and More The Netherlands' (this will make Google Maps search for anything named 'LOXX Hair and More' in the country of The Netherlands)
    static let standard_amaps_error_value = "https://maps.apple.com/?address=The-Netherlands"
    // default value: Apple Maps country object 'The Netherlands'
    static let standard_start_close_business_hours_error_value = ["UNKNOWN"]
    static let standard_tariffs_error_value = [["error", "error", "error"]]
    static let standard_prices_for_error_value = "Prices for:"
    static let standard_long_button_text_error_value = "Long"
    static let standard_short_button_text_error_value = "Short"
    static let standard_address_error_value = "(Unable to retrieve address)"
    static let standard_show_in_map_text_error_value = "Show in map"
    static let standard_home_description_error_value = "(Unable to retrieve description)"
    static let standard_business_hours_button_text_error_value = "Business hours"
    static let standard_closed_error_value = "Closed"
    static let standard_opened_twentyfour_seven_error_value = "opened 24/7"
    static let standard_make_an_appointment_text_error_value = "Make an appointment"
    static let standard_call_us_text_error_value = "Call us"
    static let standard_online_button_text_error_value = "Online"
    static let standard_email_error_value = "unknown@unknown.com"
    static let standard_facebook_error_value = "https://facebook.com/search/top/?q=LOXX%20Hair%20and%20More"
    // If link to business' Facebook page cannot be retrieved, open Facebook in webbrowser with search term 'LOXX Hair and More' in Facebook
    static let standard_am_error_value = "AM"
    static let standard_pm_error_value = "PM"
    static let standard_hour_number_restarts_after_midday_error_value = false
    static let standard_show_minutes_if_zero_error_value = true
    static let show_startup_message_boolean = false
    static let show_startup_message_entry = 0
    
    static let standard_home_menu_item_error_value = "Home"
    static let standard_hours_of_operation_menu_item_error_value = "Hours of operation"
    static let standard_information_menu_item_error_value = "Information"
    static let standard_make_an_appointment_menu_item_error_value = "Make an appointment"
    static let standard_tariffs_menu_item_error_value = "Tariffs"
    
    static let monday_error_value = "monday"
    static let tuesday_error_value = "tuesday"
    static let wednesday_error_value = "wednesday"
    static let thursday_error_value = "thursday"
    static let friday_error_value = "friday"
    static let saturday_error_value = "saturday"
    static let sunday_error_value = "sunday"
    
    // UserDefaults standard error values constants
        
    static let closed_timestamp_notation = "00:00:12"
    static let opened_twentyfour_seven_timestamp_notation = "00:00:24"
    
    // Special timestamp constants
    
    static let days_in_week_key = "days_in_week"
    static let supported_languages_tree_key = "supported_languages"
    static let first_startup_message_title_key = "first_startup_message_title"
    static let first_startup_message_description_key = "first_startup_message_description"
    static let home_screen_description_key = "home_screen_description"
    static let business_hours_button_text_key = "business_hours_button_text"
    static let closed_notation_key = "closed_notation"
    static let opened_twentyfour_seven_key = "opened_twentyfour_seven"
    static let make_an_appointment_text_key = "make_an_appointment_text"
    static let call_us_text_key = "call_us"
    static let online_button_text_key = "online_button_text"
    static let am_pm_symbol_position_key = "am_pm_symbol_position"
    static let am_symbol_key = "am_symbol"
    static let pm_symbol_key = "pm_symbol"
    static let hour_number_restarts_after_midday_key = "hour_number_restarts_after_midday"
    static let show_minutes_if_zero_key = "show_minutes_if_zero"
    static let show_first_startup_message_boolean_key = "show_first_startup_message_boolean"
    static let show_first_startup_message_entry_key = "show_first_startup_message_boolean_entry"
    static let show_startup_message_entry_currently_known_key = "show_startup_message_entry_currently_known"
    static let business_hours_key = "business_hours"
    static let tariffs_key = "tariffs"
    static let address_key = "address"
    static let prices_for_text_key = "prices_for"
    static let short_button_text_key = "short_button_text"
    static let long_button_text_key = "long_button_text"
    static let show_in_map_key = "show_in_map"
    static let link_to_webpage_key = "link_to_webpage"
    static let apple_maps_url_key = "apple_maps_url"
    static let google_maps_url_key = "google_maps_url"
    static let email_key = "email"
    static let facebook_url_key = "facebook_url"
    static let phone_number_key = "phone_number"
    
    static let home_menu_item_key = "home_menu_item"
    static let hours_of_operation_menu_item_key = "hours_of_operation_menu_item"
    static let information_menu_item_key = "information_menu_item"
    static let make_an_appointment_menu_item_key = "make_an_appointment_menu_item"
    static let tariffs_menu_item_key = "tariffs_menu_item"
    
    // UserDefaults key value constants
        
    static let isUnderDevelopment = true
    
    static let databaseLink = "https://loxx-hair-and-more-27cba-default-rtdb.europe-west1.firebasedatabase.app/.json"
    
    static let supportedLanguagesLink = databaseLink + "/" + supported_languages_tree_key
    
    static let all_days_in_week_array = [
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday"]
    
    // Miscellaneous contstants
}
