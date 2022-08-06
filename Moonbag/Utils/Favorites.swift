/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 1
    Author: Pham Cong Minh
    ID: s3818102
    Created  date: 05/08/2022
    Last modified: 06/08/2022
    Acknowledgement: HackingWithSwift (
    - Favorites: https://www.hackingwithswift.com/books/ios-swiftui/letting-the-user-mark-favorites
    - UserDefault: https://www.hackingwithswift.com/books/ios-swiftui/storing-user-settings-with-userdefaults
*/

import Foundation

// Favorites class keep track of favorite list accross the app 
class Favorites: ObservableObject {
    private var coins: Set<String>
    private let saveKey = "Favorites"

    init() {
        // Load from UserDefault
        if UserDefaults.standard.object(forKey: "watchlist") != nil {
            let data = UserDefaults.standard.array(forKey: "watchlist") as? [String] ?? []
            coins = Set(data)
        } else {
            // if not self init
            coins = []
        }
    }

    func contains(_ coin: CoinModel) -> Bool {
        coins.contains(coin.id)
    }

    func add(_ coin: CoinModel) {
        objectWillChange.send()
        coins.insert(coin.id)
        save()
    }

    func remove(_ coin: CoinModel) {
        objectWillChange.send()
        coins.remove(coin.id)
        save()
    }

    func save() {
        // Save back to UserDefault
        UserDefaults.standard.set(Array(coins), forKey: "watchlist")
    }
}
