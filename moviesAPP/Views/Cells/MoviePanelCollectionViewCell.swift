//
//  MoviePanelCollectionViewCell.swift
//  moviesAPP
//
//  Created by LukeLin on 2024/9/2.
//

import UIKit

class MoviePanelCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "MoviePanelCollectionViewCell"
    
    let movieImageView = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func configure() {
        backgroundColor     = .systemGray6
        layer.cornerRadius  = 10
        layer.shadowColor   = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius  = 4
        layer.shadowOffset  = .init(width: 2, height: 3)
        
        addSubview(movieImageView)
        movieImageView.layer.cornerRadius   = 10
        movieImageView.clipsToBounds        = true
        movieImageView.pinToEdges(of: self)
    }
    
    func setCell(with movie: Movie) {
        movieImageView.loadRemoteImage(from: movie.poster_path ?? "")
    }
}

#Preview {
    MainTabbarVC()
}
