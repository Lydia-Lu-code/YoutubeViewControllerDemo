

import UIKit

protocol HomeVCDelegate: AnyObject {
    func didTapMenuButton()
    func didTapNotificationLog﻿ButtonMid()
}

class HomeVC: UIViewController,ButtonCollectionCellDelegate, UIViewControllerTransitioningDelegate {
    
    weak var delegate: HomeVCDelegate?
    
    let buttonTitles = ["﻿📍﻿", "﻿全部", "﻿音樂", "﻿遊戲", "﻿合輯", "﻿直播中", "﻿動畫", "﻿寵物", "﻿最新上傳", "讓你耳目一新的影片", "﻿提供意見"]
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(ButtonCollectionViewCell.self, forCellWithReuseIdentifier: "ButtonCell")
        return collectionView
    }()
    
    
    // 定義一個 UILabel 用於顯示播放器符號
    lazy var playerSymbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "play.circle")
        imageView.tintColor = UIColor.systemBlue
        imageView.widthAnchor.constraint(equalToConstant: 35).isActive = true // 設置寬度為 50
        imageView.heightAnchor.constraint(equalToConstant: 35).isActive = true // 設置高度為 50
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal) // 設置內容壓縮抗壓縮性
        return imageView
    }()
    
    // 定義一個 UILabel 用於顯示 "Shorts" 文字
    lazy var shortsLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Shorts"
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 18) // 設置粗體 18PT
        label.setContentCompressionResistancePriority(.required, for: .horizontal) // 設置內容壓縮抗壓縮性
        return label
    }()
    
    
    // 定義一個 StackView 用於將播放器符號和 "Shorts" 文字放在一起
    lazy var shortsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8 // 設置元件間距
        stackView.distribution = .fill // 將分佈設置為填充
        stackView.alignment = .center // 將對齊方式設置為居中對齊
        stackView.addArrangedSubview(playerSymbolImageView)
        stackView.addArrangedSubview(shortsLbl)
        return stackView
    }()
    
    
    
    let singleVideoFrameView = VideoFrameView()
    let shortsFrameCollectionView = ShortsFrameCollectionView()
    var otherVideoFrameViews = [VideoFrameView]()
    var menuViewController: MenuVC?
    var notificationLogViewController = NotificationLogVC()
    
    
//    var snippetChannelId: String = ""
    var viewCount: String = ""
    var calculateDaysSinceUpload: String = ""
    
    var previousVideoFrameView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenWidth = UIScreen.main.bounds.width
        let width = screenWidth * 0.75
        view.frame = CGRect(x: 0, y: 0, width: width, height: UIScreen.main.bounds.height)
        
        
        view.backgroundColor = .systemBackground
        
        scrollView.isScrollEnabled = true
        setupViews()
        setLayout()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupRightBarButtonItems() // 調用新的方法來設置右側的 UIBarButtonItem
        fetchYouTubeData()
    }
    
    @objc func didTapMenuButton() {
        delegate?.didTapMenuButton()
        delegate?.didTapNotificationLog﻿ButtonMid()
    }
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(collectionView)
        contentView.addSubview(singleVideoFrameView)
        contentView.addSubview(shortsStackView)
        contentView.addSubview(shortsFrameCollectionView)
        // 將 otherVideoFrameViews 中的每個 VideoFrameView 添加到 contentView 中
        
        
        // 確保 otherVideoFrameViews 至少有四個元素
        while otherVideoFrameViews.count < 4 {
            let videoFrame = VideoFrameView()
            otherVideoFrameViews.append(videoFrame)
        }
        for videoFrameView in otherVideoFrameViews {
            contentView.addSubview(videoFrameView)
        }
        
        collectionView.register(ButtonCollectionViewCell.self, forCellWithReuseIdentifier: ButtonCollectionViewCell.identifier)
    }
    private func setLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        singleVideoFrameView.translatesAutoresizingMaskIntoConstraints = false
        shortsFrameCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        // 计算所有按钮宽度的总和
        var totalWidth: CGFloat = 0
        for title in buttonTitles {
            let font = UIFont.systemFont(ofSize: 14)
            let size = NSString(string: title).size(withAttributes: [NSAttributedString.Key.font: font])
            totalWidth += size.width + 20 // 加上额外的空间
        }
        
        // 計算15個 videoFrameView2 的高度總和
        let videoFrameView2TotalHeight: CGFloat = 4 * 300 // 假設每個 videoFrameView2 的高度是 300
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: shortsFrameCollectionView.bottomAnchor), // 更新這裡
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 60),
            
            singleVideoFrameView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            singleVideoFrameView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            singleVideoFrameView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            singleVideoFrameView.heightAnchor.constraint(equalToConstant: 300),

            
            // imageView 布局
