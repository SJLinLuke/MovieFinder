//
//  ViewController.swift
//  moviesAPP
//
//  Created by LukeLin on 2024/8/31.
//

import UIKit

class homeVC: UIViewController {
    
    enum Section { case main }
    
    let searchController                 = UISearchController()
    let generaTableView                  = UITableView(frame: .zero, style: .grouped)
    lazy var searchResultsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
    var collectionViewDataSource: UICollectionViewDiffableDataSource<Section, Movie>!

    var genres: [GenresResponse.Genre] = [] {
        didSet { generaTableView.reloadData() }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        configureCollectionView()
        getGenres()
    }
    
    private func getGenres() {
        Task {
            do {
                let tempGenres = try await NetworkManager.shared.fetchGenres()
                // the rapid api has limit requests per month, so I just use Top three genres in this simple porject
                genres.append(tempGenres[0])
//                genres.append(tempGenres[1])
//                genres.append(tempGenres[2])
            } catch {
                print(error)
            }
        }
    }
    
    private func getMovies(by name: String) {
        NetworkManager.shared.fetchMoviesByName(by: name, page: 1) { [weak self] response in
            guard let self = self else { return }
            print(response.results ?? [])
            self.updateData(on: response.results ?? [])
        }
    }
    
    private func configureSearchController() {
        searchController.delegate               = self
        searchController.searchBar.delegate     = self
        searchController.searchBar.placeholder  = "Search A Movie Name"
        navigationItem.searchController = searchController
    }

    private func configureViewController() {
        configureSearchController()
        title = "Movies"
    }
    
    private func configureTableView() {
        view.addSubview(generaTableView)
        
        generaTableView.backgroundColor = .white
        generaTableView.separatorStyle  = .none
        generaTableView.delegate        = self
        generaTableView.dataSource      = self
        generaTableView.register(GeneraTableViewCell.self, forCellReuseIdentifier: GeneraTableViewCell.identifier)
        
        generaTableView.pinToEdges(of: view)
    }
    
    private func configureCollectionView() {
        view.addSubview(searchResultsCollectionView)
        searchResultsCollectionView.register(MoviePanelCollectionViewCell.self, forCellWithReuseIdentifier: MoviePanelCollectionViewCell.identifier)
        searchResultsCollectionView.delegate        = self
        searchResultsCollectionView.alpha           = 0
        searchResultsCollectionView.backgroundColor = .white
        searchResultsCollectionView.pinToEdges(of: view)
        
        configureCollectionViewDataSource()
    }
    
    private func configureCollectionViewDataSource() {
        collectionViewDataSource = UICollectionViewDiffableDataSource<Section, Movie>(collectionView: searchResultsCollectionView, cellProvider: { collectionView, indexPath, movie in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviePanelCollectionViewCell.identifier, for: indexPath) as! MoviePanelCollectionViewCell
            cell.setCell(with: movie)
            return cell
        })
    }
    
    private func updateData(on movies: [Movie]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movies)
        DispatchQueue.main.async {
            self.collectionViewDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    private func routeToMovieDetail(with movie: Movie) {
        let vc = MovieDetailVC(with: movie)
        vc.modalPresentationStyle = .popover
        navigationController?.present(vc, animated: true)
    }
}

extension homeVC: GenreMoviePanelDelegate {
    
    func didSelectMovie(_ movie: Movie) {
        routeToMovieDetail(with: movie)
    }
}

extension homeVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int { genres.count }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "\(genres[section].name.uppercased())"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 200 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = generaTableView.dequeueReusableCell(withIdentifier: GeneraTableViewCell.identifier, for: indexPath) as! GeneraTableViewCell
        cell.delegate = self
        cell.fetchMovies(of: genres[indexPath.section].id)
        return cell
    }
}

extension homeVC: UISearchControllerDelegate, UISearchBarDelegate {
    
    func willPresentSearchController(_ searchController: UISearchController) {
        UIView.animate(withDuration: 0.1) {
            self.generaTableView.alpha = 0
        } completion: { [weak self] _ in
            guard let self = self else { return }
            self.searchResultsCollectionView.alpha = 1
        }
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        UIView.animate(withDuration: 0.1) {
            self.generaTableView.alpha = 1
        } completion: { [weak self] _ in
            guard let self = self else { return }
            self.searchResultsCollectionView.alpha = 0
            self.updateData(on: [])
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        getMovies(by: searchText)
    }
}

extension homeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = collectionViewDataSource.itemIdentifier(for: indexPath) else { return }
        routeToMovieDetail(with: movie)
    }
}

#Preview {
    MainTabbarVC()
}
