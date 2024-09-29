//
//  UIHelper.swift
//  moviesAPP
//
//  Created by LukeLin on 2024/9/2.
//

import UIKit

struct UIHelper {
    
    static func generateCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout                      = UICollectionViewFlowLayout()
        layout.scrollDirection          = .horizontal
        layout.minimumLineSpacing       = 15
        layout.itemSize                 = CGSize(width: 140, height: 180)
        layout.sectionInset              = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return layout
    }
    
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width                       = view.bounds.width
        let padding: CGFloat            = 12
        let minimumItemSpacing: CGFloat = 10
        let avaliableWidth              = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth                   = avaliableWidth / 3
        
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize             = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }

}

#Preview {
    MainTabbarVC()
}
