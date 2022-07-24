/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 1
    Author: Pham Cong Minh
    ID: s3818102
    Created  date: 20/07/2022
    Last modified: dd/mm/yyyy
    Acknowledgement: SwiftUI Thinking (https://www.youtube.com/c/SwiftfulThinking)
*/

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var coinList: [CoinModel] = []
    @Published var watchList: [CoinModel] = []
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""

    private let coinDataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()

    init () {
        addSubcribers()
    }

    func addSubcribers() {
        // Update coinList
        $searchText
            .combineLatest(coinDataService.$coinList)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterByText)
            .sink { [weak self](returnedCoins) in
                self?.coinList = returnedCoins
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoinData()
        HapticManager.notification(type: .success)
    }
    
    private func filterByText(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }

        let lowercasedText = text.lowercased()

        return coins.filter { (coin) -> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||
                coin.symbol.lowercased().contains(lowercasedText) ||
                coin.id.lowercased().contains(lowercasedText)}
    }
    
    
}


