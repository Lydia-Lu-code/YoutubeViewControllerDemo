//
//
//
////import Foundation
////
////struct Welcome: Codable {
////    let items: [Item]
////}
////
////struct Item: Codable {
////    let id: String
////    let snippet: Snippet
////    let statistics: Statistics
////}
////
////struct Snippet: Codable {
////    let channelID, title, categoryID: String
////
////    enum CodingKeys: String, CodingKey {
////        case channelID = "channelId"
////        case title
////        case categoryID = "categoryId"
////    }
////}
////
////struct Statistics: Codable {
////    let viewCount, likeCount, favoriteCount, commentCount: String
////}
//import Foundation
//
//struct Welcome: Codable {
//    let kind, etag: String
//    let items: [Item]
//    let pageInfo: PageInfo
//}
//
//struct Item: Codable {
//    let kind, etag, id: String
//    let snippet: Snippet
//    let statistics: Statistics
//}
//
//struct Snippet: Codable {
//    let publishedAt: Date
//    let channelID, title, description: String
//    let thumbnails: Thumbnails
//    let channelTitle: String
//    let tags: [String]
//    let categoryID, liveBroadcastContent, defaultLanguage: String
//    let localized: Localized
//    let defaultAudioLanguage: String
//
//    enum CodingKeys: String, CodingKey {
//        case publishedAt
//        case channelID = "channelId"
//        case title, description, thumbnails, channelTitle, tags
//        case categoryID = "categoryId"
//        case liveBroadcastContent, defaultLanguage, localized, defaultAudioLanguage
//    }
//}
//
//struct Localized: Codable {
//    let title, description: String
//}
//
//struct Thumbnails: Codable {
//    let thumbnailsDefault, medium, high, standard: Default
//    let maxres: Default
//
//    enum CodingKeys: String, CodingKey {
//        case thumbnailsDefault = "default"
//        case medium, high, standard, maxres
//    }
//}
//
//struct Default: Codable {
//    let url: String
//    let width, height: Int
//}
//
//struct Statistics: Codable {
//    let viewCount, likeCount, favoriteCount, commentCount: String
//}
//
//struct PageInfo: Codable {
//    let totalResults, resultsPerPage: Int
//}
