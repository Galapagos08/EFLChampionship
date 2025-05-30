//
//  EFLChampionshipApp.swift
//  EFLChampionship
//
//  Created by Daniel Esrey on 27/05/2025.
//

import SwiftUI

@main
struct EFLChampionshipApp: App {
    @State private var countriesData = CountriesData()
    @State private var teamsData = TeamsData()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(countriesData)
                .environment(teamsData)
        }
    }
}
