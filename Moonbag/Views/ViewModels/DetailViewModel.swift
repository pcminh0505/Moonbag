/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 1
    Author: Pham Cong Minh
    ID: s3818102
    Created  date: 24/07/2022
    Last modified: 06/08/2022
    Acknowledgement: SwiftUI Thinking (https://www.youtube.com/c/SwiftfulThinking)
*/

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    @Published var marketData: [StatisticsModel] = []
    @Published var communityData: [StatisticsModel] = []
    @Published var securityData: [StatisticsModel] = []

    @Published var explorers: [String]? = nil
    @Published var blogs: [String]? = nil

    @Published var description: String? = nil
    @Published var homepage: String? = nil

    @Published var sentimentVotesUpPercentage: Double? = nil


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
            // Mapping data from both CoinModel and CoinDetailModel for desired output
            .map({ (coinDetailModel, coinModel) -> (
                market: [StatisticsModel],
                security: [StatisticsModel],
                community: [StatisticsModel],
                description: String?,
                homepage: String?,
                blogs: [String]?,
                explorers: [String]?,
                sentimentVotesUpPercentage: Double?) in

            // Market Data
            let marketCap = "$" + (coinModel.marketCap.formattedWithAbbreviations())
            let marketCapStat = StatisticsModel(title: "Market Cap", value: marketCap)

            let volume = "$" + (coinModel.totalVolume.formattedWithAbbreviations())
            let volumeStat = StatisticsModel(title: "Trading Volume", value: volume)

            let high = "$" + (coinModel.high24H.formattedWithAbbreviations())
            let highStat = StatisticsModel(title: "24h High", value: high)

            let low = "$" + (coinModel.low24H.formattedWithAbbreviations())
            let lowStat = StatisticsModel(title: "24h Low", value: low)

            let totalSupply = coinModel.totalSupply?.formattedWithAbbreviations() ?? "N/A"
            let totalSupplyStat = StatisticsModel(title: "Total Supply", value: totalSupply)

            let maxSupply = coinModel.maxSupply?.formattedWithAbbreviations() ?? "N/A"
            let maxSupplyStat = StatisticsModel(title: "Max Supply", value: maxSupply)

            let marketData: [StatisticsModel] = [marketCapStat, volumeStat, highStat, lowStat, totalSupplyStat, maxSupplyStat]

            // Developer Data
            let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
            let blockTimeString = blockTime == 0 ? "N/A" : "\(blockTime)"
            let blockTimeStat = StatisticsModel(title: "Block Time (mins)", value: blockTimeString)

            let hashing = coinDetailModel?.hashingAlgorithm ?? "N/A"
            let hashingStat = StatisticsModel(title: "Hashing Algorithm", value: hashing)

            let developerData: [StatisticsModel] = [blockTimeStat, hashingStat]

            // Community Data
            let reddit = coinDetailModel?.links?.subredditUrl ?? "N/A"
            let redditStat = StatisticsModel(title: "Reddit", value: reddit)

            let github = coinDetailModel?.links?.reposURL?.github?.first ?? ""
            let githubValue = github != "" ? "https://github.com/" + (github.slice(from: "github.com/", to: "/") ?? "") : "N/A"
            let githubStat = StatisticsModel(title: "github", value: githubValue)

            let twitter = coinDetailModel?.links?.twitterScreenName ?? ""
            let twitterValue = twitter != "" ? "https://www.twitter.com/" + twitter : "N/A"
            let twitterStat = StatisticsModel(title: "Twitter", value: twitterValue)

            let telegram = coinDetailModel?.links?.twitterScreenName ?? ""
            let telegramValue = twitter != "" ? "https://t.me/" + telegram : "N/A"
            let telegramStat = StatisticsModel(title: "Telegram", value: telegramValue)

            let facebook = coinDetailModel?.links?.facebookUsername ?? ""
            let facebookValue = facebook != "" ? "https://www.facebook.com/" + facebook : "N/A"
            let facebookStat = StatisticsModel(title: "Facebook", value: facebookValue)

            let communityData: [StatisticsModel] = [twitterStat, telegramStat, githubStat, redditStat, facebookStat]

            // Others
            let description = coinDetailModel?.readableDescription
            let homepage = coinDetailModel?.links?.homepage?.first

            let blogs = coinDetailModel?.links?.announcementURL?.filter { !$0.isEmpty }
            let explorers = coinDetailModel?.links?.blockchainSite?.filter { !$0.isEmpty }

            let sentimentPercentageUp = coinDetailModel?.sentimentVotesUpPercentage

            return (marketData, developerData, communityData, description, homepage, blogs, explorers, sentimentPercentageUp)
        })
            .sink { [weak self] (returnedData) in
            self?.marketData = returnedData.market
            self?.securityData = returnedData.security
            self?.communityData = returnedData.community
            self?.description = returnedData.description
            self?.homepage = returnedData.homepage
            self?.blogs = returnedData.blogs
            self?.explorers = returnedData.explorers
            self?.sentimentVotesUpPercentage = returnedData.sentimentVotesUpPercentage
        }
            .store(in: &cancellables)
    }
}
