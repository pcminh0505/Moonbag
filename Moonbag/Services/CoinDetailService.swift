/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 1
    Author: Pham Cong Minh
    ID: s3818102
    Created  date: 23/07/2022
    Last modified: 06/08/2022
*/

import SwiftUI
import Combine

// CoinDetailService call to /coins/{id} API to get token's detail information
class CoinDetailService: ObservableObject {
    @Published var coinDetail: CoinDetailModel? = nil

    var coinDetailSubcription: AnyCancellable?
    let coin: CoinModel

    init (coin: CoinModel) {
        self.coin = coin
        getCoinDetail()
    }

    func getCoinDetail() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false")
            else { return }

        coinDetailSubcription = NetworkManager.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion,
                  receiveValue: { [weak self] (returnedCoin) in
                      self?.coinDetail = returnedCoin
                      self?.coinDetailSubcription?.cancel()
                  })
    }
}
