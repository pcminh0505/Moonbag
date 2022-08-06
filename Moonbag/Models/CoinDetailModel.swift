/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 1
    Author: Pham Cong Minh
    ID: s3818102
    Created  date: 23/07/2022
    Last modified: 06/08/2022
*/

import Foundation

struct CoinDetailModel: Codable {
    let id, symbol, name: String?
    let blockTimeInMinutes: Int?
    let hashingAlgorithm: String?
    let description: Description?
    let links: Links?
    let sentimentVotesUpPercentage, sentimentVotesDownPercentage: Double?

    enum CodingKeys: String, CodingKey {
        case id, symbol, name, description, links
        case blockTimeInMinutes = "block_time_in_minutes"
        case hashingAlgorithm = "hashing_algorithm"
        case sentimentVotesUpPercentage = "sentiment_votes_up_percentage"
        case sentimentVotesDownPercentage = "sentiment_votes_down_percentage"
    }

    var readableDescription: String? {
        return description?.en?.removingHTMLOccurances
    }
}

struct Links: Codable {
    let homepage: [String]? // Main info
    let blockchainSite, announcementURL: [String]? // Explorer & Announcement
    let twitterScreenName, facebookUsername, telegramChannelIdentifier, subredditUrl: String? // Community
    let reposURL: ReposURL? // Developer src code

    enum CodingKeys: String, CodingKey {
        case homepage
        case blockchainSite = "blockchain_site"
        case announcementURL = "announcement_url"
        case twitterScreenName = "twitter_screen_name"
        case facebookUsername = "facebook_username"
        case telegramChannelIdentifier = "telegram_channel_identifier"
        case subredditUrl = "subreddit_url"
        case reposURL = "repos_url"
    }
}

struct Description: Codable {
    let en: String?
}

struct ReposURL: Codable {
    let github: [String]?

    enum CodingKeys: String, CodingKey {
        case github
    }
}
