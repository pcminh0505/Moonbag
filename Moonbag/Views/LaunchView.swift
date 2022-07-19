/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 1
    Author: Pham Cong Minh
    ID: s3818102
    Created  date: 19/07/2022
    Last modified: dd/mm/yyyy
    Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI
import Lottie

struct LaunchView: View {
    @State var isActive: Bool = false
    @State var opacity = 0.0

    var body: some View {
        VStack {
            if self.isActive {
                HomeView()
            } else {
                LottieView(name: "rocket")
                    .frame(width: 350, height: 300)
                    
                Text("Track and Manage Crypto Assets Easily")
                    .foregroundColor(Color.theme.primaryText).opacity(opacity)
                    .font(.headline)
                    .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                        withAnimation {
                            self.opacity = 1.0
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            self.opacity = 0.0
                        }
                    }
                }
                    .padding(.bottom, 100)
                
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.opacity = 0.0
                    self.isActive = true
                }
            }
        }

    }

    struct LaunchView_Previews: PreviewProvider {
        static var previews: some View {
            LaunchView()
        }
    }
}
