//
//  MyLocalizer.swift
//  Loxx Hair and More
//
//  Created by Vidal on 21/03/2023.
//

import Foundation

class MyLocalizer {
    
    func localizeText (supportedLocales: [String]){
        
        var supportedLocaleCode = ""
        
        for locale in supportedLocales {
            
            if locale == Locale.current.identifier {
                
                supportedLocaleCode = locale
                
                // check if current index in loop matches current device's sublocale, for example 'en_US' or 'en_GB'. If yes, set 'supportedLocaleCode' to this sublocale
                
                break
                
            } else if locale == Locale.current.languageCode {
                
                supportedLocaleCode = locale
                
                // if current index in loop does not match device sublocale, check if current index in loop matches device's 'general' locale, for example 'en' or 'nl'. If yes, set 'supportedLocaleCode' to this 'general' locale
                
                break
                
            } else {
                
                supportedLocaleCode = "en_US"
                
                // Default to American English if current index in loop does not match a 'general' or sublocale that is currently active on the device
                
            }
            
        }
        
        NetworkManagerModel.appLanguageCode = supportedLocaleCode
                
    }
    
    // WORKING OF CUSTOM LOCALIZER: IT FIRST CHECKS IF THERE IS A SUPPORTED LANGUAGE FOR THE IDENTIFIER OF CURRENT DEVICE LOCALE (FOR EXAMPLE: 'en_US' OR 'nl_BE'), IF NOT FOUND, LOCALIZER CHECKS IF THERE IS A SUPPORTED LANGUAGECODE FOR THE CURRENT DEVICE LOCALE (FOR EXAMPLE: 'en' OR 'nl')
    
    
    
}
