//
//  TeamDetailView.swift
//  EFLChampionship
//
//  Created by Daniel Esrey on 30/05/2025.
//

import SwiftUI

struct TeamDetailView: View {
    var team: TeamObject

    var body: some View {
        VStack {
            AsyncImage(url: team.team.logo)
            { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .containerRelativeFrame(.horizontal) { width, axis in
                            width * 0.6
                        }
                } else if phase.error != nil {
                    Image(systemName: "soccerball")
                        .resizable()
                        .scaledToFit()
                } else {
                    ProgressView()
                }
            }
                Text(team.team.name)
                    .font(.headline)
                Text(team.venue.name)
                    .font(.caption)
            VStack(alignment: .leading) {
                DividerView()
            }
        }
    }
}

#Preview {
    TeamDetailView(team: .example)
}
