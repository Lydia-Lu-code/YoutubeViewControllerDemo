////
////  SubscribeViewController.swift
////  YoutubeViewController
////
////  Created by Lydia Lu on 2024/4/5.
////
//
//import UIKit
//
//class SubscribeVC: BaseViewController {
//    let keywords = ["2023 K-pop 一位安可舞台"]
//    let queries = ["2024 Dance shorts"]
//    
//    let subscribeSecItemView = SubscribeSecItemView()
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        doSearch(withKeywords: keywords)
//        setupRightBarButtonItems() // 調用新的方法來設置右側的 UIBarButtonItem
//    }
//    
//    override func setupViews() {
//        super.setupViews()
//        contentView.addSubview(subscribeSecItemView)
//        contentView.addSubview(self.singleVideoFrameView) // 使用 self. 來明確指定
//        contentView.addSubview(self.shortsStackView) // 使用 self. 來明確指定
//        homeShortsFrameCollectionView = HomeShortsFrameCollectionView()
//        contentView.addSubview(homeShortsFrameCollectionView)
//    }
//    
//    override func setLayout() {
//        super.setLayout()
//        subscribeSecItemView.translatesAutoresizingMaskIntoConstraints = false
//        self.singleVideoFrameView.translatesAutoresizingMaskIntoConstraints = false // 使用 self. 來明確指定
//        homeShortsFrameCollectionView.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            subscribeSecItemView.topAnchor.constraint(equalTo: contentView.topAnchor), // 將 subscribeSecItemView 的 topAnchor 設置為 homeTopItemView 的 bottomAnchor
//            subscribeSecItemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            subscribeSecItemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            subscribeSecItemView.heightAnchor.constraint(equalToConstant: 90), // 根據需要設置高度
//            
////            self.singleVideoFrameView.topAnchor.constraint(equalTo: collectionView.bottomAnchor), // 使用 self. 來明確指定
//            self.singleVideoFrameView.topAnchor.constraint(equalTo: subscribeSecItemView.bottomAnchor),
//            self.singleVideoFrameView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor), // 使用 self. 來明確指定
//            self.singleVideoFrameView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor), // 使用 self. 來明確指定
//            self.singleVideoFrameView.heightAnchor.constraint(equalToConstant: 370), // 使用 self. 來明確指定
//            
//            self.shortsStackView.topAnchor.constraint(equalTo: singleVideoFrameView.bottomAnchor), // 使用 self. 來明確指定
//            self.shortsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor), // 使用 self. 來明確指定
//            self.shortsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor), // 使用 self. 來明確指定
//            self.shortsStackView.heightAnchor.constraint(equalToConstant: 60), // 使用 self. 來明確指定
//            
//        ])
//    }
//}
//
//
//
//
