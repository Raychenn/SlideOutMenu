//
//  BookmarkViewController.swift
//  SlideOutMenu
//
//  Created by Boray Chen on 2023/8/6.
//

import UIKit

class BookmarkViewController: UIViewController, UITableViewDataSource {

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
        tableView.frame = view.bounds
        view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // have to dequeue cell instead in real proj
        let cell = UITableViewCell(style: .default, reuseIdentifier: "bookmark")
        cell.textLabel?.text = "Bookmark \(indexPath.row)"

        return cell
    }

}
