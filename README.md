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
| Home Screen  | Detail Screen | 
| ------------- | ------------- | 
| ![ezgif-4-e47005c6c5](https://user-images.githubusercontent.com/54668379/201658146-0b6b4856-dc4a-4bfd-b367-f7c3cf8e5d28.gif) |  ![Simulator Screen Recording - iPhone 14 Pro - 2022-11-11 at 22 34 54](https://user-images.githubusercontent.com/54668379/201657999-2d6a0294-d4d2-435a-ac0a-5bce7ad6f1cc.gif) | 

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
