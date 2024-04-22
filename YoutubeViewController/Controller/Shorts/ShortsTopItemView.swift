//
//  ShortsTopItemView.swift
//  YoutubeViewController
//
//  Created by Lydia Lu on 2024/4/6.
//

import UIKit
import Foundation

class ShortsTopItemView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .clear
        setupCustomViewLayout()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let buttonLeft: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .red
        btn.setTitle("Button Left", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    let buttonRight1: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .green
        btn.setTitle("Button Right 1", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    let buttonRight2: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .orange
        btn.setTitle("Button Right 2", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    let stackViewTop: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    


    let buttonLeft1: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("訂閱", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .gray
        return btn
    }()
    
    let buttonLeft2: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("直播", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .gray
        return btn
    }()
    
    
    let stackViewBottom: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    private func setupCustomViewLayout() {
        // 添加按钮到 stackViewTop 中
        stackViewTop.addArrangedSubview(buttonLeft)
        stackViewTop.addArrangedSubview(UIView()) // 占位视图，使右侧按钮距离左侧按钮有一定的间距
        stackViewTop.addArrangedSubview(buttonRight1)
        stackViewTop.addArrangedSubview(buttonRight2)
        
        // 添加 stackViewTop 到 ShortsTopItemView 上
        addSubview(stackViewTop)
        
        
        stackViewBottom.addArrangedSubview(buttonLeft1)
        stackViewBottom.addArrangedSubview(buttonLeft2)
        stackViewBottom.addArrangedSubview(UIView())
        addSubview(stackViewBottom)
        
        
        // 添加 stackViewTop 的约束
        NSLayoutConstraint.activate([
            stackViewTop.topAnchor.constraint(equalTo: self.topAnchor),
            stackViewTop.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackViewTop.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackViewTop.heightAnchor.constraint(equalToConstant: 70)
            
        ])
        
        // 添加 stackViewBottom 的约束
        NSLayoutConstraint.activate([
            stackViewBottom.topAnchor.constraint(equalTo: stackViewTop.bottomAnchor, constant: 8),
            stackViewBottom.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackViewBottom.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackViewBottom.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackViewBottom.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        // 设置 buttonLeft 的约束
        NSLayoutConstraint.activate([
            buttonLeft.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3)
        ])
        
        // 设置 buttonRight1 的约束
        NSLayoutConstraint.activate([
            buttonRight1.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/8)
        ])
        
        // 设置 buttonRight2 的约束
        NSLayoutConstraint.activate([
            buttonRight2.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/8)
        ])
        
        NSLayoutConstraint.activate([
            buttonLeft1.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4)
        ])
        
        NSLayoutConstraint.activate([
            buttonLeft2.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4)
        ])
    }
}
