/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 1
    Author: Pham Cong Minh
    ID: s3818102
    Created  date: 20/07/2022
    Last modified: 06/08/2022
*/

import Foundation
import SwiftUI
import Combine

// CoinImageService returns the image data from url inside CoinModel
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
