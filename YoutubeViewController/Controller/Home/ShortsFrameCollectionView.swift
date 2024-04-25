//
//  ShortsFrameCollectionView.swift
//  YoutubeViewController
//
//  Created by Lydia Lu on 2024/4/4.
//

import UIKit

class ShortsFrameCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    weak var viewController: UIViewController?
    
    private let cellIdentifier = "ShortsCell"
    
    
    var videoContents: [String] = ["Video 1 content", "Video 2 content", "Video 3 content", "Video 4 content"]
    
    let button = UIButton()
    
    // 新增右上角的 UIImageView
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.image = UIImage(named: "your_image_name") // 設置圖片
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // 新增兩行文字的 UILabel
    let titleLabel: UILabel = {
        let label = UILabel()
//        label.textColor = .black
        label.text = "Video 4 contentVideo 4 contentVideo 4 content"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.isScrollEnabled = false // 禁用自動滾動
        
        self.backgroundColor = .darkGray
        self.delegate = self
        self.dataSource = self
        
        self.register(ShortsCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }

    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: frame, collectionViewLayout: layout)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // 按鈕設定
        button.setTitleColor(.black, for: .normal)
//        button.backgroundColor = .yellow
        button.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(button) // 替換 contentView 為 self
        
        // 添加 imageView
        self.addSubview(imageView) // 替換 contentView 為 self
        
        // 添加 titleLabel
        self.addSubview(titleLabel) // 替換 contentView 為 self
        
        // 布局
        NSLayoutConstraint.activate([
            // 按钮约束
            button.topAnchor.constraint(equalTo: self.topAnchor),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            // imageView 右上角约束
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            imageView.widthAnchor.constraint(equalToConstant: 15),
            imageView.heightAnchor.constraint(equalToConstant: 15),
            
            // titleLabel 约束
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
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
        button.backgroundColor = .gray // 设置按钮背景颜色
        button.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(button)
        
        // 设置按钮约束为自适应内容大小
        button.setContentHuggingPriority(.required, for: .horizontal)
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        // 添加按钮约束
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: contentView.topAnchor),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        // 添加按钮点击事件处理程序
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
        // 创建一个新的 ShortsViewController 实例
        let shortsTableViewController = ShortsTableViewController()
        
        // 如果需要，将视频内容传递给 ShortsViewController
        shortsTableViewController.videoContent = videoContent
        
        // 从当前视图控制器中弹出 ShortsViewController
        viewController?.present(shortsTableViewController, animated: true, completion: nil)
    }
}

    

