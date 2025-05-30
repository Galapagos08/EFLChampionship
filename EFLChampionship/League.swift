//
//  League.swift
//  EFLChampionship
//
//  Created by Daniel Esrey on 29/05/2025.
//

import Foundation

struct League: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let type: String?
    let logo: URL?
}

struct LeagueResponse: Codable {
    let league: League
    let country: Country
    let seasons: [String]
}
