//
//  CoinImageService.swift
//  Moonbag
//
//  Created by Minh Pham on 20/07/2022.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    @Published var image: UIImage? = nil

    private let coin: CoinModel
    var imageSubcription: AnyCancellable?
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinImage(urlString: coin.image)
    }

    private func getCoinImage (urlString: String) {
        guard let url = URL(string: urlString)
            else { return }

        imageSubcription = NetworkManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkManager.handleCompletion,
                  receiveValue: { [weak self] (returnedImage) in
                      self?.image = returnedImage
                      self?.imageSubcription?.cancel()
                  })
    }
}
