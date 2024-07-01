//
//  SpacerView.swift
//  SlideOutMenu
//
//  Created by Boray Chen on 2023/7/16.
//

import UIKit

class SpacerView: UIView {

    let space: CGFloat
    
    init(space: CGFloat) {
        self.space = space
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: space, height: space)
    }
    
}