//            shortsStackView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            shortsStackView.topAnchor.constraint(equalTo: singleVideoFrameView.bottomAnchor),
            shortsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shortsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            shortsStackView.heightAnchor.constraint(equalToConstant: 60), // 設定高度為 160
            
            shortsFrameCollectionView.topAnchor.constraint(equalTo: shortsStackView.bottomAnchor),
            shortsFrameCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shortsFrameCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            shortsFrameCollectionView.heightAnchor.constraint(equalToConstant: 600),
            
            
        ])
        //        setupVideoFrameViewsLayout()
        
        // 設定 scrollView 的 contentSize
//        let contentHeight = contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        let contentHeight = contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height + videoFrameView2TotalHeight
        scrollView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
    }
    
}

extension HomeVC: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttonTitles.count // 返回 CollectionView 中的按钮数量
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCollectionViewCell.identifier, for: indexPath) as! ButtonCollectionViewCell
        let title = buttonTitles[indexPath.item]
        cell.button.setTitle(title, for: .normal)
        
        // 设置按钮的样式
        cell.button.backgroundColor = UIColor.darkGray // 默认灰色背景
        cell.button.setTitleColor(UIColor.white, for: .normal) // 默认白色文字
        cell.button.titleLabel?.font = UIFont.systemFont(ofSize: 14) // 按钮字体大小
        
        if indexPath.item == buttonTitles.count - 1 {
            // 如果是最后一个按钮，则设置特殊样式
            cell.button.backgroundColor = UIColor.clear // 透明背景
            cell.button.setTitleColor(UIColor.blue, for: .normal) // 蓝色文字
            cell.button.titleLabel?.font = UIFont.systemFont(ofSize: 13) // 缩小字体大小
        }
        
        // 添加按鈕點擊事件
        cell.button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        guard let title = sender.titleLabel?.text else { return }
        
        if title == "﻿📍﻿" {
            let menuVC = MenuVC()
            // 设置自定义过渡动画代理
            menuVC.transitioningDelegate = self
            menuVC.modalPresentationStyle = .custom
            self.present(menuVC, animated: true, completion: nil)
        } else {
            print("其他按鈕被點擊：\(title)")
        }
    }
    
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideInTransition()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let title = buttonTitles[indexPath.item]
        let width = title.count * 22
        let height: CGFloat = 20
        let verticalSpacing: CGFloat = 20
        
        return CGSize(width: CGFloat(width), height: height + verticalSpacing)
        
    }
    
    func didTapButton() {
    }
}

struct ResponseType: Codable {
    // 定義你需要的屬性，以匹配 YouTube API 的回應格式
}

extension HomeVC {
    
    
    
    // 將觀看次數轉換為人性化的格式
    func convertViewCount(_ viewCountString: String) -> String {
        guard let viewCount = Int(viewCountString) else {
            return viewCountString // 如果無法解析為整數，返回原始字串
        }
        
        if viewCount > 29999 {
            return "\(viewCount / 10000)萬"
        } else if viewCount > 19999 {
            return "\(viewCount / 10000).\(viewCount % 10000 / 1000)萬"
        } else if viewCount > 9999 {
            return "\(viewCount / 10000)萬"
        } else {
            return "\(viewCount)"
        }
    }
    
