//
//  Bundle-Extention.swift
//  OpenFoods
//
//  Created by Daniel Esrey on 13/04/2025.
//

import Foundation
import os

extension Bundle {
    func decode<T: Codable>(
        _ file: String,
        dateFormat: String = "y-MM-dd",
        decodingStrategy: JSONDecoder.DateDecodingStrategy? = nil
    ) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            Logger().critical("Failed to locate \(file) in bundle.")
            fatalError()
        }
        guard let data = try? Data(contentsOf: url) else {
            Logger().critical("Failed to load \(file) from bundle.")
            fatalError()
        }

        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        decoder.dateDecodingStrategy = decodingStrategy ?? .formatted(formatter)

        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            Logger().critical("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' – \(context.debugDescription)")
            fatalError()
        } catch DecodingError.typeMismatch(_, let context) {
            Logger().critical("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
            fatalError()
        } catch DecodingError.valueNotFound(let type, let context) {
            Logger().critical("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
            fatalError()
        } catch DecodingError.dataCorrupted(_) {
            Logger().critical("Failed to decode \(file) from bundle because it appears to be invalid JSON.")
            fatalError()
        } catch {
            Logger().critical("Failed to decode \(file) from bundle: \(error.localizedDescription)")
            fatalError()
        }
    }

}
