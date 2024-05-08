
import UIKit
import Foundation

class VideoFrameView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
//        self.backgroundColor = .yellow
        setupCustomVideoFrameViewLayout()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    
    lazy var videoView : UIView = {
        let vidView = UIView()
        vidView.translatesAutoresizingMaskIntoConstraints = false
        vidView.backgroundColor = .lightGray
        return vidView
    }()
    
    let imageView :UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.backgroundColor = .darkGray
        return imgView
    }()
    
    let labelMidTitle : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints  = false
//        lbl.backgroundColor = .orange
        lbl.text = "Title﻿ Title﻿ Title﻿ Title﻿ Title﻿ Title﻿ Title﻿ Title﻿ Title﻿ Title﻿ Title﻿ " // 這裡設定了一個範例文字
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.numberOfLines = 2 // 兩行文字
        return lbl
    }()
    
    let labelMidOther : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints  = false
        lbl.font = UIFont.systemFont(ofSize: 10)
        lbl.text = "Other" // 這裡設定了一個範例文字
        lbl.numberOfLines = 2 // 兩行文字
        return lbl
    }()
    
    let buttonRight : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints  = false
        btn.backgroundColor = .clear
        btn.setImage(UIImage(systemName: "ellipsis"), for: .normal) // 使用三個點符號作為示意圖
        btn.tintColor = .lightGray // 設定符號顏色

        return btn
    }()
    
    lazy var videoFrameView : UIView = {
        let vidFrameView = UIView()
        vidFrameView.translatesAutoresizingMaskIntoConstraints = false
        vidFrameView.addSubview(videoView)
        vidFrameView.addSubview(imageView)
        vidFrameView.addSubview(labelMidTitle)
        vidFrameView.addSubview(labelMidOther)
        vidFrameView.addSubview(buttonRight)
        return vidFrameView
    }()
    
  
    private func setupCustomVideoFrameViewLayout() {
        
        // 添加 imageView 到 VideoFrameView 中
        self.addSubview(videoView)
        self.addSubview(imageView)
        self.addSubview(labelMidTitle)
        self.addSubview(labelMidOther)
        self.addSubview(buttonRight)
        
        // 設置 imageView 的圓形外觀
        imageView.layer.cornerRadius = 30 // 圓形的半徑為寬度的一半
        imageView.clipsToBounds = true // 剪切超出圓形範圍的部分
        buttonRight.layer.cornerRadius = 30 // 圓形的半徑為寬度的一半
        buttonRight.clipsToBounds = true // 剪切超出圓形範圍的部分
        
        
        // 設置 videoView 的約束
        NSLayoutConstraint.activate([
            videoView.leadingAnchor.constraint(equalTo: self.leadingAnchor), // 與 VideoFrameView 的 leadingAnchor 對齊
            videoView.topAnchor.constraint(equalTo: self.topAnchor), // 與 VideoFrameView 的 topAnchor 對齊
            videoView.heightAnchor.constraint(equalToConstant: 200), // imageView 的高度設置為 200
            videoView.widthAnchor.constraint(equalTo: self.widthAnchor) // imageView 的寬度與 VideoFrameView 的寬度相等
        ])
        
        // 設置 imageView 的約束
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor), // 與 VideoFrameView 的 leadingAnchor 對齊
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 60), // imageView 的高度設置為 60
            imageView.widthAnchor.constraint(equalToConstant: 60) // imageView 的寬度設置為 60
        ])
        
        NSLayoutConstraint.activate([
            buttonRight.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            buttonRight.topAnchor.constraint(equalTo: self.topAnchor, constant: 200),
            buttonRight.heightAnchor.constraint(equalToConstant: 60), // imageView 的高度設置為 60
            buttonRight.widthAnchor.constraint(equalToConstant: 60) // imageView 的寬度設置為 60
        ])
        
        NSLayoutConstraint.activate([
            // labelMidTitle 的约束
            labelMidTitle.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5), // labelMidTitle 左边与 imageView 右边相距 5 点
            labelMidTitle.topAnchor.constraint(equalTo: imageView.topAnchor), // labelMidTitle 顶部与 imageView 顶部对齐
            labelMidTitle.heightAnchor.constraint(equalToConstant: 55), // labelMidTitle 高度设为 55 点
            labelMidTitle.widthAnchor.constraint(equalTo: videoView.widthAnchor, constant: -130),
            
            // labelMidOther 的约束
            labelMidOther.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5), // labelMidOther 左边与 imageView 右边相距 5 点
            labelMidOther.topAnchor.constraint(equalTo: self.topAnchor, constant: 240), // labelMidOther 顶部与 labelMidTitle 底部相距 0 点
            labelMidOther.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0), // 底部固定在 VideoFrameView 的底部並設置間距為 20
            labelMidOther.widthAnchor.constraint(equalTo: videoView.widthAnchor, constant: -130)

        ])
        

    }

}



    

    
    
      

