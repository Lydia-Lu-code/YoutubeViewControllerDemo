//
//  ShortsViewController.swift
//  YoutubeViewController
//
//  Created by Lydia Lu on 2024/4/4.
//

import UIKit

class ShortsTableViewCell: UITableViewCell {
    
    let emojiBtnView = ShortsEmojiBtnView()
    let shortsBtnView = ShortsBtnView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


func setupViews() {
    contentView.addSubview(emojiBtnView)
    contentView.addSubview(shortsBtnView)
    
    emojiBtnView.translatesAutoresizingMaskIntoConstraints = false
    shortsBtnView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
        emojiBtnView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        emojiBtnView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
    ])

    NSLayoutConstraint.activate([
        shortsBtnView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        shortsBtnView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -150),
        shortsBtnView.widthAnchor.constraint(equalToConstant: 200), // 固定寬度為200
    ])

}


    

}
