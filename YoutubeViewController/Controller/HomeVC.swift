

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
    
    
    // ButtonCollectionViewCell.collectionView
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
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
    var shortsFrameCollectionView = HomeShortsFrameCollectionView()
    var otherVideoFrameViews = [VideoFrameView]()
    var menuViewController: MenuVC?
    var notificationLogViewController = NotificationLogVC()
    var viewCount: String = ""
    var calculateDaysSinceUpload: String = ""
    var previousVideoFrameView: UIView?
    
    //    // 定義 videoIdUrls 陣列，其中包含要加載的影片 ID
    let videoIds = ["Nqb-KMsAFLM&t", "OLqvhcLGw74", "8EnSm-iDsyk&t", "eP5J2AUw2-E", "FNu1QRe4WTc"]
    
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
        fetchYouTubeData(for: videoIds)
        
        collectionView.register(ButtonCollectionViewCell.self, forCellWithReuseIdentifier: ButtonCollectionViewCell.identifier)
        shortsFrameCollectionView.register(HomeShortsCollectionViewCell.self, forCellWithReuseIdentifier: HomeShortsFrameCollectionView.identifier)
        
        // 設置 contentView 的高度為可以上下滑動的高度
        let totalHeight = calculateTotalHeight()
        contentView.heightAnchor.constraint(equalToConstant: totalHeight).isActive = true
        
        // 將 scrollView 的 contentSize 設置為 contentView 的大小，確保能夠正確上下滾動
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: totalHeight)
        
