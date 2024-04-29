//
//  CustomHeaderView.swift
//  YoutubeViewController
//
//  Created by Lydia Lu on 2024/4/26.
//

import UIKit

class ContentHeaderView: UIView {
    
    let leftButton: UIButton = {
        let button = UIButton()
        button.setTitle("Left Button", for: .normal)
        button.backgroundColor = .systemBlue

        button.translatesAutoresizingMaskIntoConstraints = false
        // 添加按鈕的其他設置...
        return button
    }()
    
    let rightButton: UIButton = {
        let button = UIButton()
        button.setTitle("Right Button", for: .normal)
        button.backgroundColor = .brown
        button.translatesAutoresizingMaskIntoConstraints = false
        // 添加按鈕的其他設置...
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        // 在這裡設置 header view 的背景色
//        backgroundColor = UIColor.gray // 自定義顏色
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(leftButton)
        addSubview(rightButton)
        
        // 左按鈕約束
        leftButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        leftButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        // 右按鈕約束
        rightButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        rightButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
