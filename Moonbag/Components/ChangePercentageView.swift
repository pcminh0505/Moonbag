/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 1
    Author: Pham Cong Minh
    ID: s3818102
    Created  date: 25/07/2022
    Last modified: 06/08/2022
*/


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
                .lineLimit(1)
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
