import UIKit

protocol ButtonCollectionCellDelegate: AnyObject {
    func didTapButton()
}

class ButtonCollectionViewCell: UICollectionViewCell {
    static let identifier = "ButtonCollectionViewCell"
    // 父視圖控制器的委託
    weak var delegate: ButtonCollectionCellDelegate?
    
    
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15 // 圓角設置為15
        button.layer.masksToBounds = true // 裁剪超出部分
        return button
    }()
    
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
        
        // 設置按鈕約束為自適應內容大小
        button.setContentHuggingPriority(.required, for: .horizontal)
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        // 添加按鈕約束
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: contentView.topAnchor),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}


