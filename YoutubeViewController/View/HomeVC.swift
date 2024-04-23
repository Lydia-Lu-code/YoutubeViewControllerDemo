

import UIKit

protocol HomeVCDelegate: AnyObject {
    func didTapMenuButton()
    func didTapNotificationLog﻿ButtonMid()
}

class HomeVC: UIViewController,ButtonCollectionCellDelegate {


    
    
    weak var delegate: HomeVCDelegate?
    
    let buttonTitles = ["emoji", "﻿全部", "﻿音樂", "﻿遊戲", "﻿合輯", "﻿直播中", "﻿動畫", "﻿寵物", "﻿最新上傳", "讓你耳目一新的影片", "﻿提供意見"]
    
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
            collectionView.backgroundColor = .clear
            collectionView.showsHorizontalScrollIndicator = false

            collectionView.register(ButtonCollectionViewCell.self, forCellWithReuseIdentifier: "ButtonCell")
            return collectionView
        }()
    
    let homeTopItemView = HomeTopItemView()
    let videoFrameView = VideoFrameView()
    let shortsFrameCollectionView = ShortsFrameCollectionView()
    var videoFrameViews = [VideoFrameView]()
//    var videoFrameView2 = VideoFrameView()
    var menuViewController: MenuVC?
    var notificationLogViewController = NotificationLogVC()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.isScrollEnabled = true
        setupViews()
        setLayout()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
    }
    


    @objc func didTapMenuButton() {
        delegate?.didTapMenuButton()
        delegate?.didTapNotificationLog﻿ButtonMid()
    }

    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(homeTopItemView)
        contentView.addSubview(collectionView)
        contentView.addSubview(videoFrameView)
        contentView.addSubview(shortsFrameCollectionView)
//        contentView.addSubview(videoFrameView2)
        collectionView.register(ButtonCollectionViewCell.self, forCellWithReuseIdentifier: ButtonCollectionViewCell.identifier)


    }

    private func setLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        homeTopItemView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        videoFrameView.translatesAutoresizingMaskIntoConstraints = false
        shortsFrameCollectionView.translatesAutoresizingMaskIntoConstraints = false
//        videoFrameView2.translatesAutoresizingMaskIntoConstraints = false
        
        // 计算所有按钮宽度的总和
        var totalWidth: CGFloat = 0
        for title in buttonTitles {
            let font = UIFont.systemFont(ofSize: 14)
            let size = NSString(string: title).size(withAttributes: [NSAttributedString.Key.font: font])
            totalWidth += size.width + 20 // 加上额外的空间
        }
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 4500), //設定View的長度
            
            homeTopItemView.topAnchor.constraint(equalTo: contentView.topAnchor),
            homeTopItemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            homeTopItemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            homeTopItemView.heightAnchor.constraint(equalToConstant: 60),
              
            collectionView.topAnchor.constraint(equalTo: homeTopItemView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 60),
            
            videoFrameView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            videoFrameView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            videoFrameView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            videoFrameView.heightAnchor.constraint(equalToConstant: 280),
            
            shortsFrameCollectionView.topAnchor.constraint(equalTo: videoFrameView.bottomAnchor),
            shortsFrameCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shortsFrameCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            shortsFrameCollectionView.heightAnchor.constraint(equalToConstant: 595)
        ])
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
        cell.button.backgroundColor = UIColor.gray // 默认灰色背景
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
        
        if title == "emoji" {
            let menuVC = MenuVC()
            self.navigationController?.pushViewController(menuVC, animated: true)
        } else {
            print("其他按鈕被點擊：\(title)")
        }
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

//extension String {
//    func widthOfString(usingFont font: UIFont) -> CGFloat {
//        let fontAttributes = [NSAttributedString.Key.font: font]
//        let size = self.size(withAttributes: fontAttributes)
//        return size.width
//    }
//}





