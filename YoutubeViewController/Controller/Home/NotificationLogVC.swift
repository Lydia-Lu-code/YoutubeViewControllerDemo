////
////  NotificationLogViewController.swift
////  YoutubeViewController
////
////  Created by Lydia Lu on 2024/4/17.
////

import UIKit

class NotificationLogVC: UIViewController {
    
    
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal // 水平滾動
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false // 隱藏水平滾動條
        return collectionView
    }()
    
    private let buttonCellIdentifier = "TopButtonCollectionCell"
    
    private let customView: CustomView = {
        let view = CustomView()
        view.backgroundColor = .clear
        // 設置自定義視圖的其他屬性
        return view
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        // 設置 tableView 的其他屬性
        return tableView
    }()
    
    let buttonTitles = ["﻿全部","「提及」的通知"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        
        // 添加 collectionView 到 ViewController 的 view 中
        view.addSubview(collectionView)
        
        // 添加自定義視圖到 ViewController 的 view 中
        view.addSubview(customView)
        
        // 添加 tableView 到 ViewController 的 view 中
        view.addSubview(tableView)
        
        // 約束設置
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        customView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // collectionView 約束
            
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 50), // 高度設置
            
 
            customView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customView.heightAnchor.constraint(equalToConstant: 80),

            
//            // 自定義視圖的約束
////            customView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
//            customView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
//            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            customView.heightAnchor.constraint(equalToConstant: 160), // 設置高度
            
            // tableView 的約束
            tableView.topAnchor.constraint(equalTo: customView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Configure the CustomView
         let image = UIImage(named: "yourImageName")
         customView.configure(image: image, text1: "Top Label Text", text2: "Bottom Label Text", buttonText: "Button")

        
        // 註冊 cell
        collectionView.register(TopButtonCollectionCell.self, forCellWithReuseIdentifier: buttonCellIdentifier)
        
        // 註冊 tableView 的 cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    // MARK: - UICollectionViewDataSource
}
extension NotificationLogVC: UICollectionViewDelegate, UICollectionViewDataSource {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 2 // 填入你的數據源計算
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: buttonCellIdentifier, for: indexPath) as! TopButtonCollectionCell
            cell.configure(title: buttonTitles[indexPath.item], backgroundColor: .blue) // 根據陣列中的標題設置按鈕
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let title = buttonTitles[indexPath.item]
            let width = title.width(withConstrainedHeight: 50, font: UIFont.systemFont(ofSize: 16, weight: .semibold)) + 20 // 加上一些額外的間距
            let height: CGFloat = 50
            return CGSize(width: width, height: height)
            
        }
}
    





    // MARK: - UITableViewDataSource

extension NotificationLogVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15 // 15 個 cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // 設置 cell 的內容
        cell.textLabel?.text = "Cell \(indexPath.row)"
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 點擊 cell 的動作
        print("Did select row at: \(indexPath.row)")
    }
}

extension String {
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: [.usesLineFragmentOrigin, .usesFontLeading],
                                            attributes: [NSAttributedString.Key.font: font],
                                            context: nil)
        return ceil(boundingBox.width)
    }
}

