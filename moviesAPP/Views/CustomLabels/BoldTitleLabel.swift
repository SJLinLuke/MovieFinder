//
//  BoldTitleLabel.swift
//  moviesAPP
//
//  Created by LukeLin on 2024/9/3.
//

import UIKit

class BoldTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(italic: Bool = false) {
        self.init(frame: .zero)
        font = UIFont(name: italic ? Fonts.SFPro_BoldItalic : Fonts.SFPro_Bold, size: 36)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func configure() {
        numberOfLines                       = 2
        adjustsFontForContentSizeCategory   = true
        adjustsFontSizeToFitWidth           = true
        minimumScaleFactor                  = 0.75
        lineBreakMode                       = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
}
