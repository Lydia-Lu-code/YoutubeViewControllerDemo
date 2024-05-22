////
////  ScrollViewSubViewController.swift
////  YoutubeViewController
////
////  Created by Lydia Lu on 2024/5/17.
////
//
//import UIKit
//
//class ScrollViewSubViewController: UIViewController {
//    
//    // 垂直滑動的父視圖，包含橫向滑動的CollectionView
//    let scrollView: UIScrollView = {
//        let scrollView = UIScrollView()
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        return scrollView
//    }()
//    
//    // ﻿橫向滑動的CollectionView
//    let horiCollectionView: SubscribeHoriCollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        let collectionView = SubscribeHoriCollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        return collectionView
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // 添加ScrollView到視圖中
//        view.addSubview(scrollView)
//        
//        // 添加HoriCollectionView到ScrollView中
//        scrollView.addSubview(horiCollectionView)
//        
//        // 設置ScrollView的約束
//        NSLayoutConstraint.activate([
//            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//        
//        // 設置HoriCollectionView的約束
//        NSLayoutConstraint.activate([
//            horiCollectionView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            horiCollectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            horiCollectionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//            horiCollectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//            horiCollectionView.heightAnchor.constraint(equalTo: scrollView.heightAnchor) // 設置高度等於ScrollView的高度
//        ])
//        
//        // 為了示範，設置HoriCollectionView的背景顏色
//        horiCollectionView.backgroundColor = .darkGray
//        
//        // 設置HoriCollectionView的searchResults和videoContents
//        horiCollectionView.searchResults = /* 設置搜索結果 */
//        horiCollectionView.videoContents = /* 設置影片內容 */
//    }
//}
//
