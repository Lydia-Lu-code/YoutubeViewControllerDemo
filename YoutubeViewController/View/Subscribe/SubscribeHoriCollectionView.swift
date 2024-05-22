import UIKit


// ﻿橫向滑動的CollectionView
class SubscribeHoriCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    weak var viewController: UIViewController?
    
    var welcome: Welcome?
    var homeShortsCollectionViewCell: HomeShortsCollectionViewCell?
    private let identifier = "SubscribeHoriCollectionView"
    //        private let cellIdentifier = "SubscribeCell"
    
    
    var videoContents: [String] = ["影片1內容", "影片2內容", "影片3內容", "影片4內容","影片5內容", "影片6內容", "影片7內容", "影片8內容","影片9內容", "影片10內容", "影片11內容", "影片12內容","影片13內容", "影片14內容", "影片15內容"]
    
    let button = UIButton()
    

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        // Create a UICollectionViewFlowLayout instance here
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal // 設定水平滾動
        layout.minimumLineSpacing = 10 // 設置最小行間距
        layout.minimumInteritemSpacing = 10 // 設置最小列間距
        
        // Call super.init with the created layout
        super.init(frame: frame, collectionViewLayout: layout)
        
        // Additional setup code here
        self.showsHorizontalScrollIndicator = false // 隱藏水平滾動條
        self.delegate = self
        self.dataSource = self
        self.isScrollEnabled = true // 啟用橫向滑動
        self.register(HomeShortsCollectionViewCell.self, forCellWithReuseIdentifier: HomeShortsCollectionViewCell.cellIdentifier)
        commonInit()
    }

    
//    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
//        super.init(frame: frame, collectionViewLayout: layout)
//        
//        self.showsHorizontalScrollIndicator = false // 隱藏水平滾動條
//        self.delegate = self
//        self.dataSource = self
//        self.isScrollEnabled = true // 啟用橫向滑動
//        
//        // 註冊 cell 類型時使用正確的識別符
//        self.register(HomeShortsCollectionViewCell.self, forCellWithReuseIdentifier: HomeShortsCollectionViewCell.cellIdentifier)
// 
//        // 呼叫 setupUI() 設置介面元素
////        setupUI()
//        commonInit()
//    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

        // 將 homeShortsCollectionViewCell 初始化為預設值
        self.homeShortsCollectionViewCell = HomeShortsCollectionViewCell(frame: .zero)
        
        // 調用 commonInit() 進行共同的初始化設置
        commonInit()
    }
    private func commonInit() {
        // 初始化 homeShortsCollectionViewCell
//        self.homeShortsCollectionViewCell = HomeShortsCollectionViewCell()
//        self.homeShortsCollectionViewCell?.setupButton()
//        self.backgroundColor = UIColor.yellow

        self.isScrollEnabled = false // 禁用自動滾動
        self.delegate = self
        self.dataSource = self
        self.isScrollEnabled = true // 啟用橫向滑動
        // 註冊 cell 類型時使用靜態 identifier
//        self.register(HomeShortsCollectionViewCell.self, forCellWithReuseIdentifier: HomeShortsCollectionViewCell.cellIdentifier)
        
//        // 創建一個視圖控制器並在其上添加 HomeShortsFrameCollectionView
//        let vc = UIViewController()
//        vc.view.frame = frame // 設置視圖控制器的框架與 collectionView 一致
//        vc.view.addSubview(self) // 將 collectionView 添加到視圖控制器的視圖中
//        
        // 設置 viewController 屬性，以便在 collectionView 中打開 ShortsTableViewController
//        self.viewController = vc
        
        // 創建一些內容以顯示在 collectionView 中
        self.videoContents = ["Video 1", "Video 2", "Video 3", "Video 4","Video 5", "Video 6", "Video 7", "Video 8","Video 9","Video 10","Video 11", "Video 12", "Video 13", "Video 14","Video 15"]
        
        // 顯示視圖控制器
//        let window = UIWindow(frame: UIScreen.main.bounds)
//        window.rootViewController = vc
//        window.makeKeyAndVisible()
    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func setupUI() {
//        // 按鈕設定
//        button.setTitleColor(.black, for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(button) // 替換 contentView 為 self
//
//        // 布局
//        NSLayoutConstraint.activate([
//            // 按钮约束
//            button.topAnchor.constraint(equalTo: self.topAnchor),
//            button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            button.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//
//        ])
//    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoContents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 初始化 cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeShortsCollectionViewCell.cellIdentifier, for: indexPath) as! HomeShortsCollectionViewCell

        
        return cell
    }
    
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 根據單元格數量和寬度計算每個單元格的大小
        let cellWidth = collectionView.frame.width / CGFloat(2)
//        let cellWidth = collectionView.frame.width / CGFloat(videoContents.count)
        return CGSize(width: cellWidth, height: collectionView.frame.height)
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
}
