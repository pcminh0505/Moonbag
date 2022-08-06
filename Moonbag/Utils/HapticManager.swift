/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 1
    Author: Pham Cong Minh
    ID: s3818102
    Created  date: 20/07/2022
    Last modified: 21/07/2022
    Acknowledgement: SwiftUI Thinking (https://www.youtube.com/c/SwiftfulThinking)
*/

import Foundation
import SwiftUI

// HapticManager enables vibration when reloading
class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
    
}
