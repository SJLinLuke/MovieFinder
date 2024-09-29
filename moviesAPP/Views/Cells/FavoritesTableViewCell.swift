//
//  FavoritesTableViewCell.swift
//  moviesAPP
//
//  Created by LukeLin on 2024/9/6.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    static let identifier: String = "FavoritesTableViewCell"
    
    let movieImageView      = UIImageView()
    let titleLabel          = SemiBoldLabel(size: 24)
    let releaseDateLabel    = RegularLabel(size: 16)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func configure() {
        selectionStyle = .none
        
        [movieImageView, titleLabel, releaseDateLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        movieImageView.layer.cornerRadius   = 10
        movieImageView.clipsToBounds        = true
        
        titleLabel.numberOfLines = 2
        
        releaseDateLabel.textColor = .gray
        
        NSLayoutConstraint.activate([
            movieImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            movieImageView.widthAnchor.constraint(equalToConstant: 100),
            movieImageView.heightAnchor.constraint(equalToConstant: 100),
            
            titleLabel.topAnchor.constraint(equalTo: movieImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            releaseDateLabel.bottomAnchor.constraint(equalTo: movieImageView.bottomAnchor),
            releaseDateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
        ])
    }
    
    func setCell(with movie: Movie) {
        titleLabel.text         = movie.title
        releaseDateLabel.text   = movie.release_date
        movieImageView.loadRemoteImage(from: movie.poster_path ?? "")
    }
}

#Preview {
    FavoritesVC()
}
