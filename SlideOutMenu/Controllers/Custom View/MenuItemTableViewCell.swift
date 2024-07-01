//
//  MenuItemTableViewCell.swift
//  SlideOutMenu
//
//  Created by Boray Chen on 2023/7/17.
//

import UIKit

class IconImageView: UIImageView {
    override var intrinsicContentSize: CGSize {
        .init(width: 44, height: 44)
    }
}

class MenuItemTableViewCell: UITableViewCell {

    static let identifier = "MenuItemTableViewCell"
    
    let iconImageView: IconImageView = {
       let imageView = IconImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stackView = UIStackView(arrangedSubviews: [iconImageView, titleLabel, UIView()])
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
                stackView.isLayoutMarginsRelativeArrangement = true
                stackView.layoutMargins = .init(top: 8, left: 12, bottom: 8, right: 12)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
