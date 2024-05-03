//
//  SubscribeViewController.swift
//  YoutubeViewController
//
//  Created by Lydia Lu on 2024/4/5.
//

import UIKit

    protocol SubscribeVCDelegate: AnyObject {
        func didTapMenuButton()
        func didTapNotificationLog﻿ButtonMid()
    }

class SubscribeVC: UIViewController, ButtonCollectionCellDelegate {

        weak var delegate: SubscribeVCDelegate?
        
        let buttonTitles = ["﻿ 📍﻿ ", "﻿全部", "﻿音樂", "﻿遊戲", "﻿合輯", "﻿直播中", "﻿動畫", "﻿寵物", "﻿最新上傳", "讓你耳目一新的影片", "﻿提供意見"]
        
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
        
        
        // 添加 imageview
        lazy var imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.backgroundColor = UIColor.red // 將背景色設定為紅色
            return imageView
        }()
        

        
//        let homeTopItemView = HomeTopItemView()
        let subscribeSecItemView = SubscribeSecItemView()
        let videoFrameView = VideoFrameView()
        let subscribeHoriCollectionView = SubscribeHoriCollectionView(frame: CGRect.zero)
        var videoFrameViews = [VideoFrameView]()
        var menuViewController: MenuVC?
        var notificationLogViewController = NotificationLogVC()
        let videoFrameView2 = VideoFrameView()

    
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
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
//            contentView.addSubview(homeTopItemView)
            contentView.addSubview(subscribeSecItemView)
            contentView.addSubview(collectionView)
            contentView.addSubview(videoFrameView)
            contentView.addSubview(imageView)
            contentView.addSubview(subscribeHoriCollectionView)
            collectionView.register(ButtonCollectionViewCell.self, forCellWithReuseIdentifier: ButtonCollectionViewCell.identifier)
            
        }


        
        private func setLayout() {
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            contentView.translatesAutoresizingMaskIntoConstraints = false
//            homeTopItemView.translatesAutoresizingMaskIntoConstraints = false
            subscribeSecItemView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            videoFrameView.translatesAutoresizingMaskIntoConstraints = false
            subscribeHoriCollectionView.translatesAutoresizingMaskIntoConstraints = false
            
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
                contentView.bottomAnchor.constraint(equalTo: subscribeHoriCollectionView.bottomAnchor), // 更新這裡
                contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),


//                subscribeSecItemView
                subscribeSecItemView.topAnchor.constraint(equalTo: contentView.topAnchor), // 將 subscribeSecItemView 的 topAnchor 設置為 homeTopItemView 的 bottomAnchor
                subscribeSecItemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                subscribeSecItemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                subscribeSecItemView.heightAnchor.constraint(equalToConstant: 90), // 根據需要設置高度

                
                collectionView.topAnchor.constraint(equalTo: subscribeSecItemView.bottomAnchor),
                collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                collectionView.heightAnchor.constraint(equalToConstant: 60),

                videoFrameView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
                videoFrameView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                videoFrameView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                videoFrameView.heightAnchor.constraint(equalToConstant: 280),

                // imageView 布局
                imageView.topAnchor.constraint(equalTo: videoFrameView.bottomAnchor),
                imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                imageView.heightAnchor.constraint(equalToConstant: 70), // 設定高度為 160

                subscribeHoriCollectionView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
                subscribeHoriCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                subscribeHoriCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                subscribeHoriCollectionView.heightAnchor.constraint(equalToConstant: 300),
                

                
            ])
            
            setupVideoFrameViewsLayout()
            
            // 設定 scrollView 的 contentSize
            let contentHeight = contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height + videoFrameView2TotalHeight
            scrollView.contentSize = CGSize(width: view.bounds.width, height: contentHeight)
        }
    
    private func setupVideoFrameViewsLayout() {
        var previousHoriCollectionView: UIView = subscribeHoriCollectionView

        for _ in 0..<15 {
            let videoFrame = VideoFrameView()
            contentView.addSubview(videoFrame)
            videoFrame.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                videoFrame.topAnchor.constraint(equalTo: previousHoriCollectionView.bottomAnchor),
                videoFrame.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                videoFrame.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                videoFrame.heightAnchor.constraint(equalToConstant: 280)
            ])

            previousHoriCollectionView = videoFrame
        }

        
    }
    
    }


extension SubscribeVC: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
            
            if title == "﻿ 📍﻿ " {
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

