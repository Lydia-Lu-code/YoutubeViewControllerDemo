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

        setTopBarButton()

        tableView.register(ContentTableViewCell.self, forCellReuseIdentifier: "ContentTableViewCell")
        // 设置 contentInset
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
}

    

    
    
    func setTopBarButton(){
 
        let btn1 = UIBarButtonItem(image: UIImage(systemName: "display.2"), style: .plain, target: self, action: #selector(topButtonTapped))
        let btn2 = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: #selector(topButtonTapped))
        let btn3 = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(topButtonTapped))
//        let btn4 = UIBarButtonItem(image: UIImage(named: "image2"), style: .plain, target: self, action: #selector(topButtonTapped))
        
        let btn4 = UIBarButtonItem(image: UIImage(named: "image2")?.withRenderingMode(.alwaysOriginal).withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(topButtonTapped))
        btn4.image?.withRenderingMode(.alwaysTemplate)
        btn4.image?.withRenderingMode(.alwaysOriginal)
        btn4.image?.withRenderingMode(.automatic)
        // 访问按钮的customView
        if let buttonView = btn4.customView {
            // 设置圆角
            buttonView.layer.cornerRadius = 5
            buttonView.layer.masksToBounds = true // 必须将masksToBounds属性设置为true，以确保圆角生效
        }
        
        
        // 将按钮添加到导航栏上
        self.navigationItem.setRightBarButtonItems([btn4, btn3, btn2, btn1], animated: true)
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
        // 在這裡實現您的 presentSearchViewController 方法
        // 例如，可以是簡單的彈出搜索視圖控制器的代碼
        let searchVC = SearchVC() // 假設 SearchViewController 是您的搜索視圖控制器類
        self.present(searchVC, animated: true, completion: nil)
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
