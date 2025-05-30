//
//  DividerView.swift
//  EFLChampionship
//
//  Created by Daniel Esrey on 30/05/2025.
//

import SwiftUI

struct DividerView: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(Color.gray)
            .padding(.vertical)
    }
}

#Preview {
    DividerView()
}
