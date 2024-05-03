import UIKit


// ﻿橫向滑動的CollectionView
class SubscribeHoriCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
        
        weak var viewController: UIViewController?
        
        private let cellIdentifier = "SubscribeCell"
        
        
    var videoContents: [String] = ["影片1內容", "影片2內容", "影片3內容", "影片4內容","影片5內容", "影片6內容", "影片7內容", "影片8內容","影片9內容", "影片10內容", "影片11內容", "影片12內容","影片13內容", "影片14內容", "影片15內容"]
        
        let button = UIButton()
        
        init(frame: CGRect) {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal // 設定水平滾動
            super.init(frame: frame, collectionViewLayout: layout)
            
            self.backgroundColor = .darkGray
            self.showsHorizontalScrollIndicator = false // 隱藏水平滾動條
            self.delegate = self
            self.dataSource = self
            
            self.register(SubscribeCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
            
            // 呼叫 setupUI() 設置介面元素
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
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! SubscribeCollectionViewCell
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

class SubscribeCollectionViewCell: UICollectionViewCell {
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
            // 创建一个新的 SubscribeViewController 实例
            let shortsTableViewController = ShortsTableViewController()
            
            // 如果需要，将视频内容传递给 ShortsViewController
            shortsTableViewController.videoContent = videoContent
            
            // 从当前视图控制器中弹出 ShortsViewController
            viewController?.present(shortsTableViewController, animated: true, completion: nil)
        
        }

}
