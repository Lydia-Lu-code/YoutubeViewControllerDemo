//
//  ShortsFrameCollectionView.swift
//  YoutubeViewController
//
//  Created by Lydia Lu on 2024/4/4.
//

import UIKit


class HomeShortsFrameCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var videoContents: [String] = ["", "", "", ""]
    var welcome: Welcome?
    var homeShortsCollectionViewCell: HomeShortsCollectionViewCell?
    static let identifier = "HomeShortsFrameCollectionView"
      
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        // 初始化 UICollectionViewFlowLayout
        let layout = UICollectionViewFlowLayout()
        super.init(frame: frame, collectionViewLayout: layout)
        
        // 初始化 homeShortsCollectionViewCell
        self.homeShortsCollectionViewCell = HomeShortsCollectionViewCell(frame: .zero)
        
        // 共同的初始化設置
        commonInit()

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

        self.isScrollEnabled = false // 禁用自動滾動
        self.delegate = self
        self.dataSource = self
        
        // 註冊 cell 類型時使用靜態 identifier
        self.register(HomeShortsCollectionViewCell.self, forCellWithReuseIdentifier: HomeShortsFrameCollectionView.identifier)
        
        // 創建一個視圖控制器並在其上添加 HomeShortsFrameCollectionView
        let vc = UIViewController()
        vc.view.frame = frame // 設置視圖控制器的框架與 collectionView 一致
        vc.view.addSubview(self) // 將 collectionView 添加到視圖控制器的視圖中

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
        guard let welcome = welcome else {
            return cell
        }
        
        for item in welcome.items {
            // 檢查 Searchitems 是否包含指定索引的元素
            guard indexPath.item < item.snippet.title.count else {
                print("HS索引超出範圍")
                print("HS indexPath.item == \(indexPath.item)")
                return cell
            }
            
            // 取得指定索引的 SearchItem
            let searchResponse = item.snippet.title
            
            cell.titleLabel.text = searchResponse
                
        }
        


        return cell
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




