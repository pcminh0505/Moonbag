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

    var body: some View {
        ZStack {
            // Background layer
            Color.theme.background
                .ignoresSafeArea()

            // Content layer
            VStack {
                // Header
                homeHeader
                SearchBarView(searchText: $vm.searchText )

                // Body
                listColumns


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
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
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
        }
            .font(.caption)
            .foregroundColor(Color.theme.secondaryText)
            .padding(.horizontal)
    }

    private var coinList: some View {
        List {
            ForEach(vm.coinList) { coin in
                CardView(coin: coin)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
            .listStyle(PlainListStyle())
    }

    private var watchList: some View {
        List {
            ForEach(vm.watchList) { coin in
                CardView(coin: coin)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }

        }
            .listStyle(PlainListStyle())
    }
}
