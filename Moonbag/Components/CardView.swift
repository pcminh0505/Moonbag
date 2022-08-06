/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 1
    Author: Pham Cong Minh
    ID: s3818102
    Created  date: 19/07/2022
    Last modified: 06/08/2022
*/

import SwiftUI

@available(iOS 15.0, *)
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
                        .frame(width: 23, height: 20, alignment: .center)
                        .overlay(
                        Text("\(coin.rank)")
                            .foregroundColor(Color.theme.secondaryText)
                            .font(.caption2)
                    )


                    Text(coin.symbol.uppercased())
                        .font(.caption)
                        .foregroundColor(Color.theme.secondaryText)
                    ChangePercentageView(
                        changePercentage: coin.priceChangePercentage24H,
                        font: .caption
                    )
                }
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

@available(iOS 15.0, *)
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
