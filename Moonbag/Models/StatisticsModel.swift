/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 1
    Author: Pham Cong Minh
    ID: s3818102
    Created  date: 24/07/2022
    Last modified: 06/08/2022
*/

import Foundation

class StatisticsModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    
    init(title: String, value: String) {
        self.title = title
        self.value = value
    }
}
