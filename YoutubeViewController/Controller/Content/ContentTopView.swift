//
//  CustomTopView.swift
//  YoutubeViewController
//
//  Created by Lydia Lu on 2024/4/26.
//

import UIKit

class ContentTopView: UIView {

    // MARK: - Properties

    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "image1")
//        imageView.backgroundColor = .lightGray // 設定圖片背景色
        return imageView
    }()

    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white // 設定文字顏色
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Label"
        return label
    }()

    lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Button", for: .normal)
        button.backgroundColor = .orange
        button.setTitleColor(.blue, for: .normal) // 設定按鈕文字顏色
        return button
    }()
    
    

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
//        stackView.spacing = 8
        return stackView
    }()

    lazy var btn1: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Button1", for: .normal)
        button.backgroundColor = .systemYellow
        button.setTitleColor(.blue, for: .normal) // 設定按鈕文字顏色
        return button
    }()
    
    lazy var btn2: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Button2", for: .normal)
        button.backgroundColor = .systemYellow
        button.setTitleColor(.blue, for: .normal) // 設定按鈕文字顏色
        return button
    }()
    
    lazy var btn3: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Button3", for: .normal)
        button.backgroundColor = .systemYellow
        button.setTitleColor(.blue, for: .normal) // 設定按鈕文字顏色
        return button
    }()
    
    lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        return stackView
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup UI

    private func setupUI() {
        addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(stackView)
        containerView.addSubview(bottomStackView)

        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(button)
        
        bottomStackView.addArrangedSubview(btn1)
        bottomStackView.addArrangedSubview(btn2)
        bottomStackView.addArrangedSubview(btn3)

        NSLayoutConstraint.activate([

            containerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            
            // imageView 的約束
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16), // 調整偏移量以適應 UI
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16), // 調整偏移量以適應 UI
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),

            // stackView 的約束
            stackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
            stackView.topAnchor.constraint(equalTo: imageView.topAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 80),
         

            // bottomStackView 的約束
            bottomStackView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            bottomStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16), // 調整偏移量以適應 UI
            bottomStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16) // 調整偏移量以適應 UI

         ])
     }

    

}
