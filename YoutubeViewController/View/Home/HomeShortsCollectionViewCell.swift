

import UIKit

class HomeShortsCollectionViewCell: UICollectionViewCell {
    
    public static let cellIdentifier = "HomeShortsCollectionViewCell"
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .darkGray
        button.translatesAutoresizingMaskIntoConstraints = false
//        // 設置圖片的 contentMode 為 scaleAspectFill
//        button.imageView?.contentMode = .center
//        // 添加圖片約束
//            button.contentVerticalAlignment = .fill
//            button.contentHorizontalAlignment = .fill
        // 設置圖片約束
//        if let imageView = button.imageView {
//            imageView.translatesAutoresizingMaskIntoConstraints = false
//            NSLayoutConstraint.activate([
//                imageView.topAnchor.constraint(equalTo: button.topAnchor), // 圖片頂部對齊按鈕頂部
//                imageView.bottomAnchor.constraint(equalTo: button.bottomAnchor), // 圖片底部對齊按鈕底部
//                imageView.centerXAnchor.constraint(equalTo: button.centerXAnchor), // 圖片中心點與按鈕中心點水平對齊
//                imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1.0) // 圖片寬度與高度等比例拉長
//            ])
//        }
        
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
    
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
 
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }

    
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
        
        // 設置按鈕的高度與圖片的高度相同
        let imageHeightConstraint = button.imageView?.heightAnchor.constraint(equalTo: button.heightAnchor)
        imageHeightConstraint?.isActive = true
        
        // 設置圖片的中心點與按鈕的中心點對齊
        let centerXConstraint = button.imageView?.centerXAnchor.constraint(equalTo: button.centerXAnchor)
        let centerYConstraint = button.imageView?.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        centerXConstraint?.isActive = true
        centerYConstraint?.isActive = true
        

        
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
    }
    
}
