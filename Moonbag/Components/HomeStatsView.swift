/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 1
    Author: Pham Cong Minh
    ID: s3818102
    Created  date: 05/08/2022
    Last modified: 06/08/2022
    Acknowledgement: SwiftUI Thinking (https://www.youtube.com/c/SwiftfulThinking)
*/

import SwiftUI

struct HomeStatsView: View {
    @EnvironmentObject private var vm: HomeViewModel
    var body: some View {
        HStack {
            ForEach(vm.statistics) { stats in
                StatisticsView(stats: stats, isHeadline: true)
                    .frame(width: UIScreen.main.bounds.width / 3)

            }
        }
            .frame(width: UIScreen.main.bounds.width,
                   alignment: .center)
    }
}

struct HomeStatsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatsView()
            .environmentObject(dev.homeVM)
    }
}
