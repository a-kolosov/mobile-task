//
//  EventViewModelTests.swift
//  MobileTaskTests
//
//  Created by Anton on 21/02/24.
//

import XCTest
@testable import MobileTask

final class EventsViewModelTests: XCTestCase {
    var eventsVM: EventsViewModel!
    var events: [Event]!

    override func setUpWithError() throws {
        events = generateTestEvents()
        eventsVM = EventsViewModel(events: events, networkManager: NetworkManager())
    }

    override func tearDownWithError() throws {
        eventsVM = nil
        events = nil
    }
    
    func testEvent() {
        let invalidEvent = eventsVM.event(at: 10)
        XCTAssertNil(invalidEvent, "Event should be nil with index out of bounds")
        
        let event = eventsVM.event(at: events.count - 1)
        XCTAssertNotNil(event, "Event shoudn't be nil")
    }
    
    func testEventTitle() {
        let invalidEvent = Event(id: 0, title: nil, location: nil, url: nil, dateUTC: nil, timezone: nil)
        let event = Event(id: 0, title: "some title", location: nil, url: nil, dateUTC: nil, timezone: nil)
        
        let invalidTitle = eventsVM.eventTitle(for: invalidEvent)
        XCTAssertTrue(invalidTitle == "", "Title should be an empty string")
        
        let title = eventsVM.eventTitle(for: event)
        XCTAssertTrue(title == "some title", "Title should be a string")
    }
    
    func testEventLocation() {
        let invalidEvent = Event(id: 0, title: nil, location: nil, url: nil, dateUTC: nil, timezone: nil)
        let event = Event(id: 0, title: nil, location: "some location", url: nil, dateUTC: nil, timezone: nil)
        
        let invalidLocation = eventsVM.eventLocation(for: invalidEvent)
        XCTAssertTrue(invalidLocation == "", "Location should be empty string")
        
        let location = eventsVM.eventLocation(for: event)
        XCTAssertTrue(location == "some location", "Location should be a string")
    }
    
    private func generateTestEvents() -> [Event] {
        let events = [Event(id: 0, title: nil, location: nil, url: nil, dateUTC: nil, timezone: nil),
                      Event(id: 0, title: "some title", location: nil, url: nil, dateUTC: nil, timezone: nil),
                      Event(id: 0, title: "some title", location: "some location", url: nil, dateUTC: nil, timezone: nil),
                      Event(id: 0, title: "some title", location: "some location", url: nil, dateUTC: "2023-12-31T09:30:00", timezone: "America/Los_Angeles")]
        return events
    }
}
