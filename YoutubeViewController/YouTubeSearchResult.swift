
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct SearchWelcome: Codable {
    let kind, etag, nextPageToken, regionCode: String
    let SearchpageInfo: SearchPageInfo
    let Searchitems: [SearchItem]
}

// MARK: - Item
struct SearchItem: Codable {
    let kind, etag: String
    let id: SearchID
    let snippet: SearchSnippet
}

// MARK: - ID
struct SearchID: Codable {
    let kind, videoID: String

    enum CodingKeys: String, CodingKey {
        case kind
        case videoID = "videoId"
    }
}

// MARK: - Snippet
struct SearchSnippet: Codable {
    let publishedAt: Date
    let channelID, title, description: String
    let thumbnails: SearchThumbnails
    let channelTitle, liveBroadcastContent: String
    let publishTime: Date

    enum CodingKeys: String, CodingKey {
        case publishedAt
        case channelID = "channelId"
        case title, description, thumbnails, channelTitle, liveBroadcastContent, publishTime
    }
}

// MARK: - Thumbnails
struct SearchThumbnails: Codable {
    let thumbnailsDefault, medium, high: SearchDefault

    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault = "default"
        case medium, high
    }
}

// MARK: - Default
struct SearchDefault: Codable {
    let url: String
    let width, height: Int
}

// MARK: - PageInfo
struct SearchPageInfo: Codable {
    let totalResults, resultsPerPage: Int
}