    func calculateTimeSinceUpload(from publishTime: String) -> String {
        // 將 publishTime 轉換為日期對象
        let dateFormatter = ISO8601DateFormatter()
        if let publishDate = dateFormatter.date(from: publishTime) {
            // 計算距今的時間間隔
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour], from: publishDate, to: Date())
            
            // 判斷距離上傳的時間，決定顯示的格式
            if let years = components.year, years > 0 {
                return "\(years)年前"
            } else if let months = components.month, months > 0 {
                return "\(months)個月前"
            } else if let days = components.day, days > 0 {
                return "\(days)天前"
            } else if let hours = components.hour, hours > 0 {
                return "\(hours)個小時前"
            } else {
                return "剛剛"
            }
        }
        return ""
    }
    
    func loadDataVideoFrameView(withTitle title: String, thumbnailURL: String, channelTitle: String, accountImageURL: String, viewCount: String, daysSinceUpload: String, atIndex index: Int) {
        guard index < otherVideoFrameViews.count else {
            print("Index out of range for otherVideoFrameViews.")
            return
        }
        
        // 根據索引從 otherVideoFrameViews 中獲取相應的 VideoFrameView
        let videoFrameView = otherVideoFrameViews[index]
        
        // 將資料設置到 VideoFrameView 中
        videoFrameView.labelMidTitle.text = title
        videoFrameView.labelMidOther.text = "\(channelTitle)．觀看次數： \(viewCount)次．\(daysSinceUpload)前"
        
        // 設置影片縮圖
        if let thumbnailURL = URL(string: thumbnailURL) {
            URLSession.shared.dataTask(with: thumbnailURL) { data, _, error in
                if let error = error {
                    print("Error fetching thumbnail image: \(error)")
                    return
                }
                guard let data = data, let image = UIImage(data: data) else {
                    print("Failed to extract image from data.")
                    return
                }
                DispatchQueue.main.async {
                    // 設置影片縮圖
                    videoFrameView.videoView.image = image
                }
            }.resume()
        } else {
            print("Invalid thumbnail URL.")
        }
        
        // 設置帳號圖片
        if let accountImageURL = URL(string: accountImageURL) {
            URLSession.shared.dataTask(with: accountImageURL) { data, _, error in
                if let error = error {
                    print("Error fetching account image: \(error)")
                    return
                }
                guard let data = data, let image = UIImage(data: data) else {
                    print("Failed to extract image from data.")
                    return
                }
                DispatchQueue.main.async {
                    // 設置帳號圖片
                    videoFrameView.imageView.image = image
                }
            }.resume()
        } else {
            print("Invalid account image URL.")
        }
    }
    
    
    func fetchYouTubeData() {
        let apiKey = "AIzaSyC1LUGmn3kwNecr13UCLwOQEDhn7h6r5Co"
        
        let topUrlString = "https://www.googleapis.com/youtube/v3/videos?key=\(apiKey)&chart=mostPopular&maxResults=5&regionCode=TW&part=snippet,contentDetails,statistics"
        
        
        guard let url = URL(string: topUrlString) else {
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
            
            
            let dateFormatter = ISO8601DateFormatter()
            dateFormatter.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
            
            // 在 do-catch 塊中
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(Welcome.self, from: data)
                
                let videos = result.items
                
                DispatchQueue.main.async { [self] in
                    guard !videos.isEmpty else {
                        return
                    }
                    
                    // 處理第一個視圖（singleVideoFrameView）
                    if let firstVideo = videos.first {
                        // 獲取第一個視圖相關的資料
                        let videoTitle = firstVideo.snippet.title
                        let videoChannelTitle = firstVideo.snippet.channelTitle
                        let videoPublishTime = firstVideo.snippet.publishedAt
                        let viewCount = firstVideo.statistics.viewCount
                        let thumbnailURL = firstVideo.snippet.thumbnails.medium.url
                        let accountImageURL = firstVideo.snippet.thumbnails.maxres.url
                        let daysSinceUpload = self.calculateTimeSinceUpload(from: videoPublishTime)
                        let convertedViewCount = convertViewCount(viewCount)
                        
                        // 更新 singleVideoFrameView 的資料
                        self.loadDataVideoFrameView(withTitle: videoTitle, thumbnailURL: thumbnailURL, channelTitle: videoChannelTitle, accountImageURL: accountImageURL, viewCount: convertedViewCount, daysSinceUpload: daysSinceUpload, atIndex: 0)
                        
                        // 將 firstVideo 中的資料設置給 singleVideoFrameView
                        self.singleVideoFrameView.labelMidTitle.text = videoTitle
                        self.singleVideoFrameView.labelMidOther.text = "\(videoChannelTitle)．觀看次數： \(convertedViewCount)次．\(daysSinceUpload)前"
                        
                        // 設置影片縮圖
                        if let thumbnailURL = URL(string: thumbnailURL) {
                            URLSession.shared.dataTask(with: thumbnailURL) { data, _, error in
                                if let error = error {
                                    print("Error fetching thumbnail image: \(error)")
                                    return
                                }
                                guard let data = data, let image = UIImage(data: data) else {
                                    print("Failed to extract image from data.")
                                    return
                                }
                                DispatchQueue.main.async {
                                    // 設置影片縮圖
                                    self.singleVideoFrameView.videoView.image = image
                                }
                            }.resume()
                        } else {
                            print("Invalid thumbnail URL.")
                        }
                        
                        // 設置帳號圖片
                        if let accountImageURL = URL(string: accountImageURL) {
                            URLSession.shared.dataTask(with: accountImageURL) { data, _, error in
                                if let error = error {
                                    print("Error fetching account image: \(error)")
                                    return
                                }
                                guard let data = data, let image = UIImage(data: data) else {
                                    print("Failed to extract image from data.")
                                    return
                                }
                                DispatchQueue.main.async {
                                    // 設置帳號圖片
                                    self.singleVideoFrameView.imageView.image = image
                                }
                            }.resume()
                        } else {
                            print("Invalid account image URL.")
                        }
                        
                        // 將 previousVideoFrameView 設置為 shortsFrameCollectionView
                        previousVideoFrameView = shortsFrameCollectionView
                        self.collectionView.reloadData()
                    }
                    
                    // 處理其他視圖（otherVideoFrameViews）
                    for (index, video) in videos.dropFirst().enumerated() {
                        guard let previousView = previousVideoFrameView else {
                            break
                        }
                        
                        let videoFrame = self.otherVideoFrameViews[index]
                        videoFrame.translatesAutoresizingMaskIntoConstraints = false
                        
                        // 獲取影片相關資料
                        let videoTitle = video.snippet.title
                        let videoChannelTitle = video.snippet.channelTitle
                        let videoPublishTime = video.snippet.publishedAt
                        let viewCount = video.statistics.viewCount
                        let thumbnailURL = video.snippet.thumbnails.medium.url
                        let accountImageURL = video.snippet.thumbnails.maxres.url
                        let daysSinceUpload = self.calculateTimeSinceUpload(from: videoPublishTime)
                        let convertedViewCount = convertViewCount(viewCount)
                        
                        // 更新影片框架
                        self.loadDataVideoFrameView(withTitle: videoTitle, thumbnailURL: thumbnailURL, channelTitle: videoChannelTitle, accountImageURL: accountImageURL, viewCount: convertedViewCount, daysSinceUpload: daysSinceUpload, atIndex: index)
                        
                        // 設置約束
                        NSLayoutConstraint.activate([
                            videoFrame.topAnchor.constraint(equalTo: previousView.bottomAnchor, constant: 300),
                            videoFrame.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
                            videoFrame.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
                            videoFrame.heightAnchor.constraint(equalToConstant: 300),
                        ])
                        
                        // 更新 previousVideoFrameView
                        previousVideoFrameView = videoFrame
                        self.collectionView.reloadData()
                    }
                    
                    // 確保 previousVideoFrameView 不為空，並將其 bottomAnchor 連接到 shortsFrameCollectionView 的 bottomAnchor 上
                    if let lastVideoFrameView = self.otherVideoFrameViews.last {
                        NSLayoutConstraint.activate([
                            lastVideoFrameView.bottomAnchor.constraint(equalTo: self.shortsFrameCollectionView.bottomAnchor)
                        ])
                    }
                }
                
            } catch {
                print("解碼錯誤：\(error)")
            }


//            do {
//                let decoder = JSONDecoder()
//                let result = try decoder.decode(Welcome.self, from: data)
//                
//
//                // 從第二個影片開始處理
//                let videos = result.items.dropFirst()
//                DispatchQueue.main.async { [self] in
//                    var previousVideoFrameView: UIView? = self.shortsFrameCollectionView
//                    
//                    // 確保有足夠的影片框架
//                    for (index, video) in videos.enumerated() {
//                        guard let previousView = previousVideoFrameView else {
//                            break
//                        }
////                        print("VideoFrameView \(index + 1) added.")
//                        // 獲取影片相關信息
//                        let videoTitle = video.snippet.title
//                        let videoChannelTitle = video.snippet.channelTitle
//                        let videoPublishTime = video.snippet.publishedAt
//                        let viewCount = video.statistics.viewCount
//                        // 獲取縮略圖 URL 和帳戶圖片 URL
//                        let thumbnailURL = video.snippet.thumbnails.medium.url
//                        let accountImageURL = video.snippet.thumbnails.maxres.url
//                        
//                        // 取得要更新的 VideoFrameView
//                        let videoFrame = self.otherVideoFrameViews[index]
//                        videoFrame.translatesAutoresizingMaskIntoConstraints = false
//
//                        // 調用 calculateTimeSinceUpload 方法，獲取“幾天前”字符串
//                        let daysSinceUpload = self.calculateTimeSinceUpload(from: videoPublishTime)
//                        let convertedViewCount = convertViewCount(viewCount)
//
//                        
//                        // 將標題傳遞給方法，更新 UI
//                        DispatchQueue.main.async {
//                            self.loadDataVideoFrameView(withTitle: videoTitle, thumbnailURL: thumbnailURL, channelTitle: videoChannelTitle, accountImageURL: accountImageURL, viewCount: convertedViewCount, daysSinceUpload: daysSinceUpload, atIndex: index)
//                        }
//                        
//                        if index < self.otherVideoFrameViews.count {
//                            let videoFrame = self.otherVideoFrameViews[index]
//                            videoFrame.translatesAutoresizingMaskIntoConstraints = false
//                            
//                            NSLayoutConstraint.activate([
//                                videoFrame.topAnchor.constraint(equalTo: previousView.bottomAnchor, constant: 300),
//                                videoFrame.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
//                                videoFrame.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
//                                videoFrame.heightAnchor.constraint(equalToConstant: 300),
//
//                            ])
//                        }
//                        
//                        // 更新上一個影片框架的參考
//                        previousVideoFrameView = videoFrame
//                    }
//                    
//                    // 確保 previousVideoFrameView 不為空，並將其 bottomAnchor 連接到 shortsFrameCollectionView 的 bottomAnchor 上
//                    if let lastVideoFrameView = self.otherVideoFrameViews.last {
//                        NSLayoutConstraint.activate([
//                            lastVideoFrameView.bottomAnchor.constraint(equalTo: self.shortsFrameCollectionView.bottomAnchor)
//                        ])
//                    }
//                }
//                
//            } catch {
//                print("解碼錯誤：\(error)")
//            }
        }.resume()
    }
    
    
    // touch Gesture 點旁邊
    // Animation 方向是 右到左
    
    
}
