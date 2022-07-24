//
//  StatisticsView.swift
//  Moonbag
//
//  Created by Minh Pham on 24/07/2022.
//

import SwiftUI

struct StatisticsView: View {
    let stats: StatisticsModel
    
    var body: some View {
        VStack (alignment: .leading, spacing: 4) {
            Text(stats.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
            Text(stats.value)
                .font(.headline)
                .foregroundColor(Color.theme.primaryText)
        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView(stats: dev.stats)
    }
}
