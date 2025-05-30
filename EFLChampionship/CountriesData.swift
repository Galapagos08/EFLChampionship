//
//  CountriesData.swift
//  EFLChampionship
//
//  Created by Daniel Esrey on 29/05/2025.
//

import Foundation

@Observable
class CountriesData {
    var countries: [Country] = []
    //    {
    //        let response: CountriesResponse = Bundle.main.decode("countriesResponse.json")
    //        return response.countries
    //    }

    func loadCountries() async {
        do {
            let response: CountriesResponse = try await URLSession.shared.decode(from: Bundle.main.url(forResource: "countriesResponse", withExtension: "json")!) //  Bundle.main.decode("countriesResponse.json")
            print(response)
            self.countries = response.countries
        } catch {
            print(error.localizedDescription)
        }
    }
}
