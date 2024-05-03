//
//  YourContentViewController.swift
//  YoutubeViewController
//
//  Created by Lydia Lu on 2024/4/5.
//

import UIKit

class ContentTableViewController: UITableViewController {
    
    lazy var contentTopView: ContentTopView = {
        let view = ContentTopView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        setTopBarButton()

        tableView.register(ContentTableViewCell.self, forCellReuseIdentifier: "ContentTableViewCell")
        // 设置 contentInset
//        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 0
        tableView.sectionHeaderTopPadding = 0

}

    

    
    
    func setTopBarButton(){
 
//        let width: CGFloat = 5.0
        
        let btn1 = UIBarButtonItem(image: UIImage(systemName: "display.2"), style: .plain, target: self, action: #selector(topButtonTapped))
//        btn1.width = width
        
        let btn2 = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: #selector(topButtonTapped))
//        btn2.width = width
        
        let btn3 = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(topButtonTapped))
//        btn3.width = width
        
//        let btn4 = UIBarButtonItem(image: UIImage(named: "image2"), style: .plain, target: self, action: #selector(topButtonTapped))
        
        // 调整图像大小
        let image = UIImage(named: "image3")?.withRenderingMode(.alwaysOriginal)
        let resizedImage = resizeImage(image: image, targetSize: CGSize(width: 55, height: 30)) // 调整图像大小为 20x20
        
        let btn4 = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(topButtonTapped))
//        btn4.width = width
        
        // 设置圆角
        if let buttonView = btn4.customView {
            buttonView.layer.cornerRadius = 10
            buttonView.layer.masksToBounds = true
        }
        
        
        // 将按钮添加到导航栏上
        self.navigationItem.setRightBarButtonItems([btn4, btn3, btn2, btn1], animated: true)
    }
    
    func resizeImage(image: UIImage?, targetSize: CGSize) -> UIImage? {
        guard let image = image else { return nil }
        
        let size = image.size
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        
        let newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        let rect = CGRect(origin: .zero, size: newSize)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }

    @objc func topButtonTapped(_ sender: UIBarButtonItem) {
        switch sender {
        case navigationItem.rightBarButtonItems?[0]: // buttonLeft
            print("Content 4 button tapped")
            
        case navigationItem.rightBarButtonItems?[3]: // buttonLeft
            print("Content Left button tapped")
            presentAlertController(title: "﻿選取裝置", message: nil)
        case navigationItem.rightBarButtonItems?[2]: // buttonMid
            print("Content Middle button tapped")
            navigateToNotificationLogViewController()
        case navigationItem.rightBarButtonItems?[1]: // buttonRight
            print("Content Right button tapped")
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

    // MARK: - Table view data source
        
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 6 // 5個部分
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        } else if section == 1 || section == 2 {
            return 1
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContentTableViewCell", for: indexPath) as! ContentTableViewCell
        
        // 設置 section 的值
        cell.section = indexPath.section

        cell.setupViews()

        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = UIView()
            
            // Add your custom content here
            let contentTopView = ContentTopView()
            contentTopView.translatesAutoresizingMaskIntoConstraints = false
            headerView.addSubview(contentTopView)
            
            NSLayoutConstraint.activate([
                contentTopView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
                contentTopView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
                contentTopView.topAnchor.constraint(equalTo: headerView.topAnchor),
                contentTopView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
            ])
       
            return headerView
        } else {
            let headerView = ContentHeaderView()
            
            // 可以根據需要設置按鈕的標題、樣式等屬性
            headerView.leftButton.setTitle("Left Button", for: .normal)
            headerView.rightButton.setTitle("Right Button", for: .normal)
            headerView.backgroundColor = .lightGray
            // 設置按鈕的點擊事件等
            
            return headerView
        }
    }
    
    // 設置 header 的高度
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 160
        } else {
          return 60
        }
        

    }
    
    // 設置 cell 的高度
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
}
