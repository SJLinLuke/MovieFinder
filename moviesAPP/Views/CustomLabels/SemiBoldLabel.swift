//
//  RegularBodyLabel.swift
//  moviesAPP
//
//  Created by LukeLin on 2024/9/3.
//

import UIKit

class SemiBoldLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(size: CGFloat) {
        self.init(frame: .zero)
        font = UIFont(name: Fonts.SFPro_SemiBold, size: size)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func configure() {
        adjustsFontForContentSizeCategory   = true
        adjustsFontSizeToFitWidth           = true
        minimumScaleFactor                  = 0.75
        lineBreakMode                       = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
}
