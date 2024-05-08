//import Foundation
//
//
//// YouTube 搜索結果模型
//struct YouTubeSearchResult: Codable {
//    let kind: String? // 搜索結果的類型
//    let etag: String? // 標記搜索結果的版本
//    let nextPageToken: String // 下一頁的令牌
//    let regionCode: String // 地區代碼
//    let pageInfo: PageInfo // 頁面信息
//    let items: [YouTubeSearchItem]? // 搜索結果項目
//}
//// 頁面信息結構
//struct PageInfo: Codable {
//    let totalResults: Int // 總結果數量
//    let resultsPerPage: Int // 每頁結果數量
//}
//
//// YouTube 搜索項目結構
//struct YouTubeSearchItem: Codable {
//    let kind: String // 項目類型
//    let etag: String // 項目標記
//    let id: YouTubeVideoId // YouTube 影片 ID
//    let snippet: YouTubeVideoSnippet // YouTube 影片描述
//}
//
//// YouTube 影片 ID 結構
//struct YouTubeVideoId: Codable {
//    let kind: String // ID 類型
//    let videoId: String? // 影片 ID
//}
//
//// YouTube 影片描述結構
//struct YouTubeVideoSnippet: Codable {
//    let publishedAt: String // 發佈日期時間
//    let channelId: String // 頻道 ID
//    let title: String // 標題
//    let description: String // 描述
//    let thumbnails: Thumbnails // 縮略圖
//    let channelTitle: String // 頻道標題
//    let liveBroadcastContent: String // 直播內容
//    let publishTime: String // 發佈時間
//}
//
//// 縮略圖結構
//struct Thumbnails: Codable {
//    let `default`: Thumbnail // 默認縮略圖
//    let medium: Thumbnail // 中等縮略圖
//    let high: Thumbnail // 高清縮略圖
//}
//
//// 縮略圖結構
//struct Thumbnail: Codable {
//    let url: String // 圖片 URL
//    let width: Int? // 圖片寬度
//    let height: Int? // 圖片高度
//}
