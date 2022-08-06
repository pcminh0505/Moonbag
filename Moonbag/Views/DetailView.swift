/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 1
    Author: Pham Cong Minh
    ID: s3818102
    Created  date: 22/07/2022
    Last modified: 06/08/2022
    Acknowledgement:
    - SwiftUI Thinking (https://www.youtube.com/c/SwiftfulThinking)
*/

import SwiftUI

@available(iOS 15.0, *)
struct DetailLoadingView: View {
    @Binding var coin: CoinModel?

    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

@available(iOS 15.0, *)
struct DetailView: View {
    let coin: CoinModel
    @StateObject var vm: DetailViewModel
    @EnvironmentObject var favorite: Favorites

    @State private var isFullDescriptionShowing: Bool = false

    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    private let spacing: CGFloat = 30

    init(coin: CoinModel) {
        self.coin = coin
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }

    var body: some View {
        ScrollView {

            VStack (spacing: 20) {
                HStack {
                    Text("\(coin.currentPrice.asCurrencyWith2Decimals())")
                        .font(.title)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)

                    ChangePercentageView(
                        changePercentage: coin.priceChangePercentage24H,
                        font: .title3
                    )
                }

                ChartView(coin: coin)
                

                VStack {
                    // Overview section + Description in English
                    Group {
                        Text("Overview")
                            .font(.title)
                            .bold()
                            .foregroundColor(Color.theme.accent)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        VStack (alignment: .leading) {
                            if let coinDescription = vm.description, !coinDescription.isEmpty {
                                Text(coinDescription)
                                    .lineLimit(isFullDescriptionShowing ? nil : 5)
                                    .font(.callout)
                                    .foregroundColor(Color.theme.secondaryText)
                                    .onTapGesture {
                                    withAnimation(.easeInOut) {
                                        isFullDescriptionShowing.toggle()
                                    }
                                }
                                Button {
                                    withAnimation(.easeInOut) {
                                        isFullDescriptionShowing.toggle()
                                    }
                                } label: {
                                    Text(isFullDescriptionShowing ? "Collapse" : "Read more...")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .padding(.vertical, 2)
                                }
                            }
                        }
                            .padding(.vertical, 5)


                        LazyVGrid(columns: columns,
                                  alignment: .leading,
                                  spacing: spacing,
                                  pinnedViews: []) {
                            ForEach(vm.marketData) { stat in
                                StatisticsView(stats: stat, isHeadline: false)
                            }
                        }
                        if let sentimentUp = vm.sentimentVotesUpPercentage, !String(format: "%f", sentimentUp).isEmpty {
                            CircleProgressBar(currentProgress: sentimentUp*0.75/100)
                        }
                    }

                    Group {
                        // Explorers Info
                        Text("Explorers")
                            .font(.title)
                            .bold()
                            .foregroundColor(Color.theme.accent)
                            .frame(maxWidth: .infinity, alignment: .leading)


                        VStack (alignment: .leading, spacing: 20) {
                            if let explorers = vm.explorers, !explorers.isEmpty {
                                ForEach(explorers, id: \.self) { link in
                                    if !link.isEmpty {
                                        let url = URL(string: link)
                                        Link(destination: url!) {
                                            HStack {
                                                Text(link)
                                                    .lineLimit(1)
                                                Spacer()
                                                Image(systemName: "link")
                                            }
                                        }
                                    }
                                }
                            }
                            else {
                                Text("N/A")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                            .padding(.vertical, 5)
                    }

                    Group {
                        // Blogs Info
                        Text("Blogs")
                            .font(.title)
                            .bold()
                            .foregroundColor(Color.theme.accent)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        VStack (alignment: .leading, spacing: 20) {
                            if let blogs = vm.blogs, !blogs.isEmpty {
                                ForEach(blogs, id: \.self) { link in
                                    if !link.isEmpty {
                                        let url = URL(string: link)
                                        Link(destination: url!) {
                                            HStack {
                                                Text(link)
                                                    .lineLimit(1)
                                                Spacer()
                                                Image(systemName: "link")
                                            }
                                        }
                                    }
                                }
                            } else {
                                Text("N/A")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                            .padding(.vertical, 5)

                    }


                    // Security Info
                    Text("Security")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color.theme.accent)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    LazyVGrid(columns: columns,
                              alignment: .leading,
                              spacing: spacing,
                              pinnedViews: []) {
                        ForEach(vm.securityData) { stat in
                            StatisticsView(stats: stat, isHeadline: false)
                        }
                    }
                    // Social Media Links
                    VStack {
                        if let homepage = vm.homepage, !homepage.isEmpty {
                            let url = URL(string: homepage)
                            Link(destination: url!) {
                                HStack {
                                    Text("Homepage")
                                        .font(.headline)
                                    Image(systemName: "link")
                                }

                            }
                        }
                        HStack {
                            ForEach(vm.communityData) { stat in
                                if stat.value != "N/A" {
                                    let url = URL(string: stat.value)
                                    Link(destination: url!) {
                                        Image("\(stat.title.lowercased())")
                                            .resizable()
                                            .frame(width: 35, height: 35)
                                    }

                                }
                            }
                        }
                    }
                        .padding(.top, 20)
                }
                    .padding(.top, 200)
            }
                .navigationTitle(vm.coin.name)
                .padding()
                .toolbar {
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    HStack {
                        Button {
                            if favorite.contains(coin) {
                                favorite.remove(coin)
                            } else {
                                favorite.add(coin)
                            }
                        } label: {
                            favorite.contains(coin) ?
                            Image(systemName: "star.fill").foregroundColor(Color.yellow)
                            :
                                Image(systemName: "star").foregroundColor(Color.yellow)

                        }
                        Text(vm.coin.symbol.uppercased())
                            .font(.headline)
                            .foregroundColor(Color.theme.secondaryText)
                        CoinImageView(coin: vm.coin)
                            .frame(width: 25, height: 25)
                    }
                })
            }
        }
    }
}
@available(iOS 15.0, *)
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: dev.coin)
        }
            .preferredColorScheme(.light)
            .environmentObject(Favorites())
    }
}
