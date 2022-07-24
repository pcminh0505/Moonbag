//
//  DetailViewModel.swift
//  Moonbag
//
//  Created by Minh Pham on 24/07/2022.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    let coin: CoinModel
    private let coinDetailService: CoinDetailService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailService = CoinDetailService(coin: coin)
//        self.addSubcribers()
    }
    
//    private func addSubcribers() {
//        coinDetailService.$coinDetail
////            .sink { (returnedCoin) in
////                print("Hello")
////            }
//            .store(in: &cancellables)
//    }
}
