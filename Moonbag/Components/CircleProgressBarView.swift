//
/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 1
    Author: Pham Cong Minh
    ID: s3818102
    Created  date: 05/08/2022
    Last modified: 06/08/2022
    Acknowledge Github(https://github.com/Enryun/SwiftUICircleProgressBar)
*/

import SwiftUI

@available(iOS 15.0, *)
struct CircleProgressBar: View {

    @State var progress: Double = 0
    var currentProgress: Double

    var color: Color {

        var colorCircle = Color.red

        if currentProgress >= 0.60 {
            colorCircle = Color.green
        } else if currentProgress >= 0.45 {
            colorCircle = Color.teal
        } else if currentProgress >= 0.30 {
            colorCircle = Color.yellow
        } else if currentProgress >= 0.15 {
            colorCircle = Color.orange
        } else {
            colorCircle = Color.red
        }

        return colorCircle
    }

    var body: some View {
        CircleProgressBarTest(progress: progress, color: color)
            .frame(width: 200, height: 200)
            .padding(10)
            .onAppear {
            withAnimation(.easeInOut(duration: 2)) {
                self.progress = currentProgress
            }
        }
    }
}


struct CircleProgressBarTest: View {

    var progress: Double
    var color: Color

    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 0.75)
                .stroke(style: StrokeStyle(lineWidth: 18, lineCap: .round, lineJoin: .round))
                .opacity(0.2)
                .rotationEffect(Angle(degrees: 135))
                .foregroundColor(.gray)

            Circle()
                .trim(from: 0, to: CGFloat(min(self.progress, 1)))
                .stroke(style: StrokeStyle(lineWidth: 12, lineCap: .round, lineJoin: .round))
                .foregroundColor(color)
                .rotationEffect(Angle(degrees: 135))
            VStack (spacing: 10){
                Text("Sentiment Up")
                    .font(.headline)
                    .foregroundColor(Color.theme.secondaryText)
                Text((progress*100/0.75).asPercentString())
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color.theme.primaryText)
            }

        }
    }
}



@available(iOS 15.0, *)
struct CircleProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        CircleProgressBar(currentProgress: 0.33)
    }
}
