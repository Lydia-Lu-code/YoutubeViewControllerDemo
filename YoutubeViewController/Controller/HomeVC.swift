

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

    
    
    let videoFrameView = VideoFrameView()
    let shortsFrameCollectionView = ShortsFrameCollectionView()
    var videoFrameViews = [VideoFrameView]()
    var menuViewController: MenuVC?
    var notificationLogViewController = NotificationLogVC()
    
    
    var snippetChannelId: String = ""
    var viewCount: String = ""
    var calculateDaysSinceUpload: String = ""

    
    
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
        
        
        // 固定寬度，避免切換模式時位移
        let fixedWidth = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixedWidth.width = 14 // 調整寬度，以適應您的設計
        
        let btn1 = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(topButtonTapped))
        let btn2 = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: #selector(topButtonTapped))
        let btn3 = UIBarButtonItem(image: UIImage(systemName: "display.2"), style: .plain, target: self, action: #selector(topButtonTapped))

        
        // 将按钮添加到导航栏上
        self.navigationItem.setRightBarButtonItems([btn1, btn2, btn3], animated: true)

        fetchYouTubeData()
}
    @objc func topButtonTapped(_ sender: UIBarButtonItem) {
        switch sender {
        case navigationItem.rightBarButtonItems?[2]: // buttonLeft
            print("Home Left button tapped")
            presentAlertController(title: "﻿選取裝置", message: nil)
        case navigationItem.rightBarButtonItems?[1]: // buttonMid
            print("Home Middle button tapped")
            navigateToNotificationLogViewController()
        case navigationItem.rightBarButtonItems?[0]: // buttonRight
            print("Home Right button tapped")
            presentSearchViewController()
        default:
            break
        }
    }
    func presentSearchViewController() {
        guard let viewController = findViewController() else {
            print("無法找到視圖控制器")
            return
        }
        
        let searchVC = SearchVC() // 假設 SearchViewController 是您的搜索視圖控制器類
        searchVC.title = navigationItem.searchController?.searchBar.text ?? "" // 使用搜索框的文本作为标题
        viewController.navigationController?.pushViewController(searchVC, animated: true)
    }
    private func presentAlertController(title: String, message: String?) {
        guard let viewController = findViewController() else {
            print("無法找到視圖控制器")
            return
        }

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)

        // 設置標題文字左對齊
        let titleParagraphStyle = NSMutableParagraphStyle()
        titleParagraphStyle.alignment = NSTextAlignment.left
        let titleAttributedString = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.paragraphStyle: titleParagraphStyle])
        alertController.setValue(titleAttributedString, forKey: "attributedTitle")

        alertController.addAction(UIAlertAction(title: "透過電視代碼連結", style: .default, handler: { (_) in
            // buttonLeft 的處理代碼
        }))

        alertController.addAction(UIAlertAction(title: "了解詳情", style: .default, handler: { (_) in
            // buttonMid 的處理代碼
        }))

        // 設置選項文字靠左對齊
        for action in alertController.actions {
            action.setValue(NSTextAlignment.left.rawValue, forKey: "titleTextAlignment")
        }

        viewController.present(alertController, animated: true, completion: nil)
    }
    private func navigateToNotificationLogViewController() {
        guard let viewController = findViewController() else {
            print("無法找到視圖控制器")
            return
        }
        
        let notificationLogVC = NotificationLogVC()
        notificationLogVC.title = "通知"
        viewController.navigationController?.pushViewController(notificationLogVC, animated: true)
    }
    private func findViewController() -> UIViewController? {
        if let viewController = self.next as? UIViewController {
            return viewController
        } else {
            var nextResponder = self.next
            while let responder = nextResponder {
                if let viewController = responder as? UIViewController {
                    return viewController
                }
                nextResponder = responder.next
            }
        }
        return nil
    }
    @objc func didTapMenuButton() {
        delegate?.didTapMenuButton()
        delegate?.didTapNotificationLog﻿ButtonMid()
    }
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(collectionView)
        contentView.addSubview(videoFrameView)
        contentView.addSubview(shortsStackView)
        contentView.addSubview(shortsFrameCollectionView)
        collectionView.register(ButtonCollectionViewCell.self, forCellWithReuseIdentifier: ButtonCollectionViewCell.identifier)
    }
    private func setLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        videoFrameView.translatesAutoresizingMaskIntoConstraints = false
        shortsFrameCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        // 计算所有按钮宽度的总和
        var totalWidth: CGFloat = 0
        for title in buttonTitles {
            let font = UIFont.systemFont(ofSize: 14)
            let size = NSString(string: title).size(withAttributes: [NSAttributedString.Key.font: font])
            totalWidth += size.width + 20 // 加上额外的空间
        }
        
        // 計算15個 videoFrameView2 的高度總和
        let videoFrameView2TotalHeight: CGFloat = 15 * 280 // 假設每個 videoFrameView2 的高度是 280

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

            videoFrameView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            videoFrameView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            videoFrameView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            videoFrameView.heightAnchor.constraint(equalToConstant: 280),

            // imageView 布局
            shortsStackView.topAnchor.constraint(equalTo: videoFrameView.bottomAnchor),
            shortsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shortsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            shortsStackView.heightAnchor.constraint(equalToConstant: 70), // 設定高度為 160

            shortsFrameCollectionView.topAnchor.constraint(equalTo: shortsStackView.bottomAnchor),
            shortsFrameCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shortsFrameCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            shortsFrameCollectionView.heightAnchor.constraint(equalToConstant: 600),
            
        ])
        setupVideoFrameViewsLayout()
        
        // 設定 scrollView 的 contentSize
        let contentHeight = contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height + videoFrameView2TotalHeight
        scrollView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
    }
    private func setupVideoFrameViewsLayout() {
        var previousVideoFrameView: UIView = shortsFrameCollectionView

        for _ in 0..<15 {
            let videoFrame = VideoFrameView()
            contentView.addSubview(videoFrame)
            videoFrame.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                videoFrame.topAnchor.constraint(equalTo: previousVideoFrameView.bottomAnchor),
                videoFrame.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                videoFrame.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                videoFrame.heightAnchor.constraint(equalToConstant: 280)
            ])

            previousVideoFrameView = videoFrame
        }

        
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
 
    
//    func loadDataVideoFrameView(withTitle title: String, daysSinceUpload: String) {
//        // 將資料設置到 labelMidTitle 中
//        videoFrameView.labelMidTitle.text = title
//        videoFrameView.labelMidOther.text = "\(snippetChannelId)．觀看次數： \(viewCount)次．\(daysSinceUpload)"
//    }

