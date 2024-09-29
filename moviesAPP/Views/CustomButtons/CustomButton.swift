//
//  CustomButton.swift
//  moviesAPP
//
//  Created by LukeLin on 2024/9/4.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundColor: UIColor, tintColor: UIColor, title: String, systemImageNmae: String, systemImageNmae_selected: String? = nil) {
        self.init(frame: .zero)
        set(backgroundColor: backgroundColor, tintColor: tintColor, title: title, systemImageNmae: systemImageNmae, systemImageNmae_selected: systemImageNmae_selected)
    }
    
    private func configure() {
        configuration               = .tinted()
        configuration?.cornerStyle  = .small
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func set(backgroundColor: UIColor,
                     tintColor: UIColor,
                     title: String,
                     systemImageNmae: String,
                     systemImageNmae_selected: String? = nil) {
        configuration?.baseBackgroundColor  = backgroundColor
        configuration?.baseForegroundColor  = tintColor
        configuration?.title                = title
        
        configuration?.image                = UIImage(systemName: systemImageNmae)
        configuration?.imagePadding         = 10
        configuration?.imagePlacement       = .leading
    }
    
    func setImage(_ systemImageNmae: String, animation: Bool) {
        if animation {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
                self.frame.origin.y -= 10
                self.alpha = 0.5
            } completion: { _ in
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                    self.frame.origin.y += 10
                    self.alpha = 1
                }
            }
        }
        configuration?.image = UIImage(systemName: systemImageNmae)
    }
}


#Preview {
    CustomButton(backgroundColor: .white, tintColor: .red, title: "", systemImageNmae: "play")
}
