import UIKit

class NotificationTableViewCell: UITableViewCell {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 3 // 設置行數為 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(cellImageView)
        
        NSLayoutConstraint.activate([
            cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cellImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cellImageView.widthAnchor.constraint(equalToConstant: 40),
            cellImageView.heightAnchor.constraint(equalToConstant: 40),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
            
            
        ])
        
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
//        // 設置 titleLabel 的最大高度約束，最多顯示三行文字
//        let maxHeight: CGFloat = 20 * 3 // 三行文字，每行高度為 20
//        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
//        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
//        titleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: maxHeight).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(image: UIImage?, title: String, subtitle: String) {
        cellImageView.image = image
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}


//class NotificationTableViewCell: UITableViewCell {
//    
//    private let cellView: UIView = {
//        let view = UIView()
//        view.layer.shadowOffset = CGSize(width: 0, height: 2)
//        view.layer.shadowRadius = 4
//        view.layer.shadowOpacity = 0.2
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    private let iconImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        imageView.layer.cornerRadius = 20
//        imageView.clipsToBounds = true
//        imageView.backgroundColor = .lightGray
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//    
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        // 設置標題 label 的行數為 3，預留三行文字的高度
//        label.numberOfLines = 3
//        return label
//    }()
//    
//    private let subtitleLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 14)
//        label.numberOfLines = 1
//        label.textColor = .gray
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupViews()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupViews() {
//        addSubview(cellView)
//        cellView.addSubview(iconImageView)
//        cellView.addSubview(titleLabel)
//        cellView.addSubview(subtitleLabel)
//        
//        NSLayoutConstraint.activate([
//            // cellView 位置和大小
//            cellView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
//            cellView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
//            cellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
//            cellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
//            
//            // iconImageView 位置和大小
//            iconImageView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10),
//            iconImageView.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
//            iconImageView.widthAnchor.constraint(equalToConstant: 40),
//            iconImageView.heightAnchor.constraint(equalToConstant: 40),
//            
//            // titleLabel 位置和大小
//            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
//            titleLabel.topAnchor.constraint(equalTo: iconImageView.topAnchor),
//            titleLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -10),
//
//            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: cellView.bottomAnchor, constant: -10), // 可以多行折行
//
//            
//            // subtitleLabel 位置和大小
//            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
//            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
//            subtitleLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -10),
//        ])
//    }
//    
//    func configure(image: UIImage?, title: String, subtitle: String) {
//        iconImageView.image = image
//        titleLabel.text = title
//        subtitleLabel.text = subtitle
//    }
//}
