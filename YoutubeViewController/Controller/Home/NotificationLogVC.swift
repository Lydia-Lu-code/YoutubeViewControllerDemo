////
////  NotificationLogViewController.swift
////  YoutubeViewController
////
////  Created by Lydia Lu on 2024/4/17.
////

import UIKit

protocol NotificationLogVCDelegate: AnyObject {
    func didSelect(menuItem: NotificationLogVC.ButtonTitles)
}

class NotificationLogVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    weak var delegate: NotificationLogVCDelegate?

    enum ButtonTitles: String,CaseIterable{
        case ﻿全部 = "全部"
        case 提及的通知 = "提及的通知"

    }

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let NotificationTableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    let greyColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(NotificationTableView)
        NotificationTableView.delegate = self
        NotificationTableView.dataSource = self

        scrollView.isScrollEnabled = true

    }


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NotificationTableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.size.width, height: view.bounds.size.height)


    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ButtonTitles.allCases.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = ButtonTitles.allCases[indexPath.row].rawValue
        cell.textLabel?.textColor = .white
//        cell.imageView?.image = UIImage(systemName: ButtonTitles.allCases[indexPath.row].imageName)
        cell.imageView?.tintColor = .white
        cell.backgroundColor = greyColor
        cell.contentView.backgroundColor = greyColor
        return cell

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = ButtonTitles.allCases[indexPath.row]
        delegate?.didSelect(menuItem: item)
    }



}


