//
//  MenuTableViewController.swift
//  SlideOutMenu
//
//  Created by Boray Chen on 2023/6/24.
//

import UIKit

struct MenuItem {
    let icon: UIImage?
    let title: String
}

class MenuTableViewController: UITableViewController {
    
    enum MenuOption: Int {
        case home = 0
        case list
        case bookmark
        case moments
    }
    
    let memuItems = [
        MenuItem(icon: UIImage(systemName: "person"), title: "Home"),
        MenuItem(icon: UIImage(systemName: "newspaper"), title: "Lists"),
        MenuItem(icon: UIImage(systemName: "bookmark"), title: "BookMarks"),
        MenuItem(icon: UIImage(systemName: "sun.min"), title: "Moments")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        tableView.sectionHeaderTopPadding = 0
//        tableView.contentInsetAdjustmentBehavior = .never
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = CustomHeaderView()
        
        return header
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        memuItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MenuItemTableViewCell(style: .default, reuseIdentifier: MenuItemTableViewCell.identifier)
        cell.titleLabel.text = memuItems[indexPath.row].title
        cell.iconImageView.image = memuItems[indexPath.row].icon
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let keyWindow = UIApplication
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .last { $0.isKeyWindow }
        let rootNav = keyWindow?.rootViewController as? UINavigationController
        let baseSlidingController = rootNav?.topViewController as? BaseSlidingController
        let selectedOption = MenuOption(rawValue: indexPath.row) ?? .home
        baseSlidingController?.didSelect(option: selectedOption)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
