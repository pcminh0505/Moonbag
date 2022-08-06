/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 1
    Author: Pham Cong Minh
    ID: s3818102
    Created  date: 24/07/2022
    Last modified: 06/08/2022
*/

import SwiftUI

struct StatisticsView: View {
    let stats: StatisticsModel
    let isHeadline: Bool
    
    var body: some View {
        VStack (alignment: isHeadline ? .center :.leading, spacing: 4) {
            Text(stats.title)
                .font(isHeadline ? .headline : .caption)
                .foregroundColor(isHeadline ? Color.theme.primaryText : Color.theme.secondaryText)
            Text(stats.value)
                
                .font(.headline)
                .foregroundColor(isHeadline ? Color.theme.accent : Color.theme.primaryText)
        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView(stats: dev.stats, isHeadline: true)
    }
}
