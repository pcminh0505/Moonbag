/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 1
    Author: Pham Cong Minh
    ID: s3818102
    Created  date: 20/07/2022
    Last modified: dd/mm/yyyy
    Acknowledgement: Acknowledge the resources that you use here.
*/

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var coinList: [CoinModel] = []
    @Published var watchList: [CoinModel] = []
    
    @Published var searchText: String = ""

    private let coinDataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()

    init () {
        addSubcribers()
    }

    func addSubcribers() {
        coinDataService.$coinList
            .sink { [weak self] (decodedCoins) in
            self?.coinList = decodedCoins
            }
            .store(in: &cancellables)
    }
}
