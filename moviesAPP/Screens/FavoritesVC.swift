//
//  FavoritesVC.swift
//  moviesAPP
//
//  Created by LukeLin on 2024/8/31.
//

import UIKit

class FavoritesVC: UIViewController {
    
    let tableView = UITableView()
    
    var favoriteMovies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavoriteMovies()
    }

    private func configureViewController() {
        title = "Favorites"
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.dataSource        = self
        tableView.delegate          = self
        tableView.rowHeight         = 140
        tableView.separatorStyle    = .none
        tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: FavoritesTableViewCell.identifier)
        
        tableView.pinToEdges(of: view)
    }
    
    private func getFavoriteMovies() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let movies):
                favoriteMovies = movies
                tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension FavoritesVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { favoriteMovies.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.identifier, for: indexPath) as! FavoritesTableViewCell
        cell.setCell(with: favoriteMovies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        PersistenceManager.updateFavorites(.remove, with: favoriteMovies[indexPath.row])

        favoriteMovies.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}

#Preview {
    FavoritesVC()
}
