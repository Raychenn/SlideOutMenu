//
//  CustomHeaderView.swift
//  SlideOutMenu
//
//  Created by Boray Chen on 2023/7/16.
//

import UIKit

class CustomHeaderView: UIView {
    
    let nameLabel = UILabel()
    
    let statsLabel = UILabel()
    
    let userNameLabel = UILabel()
    
    let profileImageView = ProfileImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupUI()
        setupStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupStackView() {
        let arrangeSubViews = [
                               // squeeze the image view to the left size of the vertical stack view
                               UIStackView(arrangedSubviews: [profileImageView, UIView()]),
                               nameLabel,
                               userNameLabel,
                               SpacerView(space: 16),
                               statsLabel]
        let stack = UIStackView(arrangedSubviews: arrangeSubViews)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .green
        stack.axis = .vertical
        stack.spacing = 4
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 24, left: 24, bottom: 24, right: 24 )
    }
    
    fileprivate func setupUI() {
        nameLabel.text = "Ray Chen"
        nameLabel.font = .systemFont(ofSize: 20, weight: .black)
        
        userNameLabel.textColor = .lightGray
        userNameLabel.text = "@RayChen.com"
       
        statsLabel.text = "200 Following 5000 Followers"
        
        profileImageView.image = UIImage(named: "cat")
        profileImageView.clipsToBounds = true
        profileImageView.backgroundColor = .red
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.layer.cornerRadius = 48 / 2
        profileImageView.layer.masksToBounds = true
    }
}
