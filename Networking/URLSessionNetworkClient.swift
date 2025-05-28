//
//  URLSessionNetworkClient.swift
//  OpenFoods
//
//  Created by Daniel Esrey on 13/04/2025.
//

import Foundation
import os

public final class URLSessionNetworkClient {
    private let networkLogger = Logger(subsystem: "com.openTable.OpenFoods.app", category: "network")

    private let session: URLSession

    public init(session: URLSession = URLSession.shared) {
        self.session = session
    }
}

extension URLSessionNetworkClient: NetworkClientProtocol {
    public func request<T: Decodable>(_ endpoint: EndpointProtocol) async throws -> T {
        var request: URLRequest
        do {
            let makeRequestResult = try endpoint.urlRequest().get()
            request = makeRequestResult
        } catch {
            networkLogger.error("\(#function) Failed to create URLRequest: \(error.localizedDescription)")
            throw NetworkError.invalidRequest
        }
        logRequest(request)

        let (data, response) = try await session.data(for: request)
        try handleResponse(data: data, response: response)
        if let responseString = String(data: data, encoding: .utf8) {
            networkLogger.debug("\(#function) Response Body: \(responseString, privacy: .private(mask: .hash))")
        }
        let decoding: Result<T, NetworkError> = decode(data)
        switch decoding {
        case .success(let value):
            return value
        case .failure(let error):
            self.networkLogger.error("\(#function) Decoding failed: \(error.localizedDescription)")
            throw error
        }
    }

    private func decode<T: Decodable>(_ data: Data) -> Result<T, NetworkError> {
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: data)
            return .success(decodedData)
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
            return .failure(NetworkError.decodingFailure)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            return .failure(NetworkError.decodingFailure)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            return .failure(NetworkError.decodingFailure)
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
            return .failure(NetworkError.decodingFailure)
        } catch {
            print("error: ", error)
            self.networkLogger.info("\(#function) Failed to decode \(data, privacy: .public)")
            self.networkLogger.error("\(#function) Decoding failed: \(error.localizedDescription)")
            return .failure(NetworkError.decodingFailure)
        }
    }

    private func handleResponse(data: Data, response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            networkLogger.info("\(#function) Invalid response type")
            throw NetworkError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            networkLogger.error("\(#function) request failed, status code: \(httpResponse.statusCode)")

            if httpResponse.statusCode == 404 {
                throw NetworkError.foodNotFound
            }
            throw NetworkError.requestFailed(statusCode: httpResponse.statusCode)
        }
    }

    private func logRequest(_ request: URLRequest) {
        networkLogger.info("\(#function) Request url: \(request.url?.absoluteString ?? "Unknown URL", privacy: .private(mask: .hash))")
        networkLogger.info("\(#function) Request method: \(request.httpMethod ?? "Unknown method", privacy: .public)")
    }
}
