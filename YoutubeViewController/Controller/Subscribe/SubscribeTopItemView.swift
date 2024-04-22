//
//  SubscribeTopItemView.swift
//  YoutubeViewController
//
//  Created by Lydia Lu on 2024/4/6.
//

import UIKit
import Foundation


class SubscribeTopItemView: UIView {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .black
        setupScrollView()
        setupButtons()
        setupRightButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let buttons: [UIButton] = {
        var buttonArray = [UIButton]()
        for i in 1...50 {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = .clear
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            
            // 添加 emoji 和文字到按鈕的標題中，並在它們之間換行
            let emoji = "🥳"
            let title = "\(emoji)\nEmoji \(i)"
            button.setTitle(title, for: .normal)
            button.titleLabel?.numberOfLines = 2
            button.titleLabel?.textAlignment = .center
            
            buttonArray.append(button)
        }
        return buttonArray
    }()

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
  
    lazy var stackView: UIStackView = {
         let stackView = UIStackView()
         stackView.translatesAutoresizingMaskIntoConstraints = false
         stackView.axis = .horizontal
         stackView.distribution = .fill
         stackView.spacing = 8
         for button in buttons {
             stackView.addArrangedSubview(button)
         }
         return stackView
     }()
    
    let rightButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.setTitle("全部", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    private func setupScrollView() {
        self.addSubview(scrollView)
        
        // 添加 scrollView 到父視圖
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        // 添加 stackView 到 scrollView 中
        scrollView.addSubview(stackView)
        
        // 添加 stackView 的尺寸約束
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)

        ])
    }
    
    private func setupButtons() {
        // 設置按鈕的尺寸約束
        for button in buttons {
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: 60),
                button.heightAnchor.constraint(equalToConstant: 60)
            ])
            
            // 設置文字尺寸
            if let titleLabel = button.titleLabel {
                titleLabel.font = UIFont.systemFont(ofSize: 20)
                titleLabel.numberOfLines = 2
                titleLabel.textAlignment = .center
            }
        }
    }
    
    private func setupRightButton() {
        self.addSubview(rightButton)
        
        NSLayoutConstraint.activate([
            rightButton.widthAnchor.constraint(equalToConstant: 60),
            rightButton.heightAnchor.constraint(equalToConstant: 80),
            rightButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            rightButton.topAnchor.constraint(equalTo: self.topAnchor)
        ])
    }
   
}
