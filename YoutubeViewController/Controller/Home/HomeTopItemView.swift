//
//  AutoLayoutHelper.swift
//  YoutubeViewController
//
//  Created by Lydia Lu on 2024/3/31.
//

import UIKit
import Foundation

class HomeTopItemView:UIView {

    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .clear
        setupCustomViewLayout()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var leftImageView :UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.backgroundColor = UIColor.red
        return imgView
    }()
    
    let buttonLeft: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "display.2"), for: .normal) // 使用 SF Symbol
        btn.backgroundColor = .clear // 設置背景色為透明
        btn.tintColor = .systemBlue // 設置圖標顏色
        return btn
    }()

    let buttonMid: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "bell"), for: .normal) // 使用 SF Symbol
        btn.backgroundColor = .clear // 設置背景色為透明
        btn.tintColor = .systemBlue // 設置圖標顏色
        return btn
    }()

    let buttonRight: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "magnifyingglass"), for: .normal) // 使用 SF Symbol
        btn.backgroundColor = .clear // 設置背景色為透明
        btn.tintColor = .systemBlue // 設置圖標顏色
        return btn
    }()
  
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(buttonLeft)
        stackView.addArrangedSubview(buttonMid)
        stackView.addArrangedSubview(buttonRight)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()


  
    private func setupCustomViewLayout() {
        // 添加约束
        self.addSubview(leftImageView)
        self.addSubview(stackView)
        
        buttonLeft.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        buttonMid.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        buttonRight.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        NSLayoutConstraint.activate([
        
            leftImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            leftImageView.topAnchor.constraint(equalTo: self.topAnchor),
            leftImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
            leftImageView.heightAnchor.constraint(equalTo: self.heightAnchor), // 设置leftImageView高度与父视图相同
            
            // StackView约束
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            
        ])

        // 設置按鈕的垂直對齊方式為置中
        buttonLeft.contentVerticalAlignment = .center
        buttonMid.contentVerticalAlignment = .center
        buttonRight.contentVerticalAlignment = .center

        // 設置按鈕的水平對齊方式為置中
        buttonLeft.contentHorizontalAlignment = .center
        buttonMid.contentHorizontalAlignment = .center
        buttonRight.contentHorizontalAlignment = .center

    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        switch sender {
        case buttonLeft:
            presentAlertController(title: "﻿選取裝置", message: nil)
        case buttonMid:
            navigateToNotificationLogViewController()
        case buttonRight:
            presentSearchViewController()
        default:
            break
        }
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


    private func presentSearchViewController() {
        guard let viewController = findViewController() else {
            print("無法找到視圖控制器")
            return
        }
        
        let SearchVC = SearchVC()
        viewController.present(SearchVC, animated: true, completion: nil)
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
    

      
}


