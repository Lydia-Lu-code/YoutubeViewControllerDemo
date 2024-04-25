//
//  ShortsViewController.swift
//  YoutubeViewController
//
//  Created by Lydia Lu on 2024/4/4.
//

import UIKit

class ShortsTableViewCell: UITableViewCell {
    
    let emojiButtonView = EmojiButtonView()
    let shortsBottomView = ShortsBottomView()
    var videoContent: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews() // 設定視圖

    }
    
    
    private func setupViews() {
        view.addSubview(emojiButtonView)
        view.addSubview(shortsBottomView)
        
        NSLayoutConstraint.activate([
            emojiButtonView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emojiButtonView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90)
        ])

        NSLayoutConstraint.activate([
            shortsBottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            shortsBottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -220),
            shortsBottomView.widthAnchor.constraint(equalToConstant: 200), // 固定寬度為200
        ])

        
        setLayout()  // 設定佈局
    }
    
    private func setLayout() {
        // 在這裡可以設定其他視圖的佈局
        emojiButtonView.translatesAutoresizingMaskIntoConstraints = false
        shortsBottomView.translatesAutoresizingMaskIntoConstraints = false
    }
}
