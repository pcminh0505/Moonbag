//
//  DetailView.swift
//  Moonbag
//
//  Created by Minh Pham on 22/07/2022.
//

import SwiftUI

struct DetailLoadingView: View {
    @Binding var coin: CoinModel?

    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    let coin: CoinModel
    @StateObject var vm: DetailViewModel

    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    private let spacing: CGFloat = 30

    init(coin: CoinModel) {
        self.coin = coin
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }

    var body: some View {
        VStack (spacing: 20) {
            HStack {
                Text("\(coin.currentPrice.asCurrencyWith2Decimals())")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)

                ChangePercentageView(
                    changePercentage: coin.priceChangePercentage24H,
                    font: .title3
                )
            }
            
            ChartView(coin: coin)
                
            
            Text("Overview")
                .font(.title)
                .bold()
                .foregroundColor(Color.theme.accent)
                .frame(maxWidth: .infinity, alignment: .leading)

            LazyVGrid(columns: columns,
                      alignment: .leading,
                      spacing: spacing,
                      pinnedViews: []) {
                ForEach(vm.marketData) { stat in
                    StatisticsView(stats: stat)
                }
            }

            Text("Additional")
                .font(.title)
                .bold()
                .foregroundColor(Color.theme.accent)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
            .navigationTitle(vm.coin.name)
            .padding()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: dev.coin)
        }
            .preferredColorScheme(.dark)

    }
}
