//
//  NetworkManagerTests.swift
//  MobileTaskTests
//
//  Created by Anton on 22/02/24.
//

import XCTest
import Combine
@testable import MobileTask

final class NetworkManagerTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        cancellables = []
    }

    override func tearDownWithError() throws {
        cancellables = nil
    }
    
    func testFetchEvents_invalidURL() {
        let networkManager = NetworkManager()
        var error: Error?
        let invalidEndpoint = APIEndpoint.custom(urlString: "someURL")
        
        let expectation = self.expectation(description: "Fetch Events")
        networkManager.fetch(invalidEndpoint, type: Events.self)
            .sink { status in
                switch status {
                case .failure(let encounteredError):
                    error = encounteredError
                case .finished:
                    break
                }
                expectation.fulfill()
            } receiveValue: { _ in
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 5)
        XCTAssertNotNil(error)
    }
    
    func testFetchEvent_invalidOutput() {
        let networkManager = NetworkManager()
        var error: Error?
        let eventsEndpoint = APIEndpoint.events
        
        let expectation = self.expectation(description: "Fetch Events")
        networkManager.fetch(eventsEndpoint, type: Int.self)
            .sink { status in
                switch status {
                case .failure(let encounteredError):
                    error = encounteredError
                case .finished:
                    break
                }
                expectation.fulfill()
            } receiveValue: { _ in
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 5)
        XCTAssertNotNil(error)
    }
    
    func testFetchEvents() throws {
        let networkManager = NetworkManager()
        var receivedValue: Any? = nil
        var error: Error?
        let eventsEndpoint = APIEndpoint.events
        let expectation = self.expectation(description: "Fetch Events")
        
        networkManager.fetch(eventsEndpoint, type: Events.self)
            .sink { status in
                switch status {
                case .failure(let encounteredError):
                    error = encounteredError
                case .finished:
                    break
                }
                expectation.fulfill()
            } receiveValue: { value in
                receivedValue = value
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 5)
        XCTAssertNil(error)
        XCTAssertNotNil(receivedValue as? Events)
    }
}
