//
//  ViewController.swift
//  SlideOutMenu
//
//  Created by Boray Chen on 2023/6/24.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        title = "Home"
        setupUI()
    }
    
    private func setupUI() {
        navigationController?.title = "Home"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Open", style: .done, target: self, action: #selector(handleOpenMenu))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Hide", style: .done, target: self, action: #selector(handleHideMenu))
    }

    @objc func handleOpenMenu() {
        let keyWindow = UIApplication
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .last { $0.isKeyWindow }
        let rootNav = keyWindow?.rootViewController as? UINavigationController
        let baseSlidingController = rootNav?.topViewController as? BaseSlidingController
        baseSlidingController?.handleMenuOpen(true)
    }
    
    @objc func handleHideMenu() {

    }
}

extension HomeViewController: UIGestureRecognizerDelegate {
    
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }
}
