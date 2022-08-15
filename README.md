# Moonbag

A lite and customized version of [CoinMarketCap](https://coinmarketcap.com/mobile/), using [CoinGecko Public API](https://www.coingecko.com/en/api/documentation), for my daily market tracking activity.

## 📦 Package Dependencies

Please double check and add those into the project. `Reset package caches` and `Update package caches` when there's any problem with packages before building the app.

- [Lottie](https://github.com/airbnb/lottie-ios)
- [SwiftUICharts](https://github.com/AppPear/ChartView)

## ⚡️ Features

- Animated Lottie Splash Screen
- Navigation View-Link between top 150 tokens and their details
- Search and Sort implementation for fetched list
- Detail view with 7d sparkline, Sentiment Upvote Scale, and other projects' essential links to
- Create and permanently store user's favorite list (with `UserDefaults`)
- SwipeActions on Row (supported by iOS `15.0 or higher`) to quickly add/remove tokens to/from favorite list.
- Light and Dark mode supported (based on System Settings)

## 📱 Screenshots
| Home Screen  | Watchlist Screen | Detail Screen |
| ------------- | ------------- | ------------- |
| ![Picture1](https://user-images.githubusercontent.com/54668379/184583651-e84533e4-8ae7-4a2b-9ffe-8af16b393510.png)  | ![Picture2](https://user-images.githubusercontent.com/54668379/184583658-39b94d00-269d-42c3-a685-b133572e0888.png)  | ![Picture3](https://user-images.githubusercontent.com/54668379/184583662-c65e1411-9adb-4f31-9258-70d0ef52160d.png) |

| Sort by Rank  | Sort by 24h Change % | Search by name with sort filter |
| ------------- | ------------- | ------------- |
| ![Picture4](https://user-images.githubusercontent.com/54668379/184583666-eae2e659-4aa5-448b-86d0-ec482afe7000.png) | ![Picture5](https://user-images.githubusercontent.com/54668379/184583668-aee9dfda-0b79-4dba-a2fa-b530eec5c752.png)  | ![Picture6](https://user-images.githubusercontent.com/54668379/184583673-0fc3a389-2555-4338-aee7-d10ae13fcbb3.png) |

| 7d Sparkline Chart  | Sentiment Analysis Scale | Project's Links |
| ------------- | ------------- | ------------- |
| ![Picture7](https://user-images.githubusercontent.com/54668379/184583676-b70f1f66-1560-410b-9ec1-ee2e5710b6ef.png)  | ![Picture8](https://user-images.githubusercontent.com/54668379/184583680-a6b4fb47-7c12-4015-b43e-0f3056041693.png)  | ![Picture9](https://user-images.githubusercontent.com/54668379/184583681-b973fe33-4548-4c8d-a75c-9b0d69c4b089.png) |

| Swipe Action (Short)  | Swipe Action (Full) | Watchlist Swipe Action |
| ------------- | ------------- | ------------- |
| ![Picture10](https://user-images.githubusercontent.com/54668379/184583682-a08f77b0-0899-4e34-9fc5-f8e49e9640c9.png)  | ![Picture11](https://user-images.githubusercontent.com/54668379/184583683-71c2ed70-1304-4813-961e-6e21e3aaa3b3.png)  | ![Picture12](https://user-images.githubusercontent.com/54668379/184583685-15d1ded8-e81b-4f00-84db-a568cb8ed8c3.png) |

| Darkmode Launch Screen | Darkmode Home Screen | Darkmode Detail Screen |
| ------------- | ------------- | ------------- |
| ![Picture13](https://user-images.githubusercontent.com/54668379/184583687-4345e388-2a1e-4fc8-88c2-12ffc0bbc40a.png)  | ![Picture14](https://user-images.githubusercontent.com/54668379/184583688-1d1ba056-f246-434d-8403-472490c98df8.png)  | ![Picture15](https://user-images.githubusercontent.com/54668379/184583691-b2d261d8-f344-44aa-92f5-810e546693c6.png) |

## ⚠️ Limitations

- `swipeActions` on 2 lists that sharing the same view can sometimes cause broken UI (as experienced in this [stackoverflow](https://stackoverflow.com/questions/71777287/swiftui-incorrect-ui-when-switching-to-a-new-list-from-an-old-one-with-swipe-bu) also)
- `lottie` is still written on UIKit and sometimes not looping as expected in the main screen.

## 📖 Acknowledgement

- SwiftUI Thinking Youtube Channel on [SwiftUI Crypto App](https://www.youtube.com/playlist?list=PLwvDm4Vfkdphbc3bgy_LpLRQ9DDfFGcFu) for main idea, project setup, UI/UX, animation, API handling,...

* Components:
  - [Lottie](https://github.com/airbnb/lottie-ios): For animated launch screen and home icon
  - [SwiftUICharts](https://github.com/AppPear/ChartView): For sparkline chart
  - [CircularProgressBar](https://github.com/Enryun/SwiftUICircleProgressBar): For sentiment upvote percentage analysis

## 🛠 Build Info

- Xcode 13.4.1
- SwiftUI
- iPhone supported only (iPhone 8 or higher screen)
- Target iOS version: 15.0 or higher (since there's `swipeActions` that only available from the new iOS)
