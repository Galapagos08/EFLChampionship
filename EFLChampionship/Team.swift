//
//  Team.swift
//  EFLChampionship
//
//  Created by Daniel Esrey on 30/05/2025.
//

import Foundation

struct Team: Codable, Identifiable {
    let id: Int
    let name: String
    let code: String?
    let country: String
    let founded: Int?
    let national: Bool
    let logo: URL?

    static let example: Team = Team(
        id: 1837,
        name: "Wrexham",
        code: "WRE",
        country: "Wales",
        founded: 1872,
        national: false,
        logo: URL(string: "https://media.api-sports.io/football/teams/1837.png")
    )

}

struct Venue: Codable, Identifiable {
    let id: Int
    let name: String
    let address: String?
    let city: String
    let capacity: Int
    let image: URL?

    static let example: Venue = Venue(
        id: 19926,
        name: "ST\(UnicodeScalar("\u{014d}"))K Cae Ras",
        address: "Mold Road",
        city: "Wrexham",
        capacity: 19118,
        image: URL(string: "https://media.api-sports.io/football/venues/1000.png")
    )
}

struct TeamObject: Codable, Identifiable {
    let team: Team
    let venue: Venue

    var id: Int {
        team.id
    }

    static let example: TeamObject = TeamObject(
        team: .example,
        venue: .example
    )
}

struct TeamsResponse: Codable {
    let teams: [TeamObject]

    private enum CodingKeys: String, CodingKey {
        case teams = "response"
    }
}
