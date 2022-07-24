//
//  CardView.swift
//  Moonbag
//
//  Created by Minh Pham on 19/07/2022.
//

import SwiftUI

struct CardView: View {
    let coin: CoinModel

    var body: some View {
        HStack {
            CoinImageView(coin: coin)
                .frame(width: 35, height: 35)

            VStack(alignment: .leading, spacing: 5) {
                Text(coin.name)
                    .font(.headline)
                    .foregroundColor(Color.theme.primaryText)
                HStack {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.theme.cardBackground)
                        .shadow(radius: 3)
                        .frame(width: 15, height: 15, alignment: .center)
                        .overlay(
                        Text("\(coin.rank)")
                            .foregroundColor(Color.theme.secondaryText)
                            .font(.caption)
                    )


                    Text(coin.symbol.uppercased())
                        .font(.caption)
                        .foregroundColor(Color.theme.secondaryText)
                    HStack {
                        Image(systemName: "triangle.fill")
                            .font(.caption2)
                            .rotationEffect(Angle(degrees: coin.priceChangePercentage24H >= 0 ? 0 : 180))
                        Text(coin.priceChangePercentage24H.asPercentString())
                            .font(.caption)
                    }
                        .foregroundColor(
                        coin.priceChangePercentage24H >= 0 ?
                        Color(.systemGreen):
                            Color(.systemRed)

                    ) }
            }
            Spacer()

            VStack(alignment: .trailing, spacing: 9) {
                Text("\(coin.currentPrice.asCurrencyWith2Decimals())")
                    .bold()
                    .foregroundColor(Color.theme.primaryText)
                Text("MCap \(coin.marketCap.formattedWithAbbreviations())")
                    .font(.caption)
                    .foregroundColor(Color.theme.secondaryText)
            }
        }
            .font(.subheadline)
            .background(Color.theme.background)

    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CardView(coin: dev.coin)
                .previewLayout(.sizeThatFits)

            CardView(coin: dev.coin)
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
        }

    }
}
