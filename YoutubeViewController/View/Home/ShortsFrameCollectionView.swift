//
//  ShortsFrameCollectionView.swift
//  YoutubeViewController
//
//  Created by Lydia Lu on 2024/4/4.
//

import UIKit


class ShortsFrameCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    weak var viewController: UIViewController?
    
    private let cellIdentifier = "ShortsTableViewCell"
    
    
    var videoContents: [String] = ["Video 1 content", "Video 2 content", "Video 3 content", "Video 4 content"]
    
    let button = UIButton()
    

    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
  
        let layout = UICollectionViewFlowLayout()
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.isScrollEnabled = false // 禁用自動滾動
        self.delegate = self
        self.dataSource = self
        
        self.register(ShortsCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // 按鈕設定
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(button) // 替換 contentView 為 self
        
        // 添加 imageView
//        self.addSubview(imageView) // 替換 contentView 為 self
//        
//        // 添加 titleLabel
//        self.addSubview(titleLabel) // 替換 contentView 為 self
        
        // 布局
        NSLayoutConstraint.activate([
            // 按钮约束
            button.topAnchor.constraint(equalTo: self.topAnchor),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
        ])
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoContents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ShortsCollectionViewCell
        cell.videoContent = videoContents[indexPath.item]
        cell.viewController = viewController // 傳遞 viewController
        return cell
        
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let viewController = viewController else { return }
        let shortsTableViewController = ShortsTableViewController()
        shortsTableViewController.videoContent = videoContents[indexPath.item]
        viewController.present(shortsTableViewController, animated: true, completion: nil)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 30) / 2
        return CGSize(width: width, height: 285)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
}

class ShortsCollectionViewCell: UICollectionViewCell {
    var videoContent: String?
    weak var viewController: UIViewController? // 添加 viewController 屬性
    let button = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .gray // 設置按鈕背景顏色
        button.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(button)
        
        // 添加圖像視圖
        let imageView = UIImageView()
//        imageView.backgroundColor = .white
        imageView.image = UIImage(systemName: "ellipsis") // 使用三個點符號作為示意圖
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(imageView)
        
        // 添加兩行文字的標籤
        let titleLabel = UILabel()
        titleLabel.text = "Video 4 content\nSecond line" // 這裡是示例文字，您可以替換為您的內容
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(titleLabel)
        
        
//        imageView.layer.cornerRadius = 15 // 圓形的半徑為高度的一半
//        imageView.clipsToBounds = true // 剪切超出圓形範圍的部分
        
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
            titleLabel.heightAnchor.constraint(equalToConstant: 40) // 設置標籤的高度為40

        ])
        
        // 設置按鈕的約束
        NSLayoutConstraint.activate([
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
        // 創建一個新的 ShortsTableViewController 的實例
        let shortsTableViewController = ShortsTableViewController()
        
        // 如果有需要，將視頻內容傳遞給 ShortsTableViewController
        shortsTableViewController.videoContent = videoContent
        
        // 確保 viewController 不為 nil
        guard let viewController = self.viewController else {
            // 如果 viewController 為 nil，可以輸出一條日誌以警告開發者
            print("Error: viewController is nil.")
            return
        }
        
        // 從當前視圖控制器中顯示 ShortsTableViewController
        viewController.present(shortsTableViewController, animated: true, completion: nil)
    }

}

    

