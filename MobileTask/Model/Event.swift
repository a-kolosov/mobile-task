//
//  Event.swift
//  MobileTask
//
//  Created by Anton on 21/02/24.
//

import Foundation

struct Event: Decodable, Identifiable {
    let id: Int
    let title: String?
    let location: String?
    let url: String?
    let dateUTC: String?
    let timezone: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case location
        case url
        case dateUTC = "datetime_utc"
        case timezone
        case venue
        
        enum VenueCodingKeys: String, CodingKey {
            case address
            case timezone
        }
    }
    
    init(id: Int, title: String?, location: String?, url: String?, dateUTC: String?, timezone: String?) {
        self.id = id
        self.title = title
        self.location = location
        self.url = url
        self.dateUTC = dateUTC
        self.timezone = timezone
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.dateUTC = try container.decodeIfPresent(String.self, forKey: .dateUTC)
        
        let venueContainer = try container.nestedContainer(keyedBy: CodingKeys.VenueCodingKeys.self, forKey: .venue)
        self.location = try venueContainer.decodeIfPresent(String.self, forKey: .address)
        self.timezone = try venueContainer.decodeIfPresent(String.self, forKey: .timezone)
    }
}

struct Events: Decodable {
    let events: [Event]
}
