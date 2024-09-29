//
//  MainTabbarVC.swift
//  moviesAPP
//
//  Created by LukeLin on 2024/8/31.
//

import UIKit

class MainTabbarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor                 = .systemGray2
        UINavigationBar.appearance().tintColor          = .systemGray2
        UINavigationBar.appearance().prefersLargeTitles = true
        viewControllers                 = [createSearchNC(), createFavoritesNC()]
    }
    
    private func createSearchNC() -> UINavigationController {
        let searchNC = UINavigationController(rootViewController: homeVC())
        searchNC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass.circle"), selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
        return searchNC
    }
    
    private func createFavoritesNC() -> UINavigationController {
        let favoriteNC = UINavigationController(rootViewController: FavoritesVC())
        favoriteNC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        return favoriteNC
    }
}
