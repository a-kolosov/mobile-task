//
//  EventViewModelProtocol.swift
//  MobileTask
//
//  Created by Anton on 21/02/24.
//

import Foundation

protocol EventsViewModelProtocol {
    func eventTitle() -> String?
    func eventLocation() -> String?
    func eventDate() -> String?
    func eventTime() -> String?
}
