//
//  NetworkManager.swift
//  MobileTask
//
//  Created by Anton on 21/02/24.
//

import Foundation
import Combine

enum APIError: LocalizedError {
  case invalidRequestError(String)
}

enum APIEndpoint {
    case events
    case custom(urlString: String)
}

class NetworkManager: NetworkManagerProtocol {
    private let urlString = "https://api.seatgeek.com/2/events"
    // in prod app token should be stored in keychain for security reasons, usually you get it via auth request
    private let token = "MjE3MTU3MjV8MTYxODQxMDMzNS44NzY4MDQ4"
    
    func fetch<T: Decodable>(_ endpoint: APIEndpoint, type: T.Type) -> AnyPublisher<T, Error> {
        var url: URL?
        switch endpoint {
        case .events:
            url = formEventsURL(stringURL: urlString, token: token)
        case .custom(let customString):
            url = formEventsURL(stringURL: customString, token: "")
        }
        return fetch(from: url)
    }
    
    private func fetch<T: Decodable>(from url: URL?) -> AnyPublisher<T, Error> {
        guard let url else {
            return Fail(error: APIError.invalidRequestError("Invalid URL")).eraseToAnyPublisher()
        }
        let dataTaskPublisher = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { element -> Data in
                        guard let response = element.response as? HTTPURLResponse,
                                (200...299).contains(response.statusCode) else {
                            throw URLError(.badServerResponse)
                        }
                        return element.data
                    }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        return dataTaskPublisher
    }
    
    private func formEventsURL(stringURL: String, token: String? = nil) -> URL? {
        let queryItems = [URLQueryItem(name: "client_id", value: token)]
        var urlComponents = URLComponents(string: stringURL)
        urlComponents?.queryItems = queryItems
        return urlComponents?.url
    }
}
