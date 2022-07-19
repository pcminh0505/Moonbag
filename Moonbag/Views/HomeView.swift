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

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.theme.accent
                .ignoresSafeArea()
            
            VStack {
                Text("Hello World")
                Spacer()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.light)
    }
}
