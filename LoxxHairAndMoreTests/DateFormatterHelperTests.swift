//
//  DateFormatterHelperTests.swift
//  Loxx Hair and MoreTests
//
//  Created by Vidal on 21/11/2022.
//

import XCTest
@testable import LoxxHairAndMore

class DateFormatterHelperTests: XCTestCase {
    
    let userDefaults = UserDefaults()
    
    let dfh = DateFormatterHelper(openingTimes: [""], closingTimes: [""])
    
    let dummyOpeningTimes = [MyConstants.closed_timestamp_notation, "11:00:00", "11:00:00", "11:00:00", "11:00:00", "9:30:00", MyConstants.opened_twentyfour_seven_timestamp_notation]
    
    let dummyClosingTimes = [MyConstants.closed_timestamp_notation, "19:00:00", "19:00:00", "19:00:00", "19:00:00", "13:30:00", MyConstants.opened_twentyfour_seven_timestamp_notation]
    
    func testSpecialNotation(){
                
        XCTAssertEqual(dfh.convertTimeToAppropriateTimeFormatting(iso8601_object: MyConstants.closed_timestamp_notation, index: 0), userDefaults.string(forKey: MyConstants.closed_notation_key))
        XCTAssertEqual(dfh.convertTimeToAppropriateTimeFormatting(iso8601_object: MyConstants.opened_twentyfour_seven_timestamp_notation, index: 0), userDefaults.string(forKey: MyConstants.opened_twentyfour_seven_key))
        
    }
    
    func testHours(){

        for hour in 0...9 {
            
            XCTAssertNotEqual(dfh.convertTimeToAppropriateTimeFormatting(iso8601_object: "0\(hour):00:00", index: 0), userDefaults.string(forKey: MyConstants.closed_notation_key))
            
        }
        
        for hour in 10...24 {
            
            XCTAssertNotEqual(dfh.convertTimeToAppropriateTimeFormatting(iso8601_object: "\(hour):00:00", index: 0), userDefaults.string(forKey: MyConstants.closed_notation_key))
            
        }
        
    }
    
    func testMinutes(){
        
        for minute in 0...9 {
            
            XCTAssertNotEqual(dfh.convertTimeToAppropriateTimeFormatting(iso8601_object: "00:0\(minute):00", index: 0), userDefaults.string(forKey: MyConstants.closed_notation_key))
            
        }
        
        for minute in 10...59 {
            
            XCTAssertNotEqual(dfh.convertTimeToAppropriateTimeFormatting(iso8601_object: "00:\(minute):00", index: 0), userDefaults.string(forKey: MyConstants.closed_notation_key))
            
        }
        
    }
    
    func testSeconds(){
        
        for second in 0...9 {
            
            XCTAssertNotEqual(dfh.convertTimeToAppropriateTimeFormatting(iso8601_object: "00:00:0\(second)", index: 0), userDefaults.string(forKey: MyConstants.closed_notation_key))
            
        }
        
        for second in 10...59 {
            
            if (second != 12 && second != 24) {
                //TODO: MAKE GLOBAL CONTSTANT VALUES OF ALL SPECIAL TIMESTAMPS, PUT THESE INTO ARRAY, LOOP TROUGH ARRAY TO CHECK IF CURRENT INDEX IS NOT A SPECIAL TIMESTAMP, IF NO, ALLOW ASSERTNOTEQUAL FOR LOOP TO BE RUN ON GIVEN INDEX
                
                XCTAssertNotEqual(dfh.convertTimeToAppropriateTimeFormatting(iso8601_object: "00:00:\(second)", index: 0), userDefaults.string(forKey: MyConstants.closed_notation_key))
                
            }
            
        }
        
    }
    
    func testIfAmountOpeningClosingHoursIsAlwaysSeven(){
        
        
        
    }

    func testPerformance() throws {
        // This is an example of a performance test case.
                
        measure {
            
            DateFormatterHelper(openingTimes: dummyOpeningTimes, closingTimes: dummyClosingTimes).convertISO8601ObjectsToTimesArray()
            
        }
    }
    
    // measure how fast a list of correct iso8061 timestamps can be formatted

}
