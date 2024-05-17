//
//  ShortsCollectionViewCell.swift
//  YoutubeViewController
//
//  Created by Lydia Lu on 2024/5/14.
//

import UIKit

class HomeShortsCollectionViewCell: UICollectionViewCell {
//    var videoContent: String?
//    weak var viewController: UIViewController? // 添加 viewController 屬性

    var searchItem: SearchItem? // 將 videoContent 屬性改為 SearchItem
      
    
    public let cellIdentifier = "HomeShortsCollectionViewCell"
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .darkGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button // 返回創建的按鈕實例
    }()
    
    // 添加圖像視圖
    let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "ellipsis") // 使用三個點符號作為示意圖
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image // 返回創建的圖像視圖實例
    }()
    
    // 添加兩行文字的標籤
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.text = "Placeholder"
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label // 返回創建的標籤實例
    }()
    
//    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
//    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }

    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
    public func setupButton() {
        
        
        contentView.addSubview(button)
        button.addSubview(imageView)
        button.addSubview(titleLabel)
        
        // 設置圖像視圖和標籤的約束
        NSLayoutConstraint.activate([
            // 圖像視圖約束
            imageView.topAnchor.constraint(equalTo: button.topAnchor, constant: 12),
            imageView.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -17),
            imageView.widthAnchor.constraint(equalToConstant: 20),
            imageView.heightAnchor.constraint(equalToConstant: 20),
            
            // 標籤約束
            titleLabel.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -12),
            titleLabel.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: -12),
            titleLabel.heightAnchor.constraint(equalToConstant: 40), // 設置標籤的高度為40
            
            button.topAnchor.constraint(equalTo: contentView.topAnchor),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        // 添加按鈕點擊事件處理程序
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 設定圓角為 20
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
    }
    
    // 按钮点击事件处理程序
    
    @objc private func buttonTapped() {
        
        print("Button tapped")
//        // 創建一個新的 ShortsTableViewController 的實例
//        let shortsTableViewController = ShortsTableViewController()
//        
//        // 如果有需要，將影片內容傳遞給 ShortsTableViewController
//        shortsTableViewController.videoContent = videoContent
//        
//        // 確保 viewController 不為 nil
//        guard let viewController = self.viewController else {
//            // 如果 viewController 為 nil，可以輸出一條日誌以警告開發者
//            print("Error: viewController is nil.")
//            return
//        }
//        
//        // 從當前視圖控制器中顯示 ShortsTableViewController
//        viewController.present(shortsTableViewController, animated: true, completion: nil)
    }
    
    func configure(with item: SearchItem) {
        titleLabel.text = item.snippet.title
        if let url = URL(string: item.snippet.thumbnails.medium.url) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
    
}
