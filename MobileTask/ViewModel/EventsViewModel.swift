//
//  EventViewModel.swift
//  MobileTask
//
//  Created by Anton on 21/02/24.
//

import Foundation
import Combine
import UIKit

class EventsViewModel: ObservableObject {
    private lazy var dateMapper = DateMapper()
    
    private let networkManager: NetworkManagerProtocol
    private var cancellable = Set<AnyCancellable>()
    private var events: [Event] = []
    
    enum State {
        case idle
        case loading
        case failed(Error)
        case loaded([Event])
    }
    
    @Published private(set) var state = State.idle
    @Published var showingAlert = false
    
    init(events: [Event], networkManager: NetworkManagerProtocol) {
        self.events = events
        self.networkManager = networkManager
    }
    
    func fetchEvents() {
        self.state = .loading
        
        //Simulate long network loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.networkManager.fetch(.events, type: Events.self)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] status in
                    switch status {
                    case .finished:
                        break
                    case .failure(let error):
                        self?.state = .failed(error)
                        break
                    } }, receiveValue: { [weak self] data in
                        self?.events = data.events
                        self?.state = .loaded(data.events)
                    })
                .store(in: &self.cancellable)
        }
    }
    
    func event(at index: Int) -> Event? {
        if index < 0 || index > events.count - 1 {
            return nil
        }
        return events[index]
    }
    
    func eventTitle(for event: Event) -> String {
        guard let title = event.title else {
            return ""
        }
        return title
    }
    
    func eventLocation(for event: Event) -> String {
        guard let location = event.location else {
            return ""
        }
        return location
    }
    
    func eventDate(for event: Event) -> (date: String, time: String) {
        return dateMapper.formatDate(stringDate: event.dateUTC, timezone: event.timezone)
    }
    
    func openEventURL(for event: Event) {
        if let url = eventURL(for: event) {
            UIApplication.shared.open(url)
        } else {
            showingAlert = true
        }
    }
    
    private func eventURL(for event: Event) -> URL? {
        guard let stringURL = event.url else {
            return nil
        }
        
        return URL(string: stringURL)
    }
}
