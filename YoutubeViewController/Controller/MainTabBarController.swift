//
//  NavigationBarViewController.swift
//  YoutubeViewController
//
//  Created by Lydia Lu on 2024/4/5.
//

import UIKit

class MainTabBarController: UITabBarController {
    

 
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupViewControllers()

    }
    

    private func setupViewControllers() {
        let homeVC = HomeVC()
        let shortsVC = ShortsTableViewController()
        let subscribeVC = SubscribeVC()
        let yourContentVC = YourContentVC()
        let addVC = AddVC()
        
        homeVC.tabBarItem = UITabBarItem(title: "首頁", image: UIImage(named: "home_icon"), tag: 0)
        shortsVC.tabBarItem = UITabBarItem(title: "Shorts", image: UIImage(named: "shorts_icon"), tag: 1)
        addVC.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "plus.circle.fill"), tag: 2)
        subscribeVC.tabBarItem = UITabBarItem(title: "訂閱內容", image: UIImage(named: "subscribe_icon"), tag: 3)
        yourContentVC.tabBarItem = UITabBarItem(title: "你的內容", image: UIImage(named: "your_content_icon"), tag: 4)

        
        viewControllers = [homeVC, shortsVC, addVC, subscribeVC, yourContentVC]
    }
    

}
