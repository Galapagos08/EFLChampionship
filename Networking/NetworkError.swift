//
//  NetworkError.swift
//  OpenFoods
//
//  Created by Daniel Esrey on 13/04/2025.
//

import Foundation

public enum NetworkError: Error {
    case invalidURL
    case requestFailed(statusCode: Int)
    case invalidResponse
    case invalidRequest
    case decodingFailure
    case networkError(Error)
    case decodingError(Error)
    case foodNotFound
}
