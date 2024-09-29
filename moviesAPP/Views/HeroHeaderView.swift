//
//  heroHeaderView.swift
//  moviesAPP
//
//  Created by LukeLin on 2024/9/3.
//

import UIKit

class HeroHeaderView: UIView {
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addgradient()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        imageView.alpha = 0
        imageView.contentMode = .scaleToFill
        imageView.pinToEdges(of: self)
    }
    
    private func addgradient() {
        let gradientlayer = CAGradientLayer()
        
        gradientlayer.colors = [
            UIColor.clear.cgColor,
            UIColor.white.cgColor
        ]
    
        gradientlayer.startPoint = CGPoint(x: 0.5, y: 0.1)
        gradientlayer.frame = bounds
        layer.addSublayer(gradientlayer)
    }
    
    func fetchImage(with url: String) {
        imageView.loadRemoteImage(from: url)
    }
}


#Preview {
    HeroHeaderView()
}
