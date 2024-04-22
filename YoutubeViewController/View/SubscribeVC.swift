//
//  SubscribeViewController.swift
//  YoutubeViewController
//
//  Created by Lydia Lu on 2024/4/5.
//

import UIKit

class SubscribeVC: UIViewController {

    let subscribeTopItemView = SubscribeTopItemView()
    
    
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
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(ButtonCollectionViewCell.self, forCellWithReuseIdentifier: "ButtonCell")
            return collectionView
        }()
    
    let homeTopItemView = HomeTopItemView()
    let videoFrameView = VideoFrameView()
    let shortsFrameCollectionView = ShortsFrameCollectionView()
    
    // 添加 VideoFrameView 数组
    var videoFrameViews = [VideoFrameView]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.isScrollEnabled = true
        setupViews()
        setLayout()
    }


    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(homeTopItemView)
        contentView.addSubview(subscribeTopItemView)
        contentView.addSubview(collectionView)
        contentView.addSubview(videoFrameView)
        contentView.addSubview(shortsFrameCollectionView) // 將 shortsFrameCollectionView 添加到 contentView 的子視圖列表中

        
        // 创建并添加 10 个 VideoFrameView
//        for _ in 0..<10 {
//            let videoFrameView = VideoFrameView()
//            videoFrameViews.append(videoFrameView)
//            contentView.addSubview(videoFrameView)
//        }
    }

        
    private func setLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        homeTopItemView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        videoFrameView.translatesAutoresizingMaskIntoConstraints = false
        shortsFrameCollectionView.translatesAutoresizingMaskIntoConstraints = false
        subscribeTopItemView.translatesAutoresizingMaskIntoConstraints = false
        
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
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor) // 將底部錨點設置為 safeAreaLayoutGuide 的底部
        ])
        

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            // 不設置 contentView 的底部錨點
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 6000) //設定View的長度
        ])
        
        
        NSLayoutConstraint.activate([
            homeTopItemView.topAnchor.constraint(equalTo: contentView.topAnchor),
            homeTopItemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            homeTopItemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            homeTopItemView.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            subscribeTopItemView.topAnchor.constraint(equalTo: homeTopItemView.bottomAnchor), // 與 shortsFrameView 的上邊界對齊
            subscribeTopItemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            subscribeTopItemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            subscribeTopItemView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: subscribeTopItemView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            videoFrameView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            videoFrameView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            videoFrameView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            videoFrameView.heightAnchor.constraint(equalToConstant: 280)
        ])

        NSLayoutConstraint.activate([
            shortsFrameCollectionView.topAnchor.constraint(equalTo: videoFrameView.bottomAnchor), // 與 shortsFrameView 的上邊界對齊
            shortsFrameCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shortsFrameCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            shortsFrameCollectionView.heightAnchor.constraint(equalToConstant: 595)
        ])
 

        
        
        // 设置每个 VideoFrameView 的布局
        for (index, videoFrameView) in videoFrameViews.enumerated() {
            let frameWidth: CGFloat = 393
            let frameHeight: CGFloat = 280
            let verticalSpacing: CGFloat = 0 // 垂直间距，根据您的需求调整
            let y: CGFloat = 1680 + CGFloat(index) * (frameHeight + verticalSpacing)
            let x: CGFloat = 0
            videoFrameView.frame = CGRect(x: x, y: y, width: frameWidth, height: frameHeight)
        }

    }
    
    
}



extension SubscribeVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttonTitles.count // 返回 CollectionView 中的按钮数量
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonCell", for: indexPath) as! ButtonCollectionViewCell
        cell.button.setTitle(buttonTitles[indexPath.item], for: .normal) // 设置按钮标题为对应的文字
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let title = buttonTitles[indexPath.item]
        let width = title.count * 22 // 每个字符宽度为10（假设）
        let height: CGFloat = 70 // 固定高度

        return CGSize(width: CGFloat(width), height: height)

    }

}

//// 扩展 String，以获取文本的宽度
//extension String {
//    func widthOfString(usingFont font: UIFont) -> CGFloat {
//        let fontAttributes = [NSAttributedString.Key.font: font]
//        let size = self.size(withAttributes: fontAttributes)
//        return size.width
//    }
//}
