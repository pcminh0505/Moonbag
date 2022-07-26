//
//  PercentageChangeView.swift
//  Moonbag
//
//  Created by Minh Pham on 25/07/2022.
//

import SwiftUI

struct ChangePercentageView: View {
    let changePercentage: Double
    let font: Font

    var body: some View {

        HStack {
            Image(systemName: "triangle.fill")
                .font(font)
                .rotationEffect(Angle(degrees: changePercentage >= 0 ? 0 : 180))
            Text(changePercentage.asPercentString())
                .font(font)
        }
            .foregroundColor(
            changePercentage >= 0 ?
            Color(.systemGreen):
                Color(.systemRed)

        )
    }
}

struct ChangePercentageView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePercentageView(changePercentage: -10.0, font: .caption)
    }
}
