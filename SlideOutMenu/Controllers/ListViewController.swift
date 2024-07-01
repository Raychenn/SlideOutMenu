//
//  ListViewController.swift
//  SlideOutMenu
//
//  Created by Boray Chen on 2023/8/6.
//

import UIKit

class ListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "List"
        navigationController?.navigationBar.prefersLargeTitles = true
        let listLabel = UILabel()
        listLabel.text = "List"
        listLabel.textAlignment = .center
        listLabel.frame = view.bounds
        view.addSubview(listLabel)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
