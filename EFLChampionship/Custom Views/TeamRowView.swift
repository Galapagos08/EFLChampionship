//
//  TeamRowView.swift
//  EFLChampionship
//
//  Created by Daniel Esrey on 30/05/2025.
//

import SwiftUI

struct TeamRowView: View {
    var team: TeamObject
    
    var body: some View {
        HStack {
            AsyncImage(url: team.team.logo)
            { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else if phase.error != nil {
                    Image(systemName: "fork.knife.circle")
                        .resizable()
                        .scaledToFit()
                } else {
                    ProgressView()
                }
            }
                .frame(width: 80, height: 80)
            VStack(alignment: .leading) {
                Text(team.team.name)
                    .font(.headline)
                Text(team.venue.name)
                    .font(.caption)
            }
        }
    }
}

#Preview {
    TeamRowView(team: .example)
}
