/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 1
    Author: Pham Cong Minh
    ID: s3818102
    Created  date: 20/07/2022
    Last modified: dd/mm/yyyy
    Acknowledgement:
    - DesignCode.io: https://designcode.io/swiftui-advanced-handbook-http-request
    - CoinGeckoAPI URL: https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=7d
    - SwiftUI Thinking (https://www.youtube.com/c/SwiftfulThinking)
*/

import SwiftUI
import Combine

class CoinDataService: ObservableObject {
    @Published var coinList: [CoinModel] = []

    var coinSubcription: AnyCancellable?

    init () {
        getCoinData()
    }

    private func getCoinData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=7d")
            else { return }

        coinSubcription = NetworkManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion,
                  receiveValue: { [weak self] (returnedCoins) in
                      self?.coinList = returnedCoins
                      self?.coinSubcription?.cancel()
                  })
    }
}
