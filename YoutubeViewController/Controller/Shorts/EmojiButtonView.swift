//
//  EmojiButtonView.swift
//  YoutubeViewController
//
//  Created by Lydia Lu on 2024/4/6.
//

import UIKit
import Foundation

class EmojiButtonView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupEmojiButtonViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupEmojiButtonViews() {
        backgroundColor = .gray
        
        // 创建垂直的 stackView
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        addSubview(stackView)
        
        // 添加约束
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        // 添加六個按鈕到 stackView 中
        for i in 1...6 {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = .yellow
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            
            // 添加 emoji 和文字到按鈕的標題中，並在它們之間換行
            let emoji = "🥳"
            let title = "\(emoji)\nEmoji \(i)"
            button.setTitle(title, for: .normal)
            button.titleLabel?.numberOfLines = 2
            button.titleLabel?.textAlignment = .center
            
            // 添加按鈕到 stackView 中
            stackView.addArrangedSubview(button)
            
            // 添加按鈕的尺寸约束
            NSLayoutConstraint.activate([
                button.heightAnchor.constraint(equalToConstant: 60)
            ])
        }
    }
    
}
