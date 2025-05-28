//
//  NetworkClientProtocol.swift
//  OpenFoods
//
//  Created by Daniel Esrey on 13/04/2025.
//

import Foundation

public protocol NetworkClientProtocol {
    func request<T: Decodable>(_ endpoint: EndpointProtocol) async throws -> T
}
