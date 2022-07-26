//
//  DetailViewModel.swift
//  Moonbag
//
//  Created by Minh Pham on 24/07/2022.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {

    @Published var overviewData: [StatisticsModel] = []
    @Published var marketData: [StatisticsModel] = []
    @Published var communityData: [StatisticsModel] = []
    @Published var developerData: [StatisticsModel] = []

    @Published var coin: CoinModel
    private let coinDetailService: CoinDetailService
    private var cancellables = Set<AnyCancellable>()

    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailService = CoinDetailService(coin: coin)
        self.addSubcribers()
    }

    private func addSubcribers() {
        coinDetailService.$coinDetail
            .combineLatest($coin)
            .map({ (coinDetailModel, coinModel) -> (
//                overview: [StatisticsModel],
//                community: [StatisticsModel],
                market: [StatisticsModel],
                developer: [StatisticsModel]) in
                
                // Market Data
                let marketCap = "$" + (coinModel.marketCap.formattedWithAbbreviations())
                let marketCapStat = StatisticsModel(title: "Market Cap", value: marketCap)
                
                let volume = "$" + (coinModel.totalVolume.formattedWithAbbreviations())
                let volumeStat = StatisticsModel(title: "Trading Volume", value: volume)
                
                let high = "$" + (coinModel.high24H.formattedWithAbbreviations())
                let highStat = StatisticsModel(title: "24h High", value: high)
                
                let low = "$" + (coinModel.low24H.formattedWithAbbreviations())
                let lowStat = StatisticsModel(title: "24h Low", value: low)
                
                let marketData: [StatisticsModel] = [marketCapStat, volumeStat, highStat, lowStat]

                // Developer Data
                let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
                let blockTimeString = blockTime == 0 ? "N/A" : "\(blockTime)"
                let blockTimeStat = StatisticsModel(title: "Block Time", value: blockTimeString)
                
                let hashing = coinDetailModel?.hashingAlgorithm ?? "N/A"
                let hashingStat = StatisticsModel(title: "Hashing Algorithm", value: hashing)
                
                let developerData: [StatisticsModel] = [blockTimeStat, hashingStat]
                
                return (marketData, developerData)
        })
        .sink { [weak self] (returnedData) in
            self?.marketData = returnedData.market
            self?.developerData = returnedData.developer
        }
        .store(in: &cancellables)
    }
}
