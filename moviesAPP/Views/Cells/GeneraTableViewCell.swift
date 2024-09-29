//
//  GeneraTableViewCell.swift
//  moviesAPP
//
//  Created by LukeLin on 2024/9/2.
//

import UIKit

protocol GenreMoviePanelDelegate: AnyObject {
    func didSelectMovie(_ movie: Movie)
}

class GeneraTableViewCell: UITableViewCell {
    static let identifier: String = "GeneraTableViewCell"
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.generateCollectionViewLayout())
    
    weak var delegate: GenreMoviePanelDelegate?
    
    var moviesResponse: MoviesResponse? {
        didSet {
            movies = moviesResponse?.results ?? []
        }
    }
    
    var movies: [Movie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func configure() {
        selectionStyle = .none
        
        contentView.addSubview(collectionView)
        
        collectionView.backgroundColor  = .clear
        collectionView.indicatorStyle   = .white
        collectionView.dataSource       = self
        collectionView.delegate         = self
        collectionView.register(MoviePanelCollectionViewCell.self, forCellWithReuseIdentifier: MoviePanelCollectionViewCell.identifier)
        
        collectionView.pinToEdges(of: self)
    }
    
    func fetchMovies(of genreID: Int) {
        MovieFetcher.shared.addFetchGeneraTask(genreID) { [weak self] response in
            guard let self = self else { return }
            self.moviesResponse = response
        }
    }
}

extension GeneraTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviePanelCollectionViewCell.identifier, for: indexPath) as! MoviePanelCollectionViewCell
        cell.setCell(with: movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        delegate?.didSelectMovie(movie)
    }
}

#Preview {
    MainTabbarVC()
}
