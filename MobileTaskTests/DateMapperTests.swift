//
//  DateMapperTests.swift
//  MobileTaskTests
//
//  Created by Anton on 26/02/24.
//

import XCTest
@testable import MobileTask

final class DateMapperTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFormatDate() {
        let dateMapper = DateMapper()
        let dateUTC = "2023-12-31T09:30:00"
        let invalidTimezone = "invalid_timezone"
        let timezone = "America/Los_Angeles"
        
        let (invalidDate, _) = dateMapper.formatDate(stringDate: nil, timezone: nil)
        XCTAssertTrue(invalidDate == "", "Date should be empty string")
        
        let (date, time) = dateMapper.formatDate(stringDate: dateUTC, timezone: timezone)
        XCTAssertTrue(date == "December 31, 2023", "Date should be a formatted string")
        XCTAssertTrue(time == "1:30 AM", "Time should be in proper timezone")
        
        let (_, invalidTimezoneDate) = dateMapper.formatDate(stringDate: dateUTC, timezone: invalidTimezone)
        XCTAssertTrue(invalidTimezoneDate == "4:30 AM", "Time should be in EST timezone")
    }
}
