/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 1
    Author: Pham Cong Minh
    ID: s3818102
    Created  date: 25/07/2022
    Last modified: 06/08/2022
    Acknowledge: ChartView Github (https://github.com/AppPear/ChartView)
*/

import SwiftUI
import SwiftUICharts

struct ChartView: View {
    let coin: CoinModel

    let chartStyle = ChartStyle(
        backgroundColor: Color.theme.background,
        accentColor: Color.theme.accent,
        gradientColor: GradientColors.green,
        textColor: Color.theme.primaryText,
        legendTextColor: Color.theme.secondaryText.opacity(0.0001),
        dropShadowColor: Color.gray
    )
    

    var body: some View {
        ZStack {
            LineView(
                data: coin.sparklineIn7D?.price ?? [],
                title: "",
                style: chartStyle
            )
        }
        .frame(maxHeight: 350)
            .padding(.top, -50)
            .padding(.bottom, 50)
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
    }
}
