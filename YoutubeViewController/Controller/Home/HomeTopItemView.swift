
//
//  AutoLayoutHelper.swift
//  YoutubeViewController
//
//  Created by Lydia Lu on 2024/3/31.
//

import UIKit
import Foundation

class HomeTopItemView:UIView {

    lazy var leftImageView :UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
//        imgView.image = UIImage(named: "logo") // 設置左側圖片
        imgView.backgroundColor = UIColor.red
        return imgView
    }()
    
    let buttonLeft: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "display.2"), for: .normal) // 使用 SF Symbol
//        btn.backgroundColor = .clear // 設置背景色為透明
        btn.tintColor = .systemBlue // 設置圖標顏色
        return btn
    }()

    let buttonMid: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "bell"), for: .normal) // 使用 SF Symbol
//        btn.backgroundColor = .clear // 設置背景色為透明
        btn.tintColor = .systemBlue // 設置圖標顏色
        return btn
    }()

    let buttonRight: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "magnifyingglass"), for: .normal) // 使用 SF Symbol
//        btn.backgroundColor = .clear // 設置背景色為透明
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
    

    
    override init(frame: CGRect) {
        super.init(frame: .zero)
//        self.backgroundColor = .clear
        setupCustomViewLayout()
        
        setupNavigationBar()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    


  
    private func setupCustomViewLayout() {


        
        self.addSubview(leftImageView)
        self.addSubview(stackView)
        
        buttonLeft.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        buttonMid.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        buttonRight.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        // 設置 leftImageView 的約束
        NSLayoutConstraint.activate([
            // leftImageView 在左上角
            leftImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            leftImageView.topAnchor.constraint(equalTo: self.topAnchor),
            // 設置固定寬度和高度
            leftImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
            leftImageView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])

        // 設置 stackView 的約束
        NSLayoutConstraint.activate([
            // stackView 在右上角
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4)
        ])


        // 設置按鈕的垂直對齊方式為置中
        buttonLeft.contentVerticalAlignment = .center
        buttonMid.contentVerticalAlignment = .center
        buttonRight.contentVerticalAlignment = .center

        // 設置按鈕的水平對齊方式為置中
        buttonLeft.contentHorizontalAlignment = .center
        buttonMid.contentHorizontalAlignment = .center
        buttonRight.contentHorizontalAlignment = .center

//        // 將按鈕設置到 UIBarButtonItem 中
//        let leftButtonItem = UIBarButtonItem(customView: buttonLeft)
//        let midButtonItem = UIBarButtonItem(customView: buttonMid)
//        let rightButtonItem = UIBarButtonItem(customView: buttonRight)
//
//        // 設置左右 Bar Button Items
//        if let navigationController = findNavigationController() {
//            navigationController.navigationItem.leftBarButtonItems = [leftButtonItem]
//            navigationController.navigationItem.rightBarButtonItems = [midButtonItem, rightButtonItem]
//        }
        
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        switch sender {
        case buttonLeft:
            print("Left button tapped")
            presentAlertController(title: "﻿選取裝置", message: nil)
        case buttonMid:
            print("Middle button tapped")
            navigateToNotificationLogViewController()
        case buttonRight:
            print("Right button tapped")
            presentSearchViewController()
        default:
            break
        }
    }
    
    private func setupNavigationBar() {
        // 將按鈕設置到 UIBarButtonItem 中
        let leftButtonItem = UIBarButtonItem(customView: leftImageView)
        let rightButtonItem = UIBarButtonItem(customView: buttonLeft)


    }
    
    private func findNavigationController() -> UINavigationController? {
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            if let navigationController = nextResponder as? UINavigationController {
                return navigationController
            }
            responder = nextResponder
        }
        return nil
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


