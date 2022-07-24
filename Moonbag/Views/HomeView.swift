/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 1
    Author: Pham Cong Minh
    ID: s3818102
    Created  date: 19/07/2022
    Last modified: dd/mm/yyyy
    Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm: HomeViewModel

    @State private var showWatchlist: Bool = false
    @State private var selectedCoin: CoinModel? = nil
    @State private var isViewingDetail: Bool = false

    var body: some View {
        ZStack (alignment: .top) {
            // Background layer
            Color.theme.background
                .ignoresSafeArea()

            VStack {
                // Header
                homeHeader
                SearchBarView(searchText: $vm.searchText)

                // Body
                listColumns

                if (vm.coinList.count == 0) {
                    Text("Fetching data...")
                        .font(.caption)
                } else {
                    if !showWatchlist {
                        coinList
                            .transition(.move(edge: .leading))

                    }
                    if showWatchlist {
                        watchList
                            .transition(.move(edge: .trailing))
                    }
                }
            }
        }
            .background(
            NavigationLink(
                destination: DetailLoadingView(coin: $selectedCoin),
                isActive: $isViewingDetail,
                label: { EmptyView() })
        )

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.light)
            .environmentObject(dev.homeVM)
    }
}


extension HomeView {

    private var homeHeader: some View {
        HStack {
            LottieView(name: "rocket", loopMode: .loop)
                .frame(width: 80, height: 80)
            Spacer()
            Text(showWatchlist ? "My Watchlist" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showWatchlist ? 180 : 0))
                .onTapGesture {
                withAnimation(.spring()) {
                    showWatchlist.toggle()
                }
            }
        }
            .padding(.horizontal)
    }

    private var listColumns: some View {
        HStack {
            Text("Coin")
            Spacer()
            Text("Price")

            Button {
                withAnimation(.linear(duration: 1.0)) {
                    vm.reloadData()
                }
            } label: {
                Image(systemName: "goforward")
            }
                .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0), anchor: .center)

        }
            .font(.caption)
            .foregroundColor(Color.theme.secondaryText)
            .padding(.horizontal)
    }

    private var coinList: some View {
        List {
            ForEach(vm.coinList) { coin in
                CardView(coin: coin)
                    .listRowInsets(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .onTapGesture {
                    seque(coin: coin)
                }
            }
        }
            .listStyle(PlainListStyle())

    }

    private func seque(coin: CoinModel?) {
        selectedCoin = coin;
        isViewingDetail.toggle()
    }

    private var watchList: some View {
        List {
            ForEach(vm.watchList) { coin in
                CardView(coin: coin)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
                .listStyle(PlainListStyle())
        }
    }
}
