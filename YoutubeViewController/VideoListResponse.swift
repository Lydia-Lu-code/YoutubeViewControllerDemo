import Foundation

// https://www.googleapis.com/youtube/v3/videos?key=AIzaSyC1LUGmn3kwNecr13UCLwOQEDhn7h6r5Co&chart=mostPopular&maxResults=5&regionCode=TW&part=snippet,contentDetails,statistics


struct Welcome: Codable {
    let kind, etag: String
    let items: [Item]
    let nextPageToken: String
    let pageInfo: PageInfo
}

struct Item: Codable {
    let kind, etag, id: String
    let snippet: Snippet
    let contentDetails: ContentDetails
    let statistics: Statistics
}

struct ContentDetails: Codable {
    let duration, dimension, definition, caption: String
    let licensedContent: Bool
    let contentRating: ContentRating
    let projection: String
}

struct ContentRating: Codable {
}

struct Snippet: Codable {
//    let publishedAt: Date
    let publishedAt: String
    let channelID, title, description: String
    let thumbnails: Thumbnails
    let channelTitle: String
    let tags: [String]?
    let categoryID, liveBroadcastContent: String
    let localized: Localized
    let defaultAudioLanguage: String
    let defaultLanguage: String?

    enum CodingKeys: String, CodingKey {
        case publishedAt
        case channelID = "channelId"
        case title, description, thumbnails, channelTitle, tags
        case categoryID = "categoryId"
        case liveBroadcastContent, localized, defaultAudioLanguage, defaultLanguage
    }
}

struct Localized: Codable {
    let title, description: String
}

struct Thumbnails: Codable {
    let thumbnailsDefault, medium, high, standard: Default
    let maxres: Default

    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault = "default"
        case medium, high, standard, maxres
    }
}

struct Default: Codable {
    let url: String
    let width, height: Int
}

struct Statistics: Codable {
    let viewCount: String
//    let likeCount: String
//    let favoriteCount: String
//    let commentCount: String
}

struct PageInfo: Codable {
    let totalResults, resultsPerPage: Int
}