//    func loadDataVideoFrameView(withTitle title: String, viewCount: String, daysSinceUpload: String) {
//        // 將資料設置到 labelMidTitle 中
//        videoFrameView.videoView
//        videoFrameView.imageView = 
//        videoFrameView.labelMidTitle.text = title
//        videoFrameView.labelMidOther.text = "\(snippetChannelId)．觀看次數： \(viewCount)次．\(daysSinceUpload)"
//    }

    func loadDataVideoFrameView(withTitle title: String, thumbnailURL: String, accountImageURL: String, viewCount: String, daysSinceUpload: String) {
        // 將資料設置到 labelMidTitle 中
        videoFrameView.labelMidTitle.text = title
        
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
                    self.videoFrameView.videoView.backgroundColor = UIColor(patternImage: image)
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
                    self.videoFrameView.imageView.image = image
                }
            }.resume()
        } else {
            print("Invalid account image URL.")
        }
        
        // 設置觀看次數和上傳天數
        videoFrameView.labelMidOther.text = "\(snippetChannelId)．觀看次數： \(viewCount)次．\(daysSinceUpload)"
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
            
            do {
                // 解析返回的 JSON 数据
                let decoder = JSONDecoder()
                let result = try decoder.decode(Welcome.self, from: data)

                if !result.items.isEmpty {
                    let firstVideo = result.items[0]
                    let videoTitle = firstVideo.snippet.title
                    let videoChannelTitle = firstVideo.snippet.channelTitle
                    let videoDescription = firstVideo.snippet.description
                    let videoPublishTime = firstVideo.snippet.publishedAt
                    let viewCount = firstVideo.statistics.viewCount
                    let thumbnailURL = firstVideo.snippet.thumbnails.medium.url // 假設有一個 medium 縮略圖
                    let accountImageURL = firstVideo.snippet.thumbnails.thumbnailsDefault.url // 假設有一個 default 帳戶圖片
                    print("viewCount == \(viewCount)")
                    
                    // 將獲取的數據存儲到對應的變量中
                    self.snippetChannelId = videoChannelTitle


                    // 調用 calculateTimeSinceUpload 方法，獲取“幾天前”字符串
                    let daysSinceUpload = self.calculateTimeSinceUpload(from: videoPublishTime)

                    // 將標題傳遞給方法，更新 UI
                    DispatchQueue.main.async {
                        self.loadDataVideoFrameView(withTitle: videoTitle, thumbnailURL: thumbnailURL, accountImageURL: accountImageURL, viewCount: viewCount, daysSinceUpload: daysSinceUpload)
                        
                        
//                        self.loadDataVideoFrameView(withTitle: videoTitle, viewCount: viewCount, daysSinceUpload: daysSinceUpload)
                    }
                } else {
                    print("No items found in the video information.")
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }


        }.resume()


        

    }

}

// touch Gesture 點旁邊
// Animation 方向是 右到左



