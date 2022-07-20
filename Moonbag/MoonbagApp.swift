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

@main
struct MoonbagApp: App {
    @StateObject private var vm = HomeViewModel()

    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(vm)
        }
    }
}
