//
//  TeamsGridView.swift
//  EFLChampionship
//
//  Created by Daniel Esrey on 30/05/2025.
//

import SwiftUI

struct TeamsGridView: View {
    @Environment(TeamsData.self) var teamsData

    let columns = [GridItem(.adaptive(minimum: 150))]

    var body: some View {
        @Bindable var teamsData = teamsData

        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(teamsData.teams) { teamObj in
                        NavigationLink {
                            TeamDetailView(team: teamObj)
                        } label: {
                            VStack {
                                AsyncImage(url: teamObj.team.logo)
                                { phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .scaledToFit()
                                    } else if phase.error != nil {
                                        Image(systemName: "soccerball")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundStyle(.black)
                                    } else {
                                        ProgressView()
                                    }
                                }
                                .frame(height: 80)
                                Text(teamObj.team.name)
                                    .font(.headline)
                                    .foregroundStyle(.black)
                                Text(teamObj.venue.name)
                                    .font(.caption)
                                    .foregroundStyle(.black)
                            }
                            .padding([.horizontal, .vertical])
                        }

                    }
                }
            }
            
            .navigationTitle("Teams")
            .onAppear {
                Task {
                    await teamsData.loadTeams()
                }
            }
        }
    }
}

#Preview {
    TeamsGridView()
        .environment(TeamsData())
}
