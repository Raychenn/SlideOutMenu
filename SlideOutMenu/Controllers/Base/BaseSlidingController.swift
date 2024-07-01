//
//  BaseSlidingController.swift
//  SlideOutMenu
//
//  Created by Boray Chen on 2023/7/16.
//

import UIKit

class RightContainerView: UIView {}
class MenuContainerView: UIView {}
class DarkContainerView: UIView {}

class BaseSlidingController: UIViewController {
    
    fileprivate let redView: RightContainerView = {
        let view = RightContainerView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let blueView: MenuContainerView = {
        let view = MenuContainerView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate var redViewLeadingConstraint: NSLayoutConstraint!
    
    fileprivate var redViewTrailingConstraint: NSLayoutConstraint!
    
    fileprivate let menuWidth: CGFloat = 300
    
    fileprivate var isMenuOpened = false
    
    fileprivate let velocityOpenThreshold: CGFloat = 500
    
    fileprivate lazy var darkCoverView = {
        let darkCoverView = DarkContainerView()
        darkCoverView.backgroundColor = UIColor(white: 0, alpha: 0.8)
        darkCoverView.translatesAutoresizingMaskIntoConstraints = false
        darkCoverView.alpha = 0
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapDarkCoverView))
        darkCoverView.addGestureRecognizer(tapGesture)
        return darkCoverView
    }()
    
    fileprivate var rightViewController: UIViewController = UINavigationController(rootViewController: HomeViewController())
        
    let menuController = MenuTableViewController(style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        setupViews()
        setupViewControllers()
        setupDarkCoverView()
        setupPanGesture()
    }
    
    fileprivate func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
    }
    
    fileprivate func setupDarkCoverView() {
        view.addSubview(darkCoverView)
        NSLayoutConstraint.activate([
            darkCoverView.topAnchor.constraint(equalTo: redView.topAnchor),
            darkCoverView.leadingAnchor.constraint(equalTo: redView.leadingAnchor),
            darkCoverView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
            darkCoverView.trailingAnchor.constraint(equalTo: redView.trailingAnchor),
        ])
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        var translationX = gesture.translation(in: view).x
        
        translationX = isMenuOpened ? translationX + menuWidth : translationX
        
        translationX = min(menuWidth, translationX)
        translationX = max(0, translationX)
        redViewLeadingConstraint.constant = translationX
        redViewTrailingConstraint.constant = translationX
        
        if gesture.state == .changed {
            darkCoverView.alpha = translationX / menuWidth
        } else if gesture.state == .ended {
            handleEnded(gesture: gesture)
        }
    }
    
    @objc func didTapDarkCoverView() {
        handleMenuOpen(false)
    }
    
    fileprivate func handleEnded(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        if isMenuOpened {
            if abs(velocity.x) > velocityOpenThreshold {
                handleMenuOpen(false)
                performAnimation()
                return
            }
            
            if translation.x < menuWidth / 2 {
                // handleClose
                handleMenuOpen(false)
            } else {
                // handleOpen
                handleMenuOpen(true)
            }
            performAnimation()
        } else {
            if velocity.x > velocityOpenThreshold {
                handleMenuOpen(true)
                performAnimation()
                return
            }
            if translation.x < menuWidth / 2 {
                // handleClose
                handleMenuOpen(false)
            } else {
                // handleOpen
                handleMenuOpen(true)
            }
            performAnimation()
        }
    }
    
    func performAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.view.layoutIfNeeded()
            self.darkCoverView.alpha = self.isMenuOpened ? 1 : 0
        }
    }
    
    func handleMenuOpen(_ shouldOpen: Bool) {
        let menuLeadingConstant = shouldOpen ? menuWidth : 0
        let menuTrailingConstant = shouldOpen ? menuWidth : 0
        redViewLeadingConstraint.constant  = menuLeadingConstant
        redViewTrailingConstraint.constant = menuTrailingConstant
        isMenuOpened = shouldOpen
        performAnimation()
    }
    
    func didSelect(option: MenuTableViewController.MenuOption) {
        performRightViewCleanUp()
        // figure out why we need to call handleMenuOpen(false) first
        handleMenuOpen(false)
        switch option {
        case .home:
            rightViewController = UINavigationController(rootViewController: HomeViewController())
        case .list:
            rightViewController = UINavigationController(rootViewController: ListViewController())
        case .bookmark:
            let bookmarkVC = BookmarkViewController()
            rightViewController = bookmarkVC
        case .moments:
            let tabBarViewController = UITabBarController()
            let momentsController = UIViewController()
            momentsController.title = "Moments"
            momentsController.tabBarItem = UITabBarItem(title: "Moments", image: nil, tag: 0)
            let momentsNavController = UINavigationController(rootViewController: momentsController)
            tabBarViewController.viewControllers = [momentsNavController]
            tabBarViewController.view.backgroundColor = .orange
            rightViewController = tabBarViewController
        }
        redView.addSubview(rightViewController.view)
        add(rightViewController)
        
        redView.bringSubviewToFront(darkCoverView)
    }

    func performRightViewCleanUp() {
        rightViewController.view.removeFromSuperview()
        rightViewController.removeFromParent()
    }
    
    func setupViews() {
        view.addSubview(redView)
        view.addSubview(blueView)
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: view.topAnchor),
            redView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            blueView.topAnchor.constraint(equalTo: view.topAnchor),
            // anchor the safeArea is important,
            // otherwise the bottom part of the HomeViewController will go further than safeArea and bring out UI parallax effect
            blueView.trailingAnchor.constraint(equalTo: redView.leadingAnchor),
            blueView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            blueView.widthAnchor.constraint(equalToConstant: menuWidth)
        ])
        
        redViewLeadingConstraint = redView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        redViewLeadingConstraint.isActive = true
        redViewTrailingConstraint = redView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        redViewTrailingConstraint.isActive = true
    }
    
    func setupViewControllers() {        
        let rightViewControllerView = rightViewController.view!
        let menuView = menuController.view!
        
        rightViewControllerView.translatesAutoresizingMaskIntoConstraints = false
        menuView.translatesAutoresizingMaskIntoConstraints = false
        
        redView.addSubview(rightViewControllerView)
        blueView.addSubview(menuView)
        
        NSLayoutConstraint.activate([
            rightViewControllerView.topAnchor.constraint(equalTo: redView.topAnchor),
            rightViewControllerView.leadingAnchor.constraint(equalTo: redView.leadingAnchor),
            rightViewControllerView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
            rightViewControllerView.trailingAnchor.constraint(equalTo: redView.trailingAnchor),
            
            menuView.topAnchor.constraint(equalTo: blueView.topAnchor),
            menuView.leadingAnchor.constraint(equalTo: blueView.leadingAnchor),
            menuView.bottomAnchor.constraint(equalTo: blueView.bottomAnchor),
            menuView.trailingAnchor.constraint(equalTo: blueView.trailingAnchor),
        ])
        
        add(rightViewController)
        add(menuController)
    }
}

extension UIViewController {
    
    /// Adds child view controller to the parent.
    ///
    /// - Parameter child: Child view controller.
    func add(_ child: UIViewController) {
        addChild(child)
        child.didMove(toParent: self)
    }

    /// It removes the child view controller from the parent.
    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }

}
