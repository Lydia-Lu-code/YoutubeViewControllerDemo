////
////  ShortsView.swift
////  YoutubeViewController
////
////  Created by Lydia Lu on 2024/4/1.
////
//
//import UIKit
//import Foundation
//
//class ShortsFrameView: UIView {
//
//    weak var viewController: UIViewController?
//    
//    override init(frame: CGRect) {
//        super.init(frame: .zero)
//        
//        self.backgroundColor = .gray
//        setupCustomShortsFrameViewLayout()
//        addTapGestureToVideoViews()
//    }
//
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    lazy var imageView : UIImageView = {
//        let imgView = UIImageView()
//        imgView.translatesAutoresizingMaskIntoConstraints = false
//        imgView.backgroundColor = .red
//        return imgView
//    }()
//
//    let shortsTitlelabel : UILabel = {
//        let lbl = UILabel()
//        lbl.translatesAutoresizingMaskIntoConstraints  = false
//        lbl.backgroundColor = .brown
//        return lbl
//    }()
//    
//    let collecrtionCell : UICollectionViewCell = {
//        let collCell = UICollectionViewCell()
//        collCell.translatesAutoresizingMaskIntoConstraints = false
//        collCell.backgroundColor = .white
//        return collCell
//    }()
//    
//    let videoView1 : UIView = {
//        let vidView1 = UIView()
//        vidView1.translatesAutoresizingMaskIntoConstraints = false
//        vidView1.backgroundColor = .red
//        return vidView1
//    }()
//    
//    let videoView2 : UIView = {
//        let vidView2 = UIView()
//        vidView2.translatesAutoresizingMaskIntoConstraints = false
//        vidView2.backgroundColor = .brown
//        return vidView2
//    }()
//    
//    let videoView3 : UIView = {
//        let vidView3 = UIView()
//        vidView3.translatesAutoresizingMaskIntoConstraints = false
//        vidView3.backgroundColor = .red
//        return vidView3
//    }()
//    
//    let videoView4 : UIView = {
//        let vidView4 = UIView()
//        vidView4.translatesAutoresizingMaskIntoConstraints = false
//        vidView4.backgroundColor = .red
//        return vidView4
//    }()
//    
//    lazy var shortsFrameView : UIView = {
//        let shortsFrameView = UIView()
//        shortsFrameView.translatesAutoresizingMaskIntoConstraints = false
//        shortsFrameView.backgroundColor = UIColor.red
//        shortsFrameView.addSubview(imageView)
//        shortsFrameView.addSubview(shortsTitlelabel)
//        shortsFrameView.addSubview(collecrtionCell)
//        shortsFrameView.addSubview(videoView1)
//        shortsFrameView.addSubview(videoView2)
//        shortsFrameView.addSubview(videoView3)
//        shortsFrameView.addSubview(videoView4)
//        return shortsFrameView
//    }()
//    
//    
//    private func setupCustomShortsFrameViewLayout() {
//        self.addSubview(shortsFrameView)
//        
//        shortsFrameView.addSubview(imageView)
//        shortsFrameView.addSubview(shortsTitlelabel)
//        shortsFrameView.addSubview(collecrtionCell)
//        shortsFrameView.addSubview(videoView1)
//        shortsFrameView.addSubview(videoView2)
//        shortsFrameView.addSubview(videoView3)
//        shortsFrameView.addSubview(videoView4)
//        
//        
//        videoView1.layer.cornerRadius = 25
//        videoView2.layer.cornerRadius = 25
//        videoView3.layer.cornerRadius = 25
//        videoView4.layer.cornerRadius = 25
//        
//        NSLayoutConstraint.activate([
//            imageView.leadingAnchor.constraint(equalTo: shortsFrameView.leadingAnchor), // 與 VideoFrameView 的 leadingAnchor 對齊
//            imageView.topAnchor.constraint(equalTo: shortsFrameView.topAnchor), // 與 VideoFrameView 的 topAnchor 對齊
//            imageView.heightAnchor.constraint(equalToConstant: 70),
//            imageView.widthAnchor.constraint(equalToConstant: 65)
//        ])
//        
//        NSLayoutConstraint.activate([
//            shortsTitlelabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 0),
//            shortsTitlelabel.topAnchor.constraint(equalTo: shortsFrameView.topAnchor),
//            shortsTitlelabel.heightAnchor.constraint(equalToConstant: 70),
//            shortsTitlelabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 55) // 设置宽度为屏幕宽度减去 55
//        ])
//        
//        NSLayoutConstraint.activate([
//            collecrtionCell.leadingAnchor.constraint(equalTo: shortsFrameView.leadingAnchor, constant: 0),
//            collecrtionCell.topAnchor.constraint(equalTo: shortsFrameView.topAnchor, constant: 70),
//            collecrtionCell.heightAnchor.constraint(equalToConstant: 595),
//            collecrtionCell.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width) // 设置宽度为屏幕宽度减去 55
//        ])
//        
//        // 添加按钮约束
//        NSLayoutConstraint.activate([
//            videoView1.leadingAnchor.constraint(equalTo: collecrtionCell.leadingAnchor, constant: 10),
//            videoView1.topAnchor.constraint(equalTo: collecrtionCell.topAnchor, constant: 10),
//            videoView1.heightAnchor.constraint(equalToConstant: 285),
//            videoView1.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 30) / 2),
//            
//            videoView2.leadingAnchor.constraint(equalTo: collecrtionCell.leadingAnchor, constant: (UIScreen.main.bounds.width / 2) + 5),
//            videoView2.topAnchor.constraint(equalTo: collecrtionCell.topAnchor, constant: 10),
//            videoView2.heightAnchor.constraint(equalToConstant: 285),
//            videoView2.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 30) / 2),
//            
//            videoView3.leadingAnchor.constraint(equalTo: collecrtionCell.leadingAnchor, constant: 10),
//            videoView3.topAnchor.constraint(equalTo: collecrtionCell.topAnchor, constant: 305),
//            videoView3.heightAnchor.constraint(equalToConstant: 280),
//            videoView3.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 30) / 2),
//            
//            videoView4.leadingAnchor.constraint(equalTo: collecrtionCell.leadingAnchor, constant: (UIScreen.main.bounds.width / 2) + 5),
//            videoView4.topAnchor.constraint(equalTo: collecrtionCell.topAnchor, constant: 305),
//            videoView4.heightAnchor.constraint(equalToConstant: 280),
//            videoView4.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 30) / 2),
//        ])
//
//    }
//    
//    private func addTapGestureToVideoViews() {
//        let videoViews = [videoView1, videoView2, videoView3, videoView4]
//        
//        for videoView in videoViews {
//            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(videoViewTapped(_:)))
//            videoView.addGestureRecognizer(tapGesture)
//            videoView.isUserInteractionEnabled = true
//        }
//    }
//    
//    @objc private func videoViewTapped(_ gesture: UITapGestureRecognizer) {
//        guard let tappedView = gesture.view, let viewController = viewController else { return }
//        
//        // 根據點擊的視圖執行相應的操作
//        if tappedView == videoView1 {
//            let shortsViewController = ShortsVC()
//            shortsViewController.videoContent = "Video 1 content"
//            viewController.present(shortsViewController, animated: true, completion: nil)
//        } else if tappedView == videoView2 {
//            let shortsViewController = ShortsVC()
//            shortsViewController.videoContent = "Video 2 content"
//            viewController.present(shortsViewController, animated: true, completion: nil)
//        } else if tappedView == videoView3 {
//            let shortsViewController = ShortsVC()
//            shortsViewController.videoContent = "Video 3 content"
//            viewController.present(shortsViewController, animated: true, completion: nil)
//        } else if tappedView == videoView4 {
//            let shortsViewController = ShortsVC()
//            shortsViewController.videoContent = "Video 4 content"
//            viewController.present(shortsViewController, animated: true, completion: nil)
//        }
//    }
//    
//
//}
