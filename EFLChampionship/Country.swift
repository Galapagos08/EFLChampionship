//
//  Country.swift
//  EFLChampionship
//
//  Created by Daniel Esrey on 29/05/2025.
//

import Foundation

struct Country: Codable, Identifiable, Hashable {
    let id: UUID = UUID()
    let name: String
    let code: String?
    let flag: URL?
}

struct CountriesResponse: Codable {
    let countries: [Country]

    private enum CodingKeys: String, CodingKey {
        case countries = "response"
    }
}
