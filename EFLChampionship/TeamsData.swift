//
//  TeamsData.swift
//  EFLChampionship
//
//  Created by Daniel Esrey on 30/05/2025.
//

import Foundation

@Observable
class TeamsData {
    var teams: [TeamObject] = []
    //    {
    //        let response: CountriesResponse = Bundle.main.decode("countriesResponse.json")
    //        return response.countries
    //    }

    func loadTeams() async {
        let response: TeamsResponse = Bundle.main.decode("leagueTwo2023TeamsResponse.json")
        print(response)
        self.teams = response.teams
//        do {
//            let response: TeamsResponse = try await URLSession.shared.decode(from: Bundle.main.url(forResource: "leagueTwo2023TeamsResponse", withExtension: "json")!) //  Bundle.main.decode("countriesResponse.json")
//            print(response)
//            self.teams = response.teams
//        } catch {
//            print(error.localizedDescription)
//        }
    }
}
