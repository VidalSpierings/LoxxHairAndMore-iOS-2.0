import Foundation

struct CellEntries {
    
    var identifier: String
    var displayName: String
    
}

// defined here so this type can be defined in viewmodel

class MenuModel {
    
    var cellEntries = [CellEntries]()
    
    private let userDefaults = UserDefaults()
    
    init() {
        
        cellEntries.append(CellEntries(identifier: MyConstants.homeViewControllerIdentifier, displayName: userDefaults.string(forKey: MyConstants.home_menu_item_key) ?? MyConstants.standard_home_menu_item_error_value))
    
        cellEntries.append(CellEntries(identifier: MyConstants.informationViewControllerIdentifier, displayName: userDefaults.string(forKey: MyConstants.information_menu_item_key) ?? MyConstants.standard_information_menu_item_error_value))
    
        cellEntries.append(CellEntries(identifier: MyConstants.hoursOfOperationViewControllerIdentifier, displayName: userDefaults.string(forKey: MyConstants.hours_of_operation_menu_item_key) ?? MyConstants.standard_hours_of_operation_menu_item_error_value))
    
        cellEntries.append(CellEntries(identifier: MyConstants.tariffsViewControllerIdentifier, displayName: userDefaults.string(forKey: MyConstants.tariffs_menu_item_key) ?? MyConstants.standard_tariffs_menu_item_error_value))
    
        cellEntries.append(CellEntries(identifier: MyConstants.appointmentViewControllerIdentifier, displayName: userDefaults.string(forKey: MyConstants.make_an_appointment_menu_item_key) ?? MyConstants.standard_make_an_appointment_menu_item_error_value))
        
        // It is preferable to use NSLocalisedString instead of the .localisedCapitalized protocol for localised strings so the exact strings can be shown instead of a forced-capitalized version of the strings. However, NSLocalisedString requires importing UIKit and for now all the localised string values start with a capital letter anyway, so the above approach is the best possible approach for now
        
    }
    
}
