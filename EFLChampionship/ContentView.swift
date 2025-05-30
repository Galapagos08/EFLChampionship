//
//  ContentView.swift
//  EFLChampionship
//
//  Created by Daniel Esrey on 27/05/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TeamsListView()
    }
}

#Preview {
    ContentView()
        .environment(TeamsData())
}
