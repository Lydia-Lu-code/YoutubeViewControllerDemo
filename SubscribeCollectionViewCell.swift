////
////  SubscribeCollectionViewCell.swift
////  YoutubeViewController
////
////  Created by Lydia Lu on 2024/5/17.
////
//
//import UIKit
//
//class SubscribeCollectionViewCell: UICollectionViewCell {
//    var videoContent: String?
//    weak var viewController: UIViewController? // 添加 viewController 屬性
//    let button = UIButton()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupButton()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupButton() {
//        button.setTitleColor(.black, for: .normal)
//        button.backgroundColor = .gray // 设置按钮背景颜色
//        button.translatesAutoresizingMaskIntoConstraints = false
//        contentView.addSubview(button)
//        
//        // 设置按钮约束为自适应内容大小
//        button.setContentHuggingPriority(.required, for: .horizontal)
//        button.setContentCompressionResistancePriority(.required, for: .horizontal)
//        
//        // 添加按钮约束
//        NSLayoutConstraint.activate([
//            button.topAnchor.constraint(equalTo: contentView.topAnchor),
//            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//        ])
//        
//        // 添加按钮点击事件处理程序
//        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        // 設定圓角為 20
//        self.layer.cornerRadius = 20
//        self.layer.masksToBounds = true
//    }
//    
//    // 按钮点击事件处理程序
//    @objc private func buttonTapped() {
//        
//        print("SubscribeCollectionViewCell.buttonTapped()")
//        //            // 创建一个新的 SubscribeViewController 实例
//        //            let shortsTableViewController = ShortsTableViewController()
//        //
//        //            // 如果需要，将视频内容传递给 ShortsViewController
//        //            shortsTableViewController.videoContent = videoContent
//        //
//        //            // 从当前视图控制器中弹出 ShortsViewController
//        //            viewController?.present(shortsTableViewController, animated: true, completion: nil)
//        //
//    }
//    
//}
