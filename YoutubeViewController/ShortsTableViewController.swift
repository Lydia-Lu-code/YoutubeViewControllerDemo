//  ShortsTableViewController.swift
//  YoutubeViewController
//
//  Created by Lydia Lu on 2024/4/24.
//
import Foundation
import UIKit

class ShortsTableViewController: UITableViewController {
    
    var videoContent: String?
    var showItems: [STVItem] = []
    var itemCount: Int = 0 // 新增一個變量來跟踪項目數量
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        tableView.register(ShortsTableViewCell.self, forCellReuseIdentifier: "ShortsTableViewCell")
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        tableView.decelerationRate = .fast // 設置快速滑動減速
        tableView.rowHeight = UIScreen.main.bounds.height
        tableView.delegate = self // 設置委託
        
        loadDataFromYouTubeAPI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 呼叫 exerciseAmbiguityInLayout 方法標識任何模糊的視圖
        view.exerciseAmbiguityInLayout()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // Assuming you have only one section
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemCount // 返回項目數量
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShortsTableViewCell", for: indexPath) as! ShortsTableViewCell

        cell.videoContent = videoContent
        cell.setupViews()
        
        // 更新 cell 的內容
        if indexPath.row < showItems.count {
            let item = showItems[indexPath.row]
            
            // 加載縮略圖
            guard let url = URL(string: item.snippet.thumbnails.high.url) else {
                print("STV無效的 URL 字符串: \(item.snippet.thumbnails.high.url)")
                return cell
            }
            
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    print("STV加載圖片時出錯: \(error)")
                    return
                }
                guard let data = data, let image = UIImage(data: data) else {
                    print("STV無法從數據中提取圖片。")
                    return
                }
                
                DispatchQueue.main.async {
                    let backgroundImageView = UIImageView(image: image)
                    backgroundImageView.contentMode = .scaleAspectFill
                    backgroundImageView.clipsToBounds = true
                    cell.backgroundView = backgroundImageView

                    cell.shortsBtnView.accountButton.setTitle(item.snippet.channelID, for: .normal)
                    cell.shortsBtnView.txtLabel.text = item.snippet.title
                    print("STV item.snippet.channelID == \(item.snippet.channelID)")
                    print("STV item.snippet.title == \(item.snippet.title)")
                }
                
            }.resume()
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 取得整個安全區域的高度
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.size.height
        return safeAreaHeight
    }
    
    // Overriding scroll view delegate method
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let cellHeight = tableView.rowHeight
        let targetY = targetContentOffset.pointee.y
        let index = round(targetY / cellHeight)
        targetContentOffset.pointee = CGPoint(x: 0, y: index * cellHeight)
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            snapToNextCell()
        }
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        snapToNextCell()
    }
    


    
    private func snapToNextCell() {
        let offsetY = tableView.contentOffset.y
        let cellHeight = UIScreen.main.bounds.height
        let currentIndex = Int(round(offsetY / cellHeight))
        let nextIndex = (currentIndex + 1) % tableView.numberOfRows(inSection: 0)
        let targetOffsetY = CGFloat(nextIndex) * cellHeight
        
        let indexPath = IndexPath(row: nextIndex, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
}

extension ShortsTableViewController {
    
    func loadDataFromYouTubeAPI() {
//        let apiKey = "AIzaSyCH3_SO6tdEh2XhWw4dEBi2WFDNA83MyMI"
        let apiKey = ""
        let baseURL = "https://www.googleapis.com/youtube/v3/videos"
        
        var components = URLComponents(string: baseURL)!
        components.queryItems = [
            URLQueryItem(name: "part", value: "snippet,contentDetails,statistics"),
            URLQueryItem(name: "chart", value: "mostPopular"),
            URLQueryItem(name: "maxResults", value: "8"),
            URLQueryItem(name: "key", value: apiKey)
        ]
        
        let url = components.url!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                print("STV Error: \(String(describing: error))")
                return
            }
            
            print("STV API 請求成功。")
            print(String(data: data, encoding: .utf8) ?? "STV 無法解析資料")
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let searchResponse = try decoder.decode(STVWelcome.self, from: data)
                print("STV JSON 解析成功。")
                
                self.showItems = searchResponse.items // 將從 API 返回的項目存儲到 showItems 陣列中
                self.itemCount = self.showItems.count // 更新項目數量
                
                DispatchQueue.main.async {
                    self.tableView.reloadData() // 重新載入表格視圖
                }
                
            } catch {
                print("STV 解碼 JSON 失敗: \(error)")
            }
            
        }
        
        task.resume()
    }

    func loadDataShotsCell(with item: STVItem) {
        DispatchQueue.main.async {
            guard let indexPath = self.tableView.indexPathsForVisibleRows?.last else {
                print("STV 表格視圖中無可見行。")
                return
            }
            
            guard let cell = self.tableView.cellForRow(at: indexPath) as? ShortsTableViewCell else {
                print("STV無法獲取單元格。")
                return
            }
            
            guard let url = URL(string: item.snippet.thumbnails.high.url) else {
                print("STV無效的 URL 字符串: \(item.snippet.thumbnails.high.url)")
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    print("STV加載圖片時出錯: \(error)")
                    return
                }
                guard let data = data, let image = UIImage(data: data) else {
                    print("STV無法從數據中提取圖片。")
                    return
                }
                
                DispatchQueue.main.async {
                    let backgroundImageView = UIImageView(image: image)
                    backgroundImageView.contentMode = .scaleAspectFill
                    backgroundImageView.clipsToBounds = true
                    cell.backgroundView = backgroundImageView

                    cell.shortsBtnView.accountButton.setTitle(item.snippet.channelID, for: .normal)
                    cell.shortsBtnView.txtLabel.text = item.snippet.title
                }
                
            }.resume()
        }
    }
}


