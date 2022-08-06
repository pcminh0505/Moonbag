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
@main
struct MoonbagApp: App {
    @StateObject private var vm = HomeViewModel()
    @StateObject var favorites = Favorites()
    
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(vm)
                .environmentObject(favorites)
        }
    }
}
