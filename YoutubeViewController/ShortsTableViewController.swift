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
     
        
    }

// MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // Assuming you have only one section
    }
    
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 8 // 8個CELL
}

override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ShortsTableViewCell", for: indexPath) as! ShortsTableViewCell

    // Configure the cell...
    cell.setupViews()

    return cell
}

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 取得整個安全區域的高度
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.size.height
        return safeAreaHeight
    }


}
