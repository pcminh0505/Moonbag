/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 1
    Author: Pham Cong Minh
    ID: s3818102
    Created  date: 19/07/2022
    Last modified: 06/08/2022
    Acknowledgement:
    - SwiftUI Thinking (https://www.youtube.com/c/SwiftfulThinking)
    - HackingWithSwift (https://www.hackingwithswift.com/quick-start/swiftui/how-to-add-custom-swipe-action-buttons-to-a-list-row)
*/

import SwiftUI

@available(iOS 15.0, *)
struct HomeView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @EnvironmentObject var favorite: Favorites
    
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
                HomeStatsView()
                    .padding(.vertical, 10)
                // Body
                listColumns

                if (vm.coinList.count == 0) {
                    VStack {
                        HStack {
                            Image(systemName: "wifi.slash")
                            Text("No Internet Connection")
                        }
                            .padding()
                        Text("Please connect to Wifi or Cellular Data!")
                    }
                        .foregroundColor(Color.theme.secondaryText)
                        .font(.headline)
                        .padding()

                } else {
                    if !showWatchlist {
                        coinList
                            .transition(.move(edge: .leading))

                    }
                    if showWatchlist {
                        if vm.coinList.filter { favorite.contains($0) }.count != 0 {
                            watchList
                                .transition(.move(edge: .trailing))
                        } else {
                            VStack (alignment: .center) {
                                HStack {
                                    Image(systemName: "star")
                                        .environment(\.symbolVariants, .none)
                                    Text("No favorite coin found!")
                                }
                                    .padding()
                                Text("Start adding by swipping right on home list rows" + "\n" + "or clicking ⭐️ in detail view")
                                    .font(.caption)
                                    .multilineTextAlignment(.center)
                            }
                                .foregroundColor(Color.theme.secondaryText)
                                .font(.headline)
                                .padding()
                        }
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

@available(iOS 15.0, *)
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
            .environmentObject(dev.homeVM)
            .environmentObject(Favorites())
    }
}


@available(iOS 15.0, *)
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
            HStack (spacing: 4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }
                .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }
            }

            Spacer()
            HStack (spacing: 4) {
                Text("24h Change")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .change24h || vm.sortOption == .change24hReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .change24h ? 0 : 180))
            }
                .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .change24h ? .change24hReversed : .change24h
                }
            }
            Spacer()
            HStack (spacing: 4) {
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .price || vm.sortOption == .priceReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
                Text("Price")
            }
                .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                }
            }
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
                    .swipeActions(edge: .trailing, content: {
                    if favorite.contains(coin) {
                        Button {
                            favorite.remove(coin)
                        } label: {
                            Label("Remove from Watchlist", systemImage: "star")
                        }
                            .tint(.red)
                    } else {
                        Button {
                            favorite.add(coin)
                        } label: {
                            Label("Add to Watchlist", systemImage: "star")
                                .environment(\.symbolVariants, .none)
                        }
                            .tint(.green)

                    }
                })
            }
                .listRowBackground(Color.theme.background)
        }
            .listStyle(PlainListStyle())

    }

    private func seque(coin: CoinModel?) {
        selectedCoin = coin;
        isViewingDetail.toggle()
    }

    private var watchList: some View {
        List {
            ForEach(vm.coinList.filter { favorite.contains($0) }) { coin in
                CardView(coin: coin)
                    .listRowInsets(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .onTapGesture {
                    seque(coin: coin)
                }
                    .swipeActions(edge: .trailing) {
                    Button {
                        favorite.remove(coin)
                    } label: {
                        Label("Remove from Watchlist", systemImage: "star")
                    }
                        .tint(.red)
                }
            }
                .listRowBackground(Color.theme.background)
        }
            .listStyle(PlainListStyle())
    }
}
