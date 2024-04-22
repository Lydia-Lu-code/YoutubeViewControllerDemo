//
//  ContainerViewController.swift
//  YoutubeViewController
//
//  Created by Lydia Lu on 2024/4/15.
//
import UIKit

class ContainerVC: UIViewController {

    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed
    
    let menuVC = MenuVC()
    let homeVC = HomeVC()
    var navVC: UINavigationController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        view.backgroundColor = .red
        addChildVCs()
        
        
    }
  
    private func addChildVCs() {
        // Menu
//        menuVC.delegate = self
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        // Home
//        homeVC.delegate = self
        let navVC = UINavigationController(rootViewController: homeVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }
    
    
}

