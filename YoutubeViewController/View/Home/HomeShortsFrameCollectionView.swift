//
//  ShortsFrameCollectionView.swift
//  YoutubeViewController
//
//  Created by Lydia Lu on 2024/4/4.
//

import UIKit


class HomeShortsFrameCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var videoContents: [String] = ["", "", "", ""]
    var searchResults: SearchWelcome?
//    weak var viewController: UIViewController?
    var homeShortsCollectionViewCell: HomeShortsCollectionViewCell?
    
    static let identifier = "HomeShortsFrameCollectionView"
    

    

    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        // 初始化 UICollectionViewFlowLayout
        let layout = UICollectionViewFlowLayout()
        super.init(frame: frame, collectionViewLayout: layout)
        


        
        
        
        // 初始化 homeShortsCollectionViewCell
        self.homeShortsCollectionViewCell = HomeShortsCollectionViewCell(frame: .zero) // 初始化 homeShortsCollectionViewCell
        
        
        
        
        // 共同的初始化設置
        commonInit()
        
//        homeShortsCollectionViewCell?.button.backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        // 將 homeShortsCollectionViewCell 初始化為預設值
        self.homeShortsCollectionViewCell = HomeShortsCollectionViewCell(frame: .zero)
        
        // 調用 commonInit() 進行共同的初始化設置
        commonInit()
    }


    // 共同的初始化設置
    private func commonInit() {
        // 初始化 homeShortsCollectionViewCell
//        self.homeShortsCollectionViewCell = HomeShortsCollectionViewCell()
//        self.homeShortsCollectionViewCell?.setupButton()
//        self.backgroundColor = UIColor.yellow

        self.isScrollEnabled = false // 禁用自動滾動
        self.delegate = self
        self.dataSource = self
        
        // 註冊 cell 類型時使用靜態 identifier
        self.register(HomeShortsCollectionViewCell.self, forCellWithReuseIdentifier: HomeShortsFrameCollectionView.identifier)
        
        // 創建一個視圖控制器並在其上添加 HomeShortsFrameCollectionView
        let vc = UIViewController()
        vc.view.frame = frame // 設置視圖控制器的框架與 collectionView 一致
        vc.view.addSubview(self) // 將 collectionView 添加到視圖控制器的視圖中
        
        // 設置 viewController 屬性，以便在 collectionView 中打開 ShortsTableViewController
//        self.viewController = vc
        
        // 創建一些內容以顯示在 collectionView 中
        self.videoContents = ["Video 1", "Video 2", "Video 3", "Video 4"]
        
        // 顯示視圖控制器
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = vc
        window.makeKeyAndVisible()
    }

    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoContents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeShortsFrameCollectionView.identifier, for: indexPath) as! HomeShortsCollectionViewCell
        
        // 檢查 searchResults 是否為 nil
        guard let searchResults = searchResults else {
            print("HS搜索結果尚未可用")
            print("HS searchResults == \(searchResults)")
            return cell
        }
        
        // 檢查 Searchitems 是否包含指定索引的元素ㄇ
        guard indexPath.item < searchResults.Searchitems.count else {
            print("HS索引超出範圍")
            print("HS indexPath.item == \(indexPath.item)")
            return cell
        }
        
        // 取得指定索引的 SearchItem
        let searchItem = searchResults.Searchitems[indexPath.item]
        
        // 將取得的 SearchItem 傳遞給 cell 並顯示
        cell.searchItem = searchItem
//        cell.button.backgroundColor = .white

        return cell
    }

    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        guard let viewController = viewController else { return }
//        let shortsTableViewController = ShortsTableViewController()
//        shortsTableViewController.videoContent = videoContents[indexPath.item]
//        viewController.present(shortsTableViewController, animated: true, completion: nil)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 30) / 2
        return CGSize(width: width, height: 285)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
}

extension HomeShortsFrameCollectionView {
    
    
    func fetchYouTubeData () {
        let apiKey = "AIzaSyC1LUGmn3kwNecr13UCLwOQEDhn7h6r5Co"
        
        let urlString = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=TOMORROW X TOGETHER&key=\(apiKey)&type=video&maxResults=4"

        
        guard let url = URL(string: urlString) else {
            print("無效的 URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("錯誤: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("未收到數據")
                return
            }
        // 解析 JSON 數據
            do {
                let decoder = JSONDecoder()
                let searchResults = try decoder.decode(SearchWelcome.self, from: data)
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    self.videoContents = searchResults.Searchitems.map { $0.snippet.title }
                    self.reloadData()
                    
                    // 更新 homeShortsCollectionViewCell
                    if let indexPath = self.indexPathsForVisibleItems.first {
                        if let cell = self.cellForItem(at: indexPath) as? HomeShortsCollectionViewCell {
                            self.homeShortsCollectionViewCell = cell
                            print("cell == \(cell)")
                        }
                    }
                }
            } catch {
            print("解析錯誤：\(error)")
        }
        }.resume()
    }
}



