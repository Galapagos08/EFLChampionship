//
//  CountriesListView.swift
//  EFLChampionship
//
//  Created by Daniel Esrey on 29/05/2025.
//

import SwiftUI

struct CountriesListView: View {
    @Environment(CountriesData.self) var countriesData

    var body: some View {
        @Bindable var countriesData = countriesData

        NavigationStack{
            List(countriesData.countries) { country in
                NavigationLink("\(country.name)") {
                    Text("Detail \(country.name)")
                }
            }
            .navigationTitle("Countries")
        }
        .onAppear() {
            Task {
                await countriesData.loadCountries()
            }
        }
    }
}

#Preview {
    CountriesListView()
        .environment(CountriesData())
}
