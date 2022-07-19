//
//  CardView.swift
//  Moonbag
//
//  Created by Minh Pham on 19/07/2022.
//

import SwiftUI

struct CardView: View {
    let coin : CoinModel

    var body: some View {
        HStack {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
            Circle()
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(Color.theme.primaryText)
            Spacer()
            VStack(alignment: .trailing) {
                Text("\(coin.currentPrice.asCurrencyWith2Decimals())")
                    .bold()
                    .foregroundColor(Color.theme.primaryText)
                    
                Text(coin.priceChangePercentage24H.asPercentString())
                    .foregroundColor(
                    coin.priceChangePercentage24H >= 0 ?
                    Color(uiColor: .systemGreen):
                        Color(uiColor: .systemRed)
                )
            }
        }
        .font(.subheadline)

    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CardView(coin: dev.coin)
                .previewLayout(.sizeThatFits)
            
            CardView(coin: dev.coin)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
        
    }
}
