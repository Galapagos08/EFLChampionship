//
//  EndpointProtocol.swift
//  OpenFoods
//
//  Created by Daniel Esrey on 13/04/2025.
//

import Foundation

public protocol EndpointProtocol {
    var baseURL: URL { get }

    var path: String { get }

    var method: HTTPMethod { get }

    var headers: [String: String]? { get }

    var parameters: [String: Any]? { get }

    var body: Data? { get }

    func urlRequest() -> Result<URLRequest, NetworkError>

}

extension EndpointProtocol {

    public var baseURL: URL {
        URL(string: Bundle.main.infoDictionary?["BASE_URL"] as? String ?? "")!
    }

    public func urlRequest() -> Result<URLRequest, NetworkError> {
        guard let urlComponents = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: true) else {
            return .failure(NetworkError.invalidURL)
        }

        guard let url = urlComponents.url else {
            return .failure(NetworkError.invalidURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        return .success(request)
    }
}
