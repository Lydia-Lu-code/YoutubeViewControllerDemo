//
//  ShortsTableViewController.swift
//  YoutubeViewController
//
//  Created by Lydia Lu on 2024/4/24.
//

import UIKit

class ShortsTableViewController: UITableViewController {

    var videoContent: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        tableView.register(ShortsTableViewCell.self, forCellReuseIdentifier: "ShortsTableViewCell")
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        tableView.decelerationRate = .fast // 設置快速滑動減速
        tableView.rowHeight = UIScreen.main.bounds.height
        tableView.delegate = self // 設置委託
        
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .systemBackground
//        tableView.register(ShortsTableViewCell.self, forCellReuseIdentifier: "ShortsTableViewCell")
//        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
//    }

// MARK: - Table view data source

override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // Assuming you have only one section
    }
    
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 8 // 8個CELL
}

override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ShortsTableViewCell", for: indexPath) as! ShortsTableViewCell

    // 在這裡將視頻內容設置給 cell
    cell.videoContent = videoContent
    
    cell.setupViews()

    return cell
}

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 取得整個安全區域的高度
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.size.height
        return safeAreaHeight
    }
    
    // Overriding scroll view delegate method
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let cellHeight = tableView.rowHeight
        let targetY = targetContentOffset.pointee.y
        let index = round(targetY / cellHeight)
        targetContentOffset.pointee = CGPoint(x: 0, y: index * cellHeight)
    }

    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            snapToNextCell()
        }
    }

    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        snapToNextCell()
    }

    private func snapToNextCell() {
        let offsetY = tableView.contentOffset.y
        let cellHeight = UIScreen.main.bounds.height
        let currentIndex = Int(round(offsetY / cellHeight))
        let nextIndex = (currentIndex + 1) % tableView.numberOfRows(inSection: 0)
        let targetOffsetY = CGFloat(nextIndex) * cellHeight

        let indexPath = IndexPath(row: nextIndex, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
}
