//
//  SubscribeTopItemView.swift
//  YoutubeViewController
//
//  Created by Lydia Lu on 2024/4/6.
//

import UIKit
import Foundation


class SubscribeSecItemView: UIView {

    override init(frame: CGRect) {
        super.init(frame: .zero)
//        self.backgroundColor = .black
        setupScrollView()
        setupButtons()
        setupRightButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let buttons: [UIButton] = {
        var buttonArray = [UIButton]()
        for i in 1...20 {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = .clear
            
            // 設置圖片和文字的內容
            let originalImage = UIImage(named: "image2")
            let imageSize = CGSize(width: 65, height: 65) // 設置圖片大小
            let roundedImage = originalImage?.roundedImage(withSize: imageSize)
            button.setImage(roundedImage, for: .normal)
            
            let title = "Emoji \(i)"
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.titleLabel?.textAlignment = .center
            
            // 設置圖片和文字的排列方式
            button.contentHorizontalAlignment = .center
            button.contentVerticalAlignment = .top

            
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
        for button in buttons {
            button.titleLabel?.numberOfLines = 2 // 允許換行
            button.titleLabel?.textAlignment = .center // 文字置中
            
            // 將按鈕添加到 stackView 中
            stackView.addArrangedSubview(button)
        }
    }


    private func setupRightButton() {
        self.addSubview(rightButton)
        
        NSLayoutConstraint.activate([
            rightButton.widthAnchor.constraint(equalToConstant: 65),
            rightButton.heightAnchor.constraint(equalToConstant: 80),
            rightButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            rightButton.topAnchor.constraint(equalTo: self.topAnchor)
        ])
    }
   
}
extension UIImage {
    func roundedImage(withSize size: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            let roundedRect = CGRect(origin: .zero, size: size)
            UIBezierPath(roundedRect: roundedRect, cornerRadius: size.width/2).addClip()
            self.draw(in: roundedRect)
        }
    }
}


