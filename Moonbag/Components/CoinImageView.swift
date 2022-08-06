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

import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false

    private let coin: CoinModel
    private let coinImageService: CoinImageService
    private var cancellables = Set<AnyCancellable>()

    init (coin: CoinModel) {
        self.coin = coin
        self.coinImageService = CoinImageService(coin: coin)
        self.addSubcribers()
    }

    private func addSubcribers() {
        coinImageService.$image
            .sink { [weak self] (_) in
            self?.isLoading = false
        } receiveValue: { [weak self] (returnedImage) in
            self?.image = returnedImage
        }
        .store(in: &cancellables)

    }
}

struct CoinImageView: View {
    @StateObject var vm: CoinImageViewModel

    
    init (coin: CoinModel) {
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading {
                ProgressView()

            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(Color.theme.secondaryText)
            }
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: dev.coin)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
