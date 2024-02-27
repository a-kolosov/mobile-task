//
//  NetworkManagerProtocol.swift
//  MobileTask
//
//  Created by Anton on 21/02/24.
//

import Foundation
import Combine

protocol NetworkManagerProtocol {
    func fetch<T: Decodable>(_ endpoint: APIEndpoint, type: T.Type) -> AnyPublisher<T, Error>
}