//        shortsFrameCollectionView.backgroundColor = .yellow
//        contentView.backgroundColor = .red
//        scrollView.backgroundColor = .green
        
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
        

        
    }
    
    private func setLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        singleVideoFrameView.translatesAutoresizingMaskIntoConstraints = false
        shortsFrameCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            contentView.bottomAnchor.constraint(equalTo: shortsFrameCollectionView.bottomAnchor), // 更新這裡
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
            shortsStackView.topAnchor.constraint(equalTo: singleVideoFrameView.bottomAnchor),
            shortsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shortsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            shortsStackView.heightAnchor.constraint(equalToConstant: 60), // 設定高度為 160
            
            shortsFrameCollectionView.topAnchor.constraint(equalTo: shortsStackView.bottomAnchor),
            shortsFrameCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shortsFrameCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            shortsFrameCollectionView.heightAnchor.constraint(equalToConstant: 600),
            
        ])
        
        
    }
    
    private func calculateTotalHeight() -> CGFloat {
        var totalHeight: CGFloat = 0
        
        totalHeight += 60 // collectionView 的高度
        totalHeight += 300 // singleVideoFrameView 的高度
        totalHeight += 60 // shortsStackView 的高度
        totalHeight += 600 // shortsFrameCollectionView 的高度
        totalHeight += CGFloat(4 * 300) // 其他 VideoFrameView 的高度
        //        totalHeight += CGFloat(otherVideoFrameViews.count * 300)
        
        totalHeight += CGFloat(4 - 1) * 2 // 添加视图之间的间距
        //        totalHeight += CGFloat(otherVideoFrameViews.count - 1) * 20
        
        totalHeight += 20 // 假设 contentView 的顶部和底部边距都是 20
        return totalHeight
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

    func setupVideoFrameViews() -> [VideoFrameView] {
        var videoFrameViews: [VideoFrameView] = []
        
        // 先保留第一個框架的 reference
        let firstVideoFrameView = VideoFrameView()
        firstVideoFrameView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(firstVideoFrameView)
        videoFrameViews.append(firstVideoFrameView)

        // 設置第一個框架的約束
        NSLayoutConstraint.activate([
            firstVideoFrameView.topAnchor.constraint(equalTo: singleVideoFrameView.bottomAnchor, constant: 660), // 垂直間距為 20
            firstVideoFrameView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            firstVideoFrameView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            firstVideoFrameView.heightAnchor.constraint(equalToConstant: 285)
        ])

        var previousView: UIView = firstVideoFrameView

        // 建立並設置其他框架
        for _ in 1..<4 {
            let videoFrameView = VideoFrameView()
            videoFrameView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(videoFrameView)
            videoFrameViews.append(videoFrameView)

            // 設置約束，將下一個框架堆疊在前一個框架的下方
            NSLayoutConstraint.activate([
                videoFrameView.topAnchor.constraint(equalTo: previousView.bottomAnchor, constant: 20),
                videoFrameView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                videoFrameView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                videoFrameView.heightAnchor.constraint(equalToConstant: 285)
            ])

            // 更新 previousView 以便下一个 videoFrameView 堆叠在其下方
            previousView = videoFrameView
        }

        return videoFrameViews
    }

    
    
    func loadDataVideoFrameView(withTitle title: String, thumbnailURL: String, channelTitle: String, accountImageURL: String, viewCount: String, daysSinceUpload: String, atIndex index: Int) {
        var videoFrameView: VideoFrameView? = nil // 將 videoFrameView 變數初始化為 nil
        
        for index in 0...4 {
            switch index {
            case 0:
                videoFrameView = singleVideoFrameView
            case 1...4:
                let adjustedIndex = index - 1 // 將索引調整為在 otherVideoFrameViews 中的正確位置
                guard adjustedIndex < otherVideoFrameViews.count else {
//                    print("load -- Index out of range for otherVideoFrameViews.")
//                    print("guard adjustedIndex < otherVideoFrameViews.count else")
                    return // 如果索引超出了範圍，則直接返回
                }
                videoFrameView = otherVideoFrameViews[adjustedIndex]
                
            default:
                break
            }
            
            // 確保 videoFrameView 不為 nil 才設置相關屬性
            if let videoFrameView = videoFrameView {
                // 將資料設置到 VideoFrameView 中
                videoFrameView.labelMidTitle.text = title
                videoFrameView.labelMidOther.text = "\(channelTitle)．觀看次數： \(viewCount)次．\(daysSinceUpload)"
                
                // 設置影片縮圖
                if let thumbnailURL = URL(string: thumbnailURL) {
                    URLSession.shared.dataTask(with: thumbnailURL) { data, _, error in
                        if let error = error {
//                            print("Error fetching thumbnail image: \(error)")
                            return
                        }
                        guard let data = data, let image = UIImage(data: data) else {
//                            print("Failed to extract image from data.")
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
        }
    }

    func fetchYouTubeData(for videoIds: [String]) {
        self.otherVideoFrameViews = setupVideoFrameViews()

        let apiKey = "AIzaSyC1LUGmn3kwNecr13UCLwOQEDhn7h6r5Co"

        for videoId in videoIds {
            let urlString = "https://www.googleapis.com/youtube/v3/videos?id=\(videoId)&key=\(apiKey)&part=snippet,contentDetails,statistics"

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
                    let result = try decoder.decode(Welcome.self, from: data)

                    DispatchQueue.main.async { [self] in
                        // 檢查 result.items 中是否有多個元素
                        guard result.items.count > 0 else {
                            print("No videos found.")
                            return
                        }

                        var resultIndex = 0 // 初始化 resultIndex

                        for (_, video) in result.items.enumerated() {
//                            print("resultIndex == \(resultIndex)")
                            // 計算視圖框架的索引
                            let frameIndex = resultIndex
//                            print("frameIndex == \(frameIndex)")
                            if frameIndex < otherVideoFrameViews.count {
                                // 加載數據到 otherVideoFrameViews
                                loadDataVideoFrameView(withTitle: video.snippet.title, thumbnailURL: video.snippet.thumbnails.medium.url, channelTitle: video.snippet.channelTitle, accountImageURL: video.snippet.thumbnails.maxres.url, viewCount: convertViewCount(video.statistics.viewCount), daysSinceUpload: calculateTimeSinceUpload(from: video.snippet.publishedAt), atIndex: frameIndex)
                            } else {
                                print("Index out of range for otherVideoFrameViews.")
                            }
                            resultIndex += 1 // 在每次循环中递增 resultIndex
                        }
                    }

                } catch {
                    print("解析錯誤：\(error)")
                }
            }.resume()
        }
    }


    
}


// touch Gesture 點旁邊
// Animation 方向是 右到左






