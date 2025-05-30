//
//  TeamsListView.swift
//  EFLChampionship
//
//  Created by Daniel Esrey on 30/05/2025.
//

import SwiftUI

struct TeamsListView: View {
    @Environment(TeamsData.self) var teamsData

    var body: some View {
        @Bindable var teamsData = teamsData

        NavigationStack{
            List(teamsData.teams) { teamObj in
                NavigationLink {
                    TeamDetailView(team: teamObj)
                } label: {
                    TeamRowView(team: teamObj)
                }
            }
            .navigationTitle("Teams")
        }
        .onAppear() {
            Task {
                await teamsData.loadTeams()
            }
        }
    }
}

#Preview {
    TeamsListView()
        .environment(TeamsData())
}
