//
//  UIImage+Ext.swift
//  moviesAPP
//
//  Created by LukeLin on 2024/9/7.
//

import UIKit

extension UIImageView {
    
    func loadRemoteImage(from url: String) {
        Task {
            self.image = try await NetworkManager.shared.fetchImage(with: url)
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut) {
                self.alpha = 1
            }
        }
    }
}
