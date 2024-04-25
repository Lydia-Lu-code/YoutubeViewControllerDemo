//
//  ShorstFramebottom.swift
//  YoutubeViewController
//
//  Created by Lydia Lu on 2024/4/6.
//

import UIKit

class ShortsBtnView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupEmojiBtnViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var imageView :UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.backgroundColor = UIColor.red
        return imgView
    }()
    
    let accountButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.backgroundColor = .red
        btn.setTitle("account", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()

    let subscriptionButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.backgroundColor = .red
        btn.setTitle("訂閱", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    lazy var accountView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(accountButton)
        stackView.addArrangedSubview(subscriptionButton)
        return stackView
    }()

    let txtLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints  = false
//        lbl.backgroundColor = .orange
        lbl.text = ".txt .txt .txt .txt .txt .txt .txt .txt .txt .txt .txt .txt .txt .txt .txt .txt .txt "
        lbl.numberOfLines = 2
        lbl.textColor = .white // 修改此行
        return lbl
    }()
    

    let musicButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.backgroundColor = .red
        btn.setTitle("music", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.contentHorizontalAlignment = .left // 文字靠左對齊
        return btn
    }()
    
    lazy var stackView: UIStackView = {
         let stackView = UIStackView()
         stackView.translatesAutoresizingMaskIntoConstraints = false
         stackView.axis = .vertical
         stackView.distribution = .fillEqually
         stackView.spacing = 8
         stackView.addArrangedSubview(accountView)
         stackView.addArrangedSubview(txtLabel)
         stackView.addArrangedSubview(musicButton)
         return stackView
     }()
 
    private func setupEmojiBtnViews() {
        
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 140) // 設置總高度為 140

        ])
        
        // 設置 imageView 尺寸為 60x60
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 40),
            imageView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // 將 imageView 設置為圓形
        imageView.layer.cornerRadius = 20 // 半徑為高度的一半，使其成為圓形
        imageView.clipsToBounds = true // 確保圖像顯示為圓形
        
        // 設置 imageView 的 contentMode
        imageView.contentMode = .scaleAspectFit
        
        

    }
    

}
