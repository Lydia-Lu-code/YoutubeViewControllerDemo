//
//  ShortsViewController.swift
//  YoutubeViewController
//
//  Created by Lydia Lu on 2024/4/4.
//

import UIKit

class ShortsVC: UIViewController {

    let shortsTopItemView = ShortsTopItemView()
    let emojiButtonView = EmojiButtonView()
    let shorstBottomView = ShorstBottomView()
    
    var videoContent: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews() // 設定視圖

    }
    
    private func setupViews() {
        view.addSubview(shortsTopItemView)
        view.addSubview(emojiButtonView)
        view.addSubview(shorstBottomView)
        
        // 設定 shortsTopItemView 的約束
        NSLayoutConstraint.activate([
            shortsTopItemView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            shortsTopItemView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            shortsTopItemView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            shortsTopItemView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        // 添加約束
        NSLayoutConstraint.activate([
            emojiButtonView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emojiButtonView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90)
        ])
        
        NSLayoutConstraint.activate([
            shorstBottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            shorstBottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -220)
        ])
        
        setLayout()  // 設定佈局
    }
    
    private func setLayout() {
        // 在這裡可以設定其他視圖的佈局
        shortsTopItemView.translatesAutoresizingMaskIntoConstraints = false
        emojiButtonView.translatesAutoresizingMaskIntoConstraints = false
        shorstBottomView.translatesAutoresizingMaskIntoConstraints = false
    }
}
