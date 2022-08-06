/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 1
    Author: Pham Cong Minh
    ID: s3818102
    Created  date: 20/07/2022
    Last modified: 06/08/2022
    Acknowledgement: SwiftUI Thinking (https://www.youtube.com/c/SwiftfulThinking)
*/

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var coinList: [CoinModel] = []
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    @Published var statistics: [StatisticsModel] = []
    @Published var sortOption: SortOption = .rank


    private let coinDataService = CoinDataService()
    private let marketDataService = MarketService()
    private var cancellables = Set<AnyCancellable>()

    enum SortOption {
        case rank, rankReversed, change24h, change24hReversed, price, priceReversed
    }

    init () {
        addSubcribers()
    }

    func addSubcribers() {
        // Update coinList
        $searchText
            .combineLatest(coinDataService.$coinList, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSort)
            .sink { [weak self](returnedCoins) in
            self?.coinList = returnedCoins
            self?.isLoading = false
        }
            .store(in: &cancellables)

        marketDataService.$marketData
            .map({ (marketDataModel) -> [StatisticsModel] in
            var stats: [StatisticsModel] = []

            guard let data = marketDataModel else {
                return stats
            }

            let marketCap = StatisticsModel(title: "Market Cap", value: data.marketCap)
            let volume = StatisticsModel(title: "24h Volume", value: data.volume)
            let btcDominance = StatisticsModel(title: "BTC Dom", value: data.btcDominance)

            stats.append(contentsOf: [
                marketCap,
                volume,
                btcDominance
            ])

            return stats
        })
            .sink { [weak self] (returnedData) in
            self?.statistics = returnedData
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
                coin.id.lowercased().contains(lowercasedText) }
    }

    // Inout : Return the same input to the output -> Work like Pointer
    private func sortCoins(sort: SortOption, coins: inout [CoinModel]) {
        switch sort {
        case .rank:
            coins.sort(by: { $0.rank < $1.rank })
        case .rankReversed:
            coins.sort(by: { $0.rank > $1.rank })
        case .change24h:
            coins.sort(by: { $0.priceChangePercentage24H > $1.priceChangePercentage24H })
        case .change24hReversed:
            coins.sort(by: { $0.priceChangePercentage24H < $1.priceChangePercentage24H })
        case .price:
            coins.sort(by: { $0.currentPrice > $1.currentPrice })
        case .priceReversed:
            coins.sort(by: { $0.currentPrice < $1.currentPrice })
        }
    }

    private func filterAndSort(text: String, coins: [CoinModel], sort: SortOption) -> [CoinModel] {
        var updatedCoins = filterByText(text: text, coins: coins)
        // Sort
        sortCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
    }
}


