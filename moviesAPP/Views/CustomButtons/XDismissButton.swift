//
//  XDismissButton.swift
//  moviesAPP
//
//  Created by LukeLin on 2024/9/4.
//

import UIKit

class XDismissButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
    
    private func configure() {
        setImage(UIImage(systemName: "xmark"), for: .normal)
        backgroundColor     = .white
        tintColor           = .black
        translatesAutoresizingMaskIntoConstraints = false
    }
}

#Preview {
    XDismissButton()
}
