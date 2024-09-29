//
//  MovieDetailVC.swift
//  moviesAPP
//
//  Created by LukeLin on 2024/9/3.
//

import UIKit

class MovieDetailVC: UIViewController {
    
    private var movie: Movie!
    
    let scrollView          = UIScrollView()
    let contentView         = UIView()
    let heroHeaderImageView = HeroHeaderView()
    let playButton          = CustomButton(backgroundColor: .brown, tintColor: .black, title: "Play Now", systemImageNmae: "play")
    let heartButton         = CustomButton(backgroundColor: .brown, tintColor: .red, title: "", systemImageNmae: "heart")
    let dismissButton       = XDismissButton()
    let titleLabel          = BoldTitleLabel(italic: true)
    let releaseDateLabel    = SemiBoldLabel(size: 16)
    let descriptionTextView = UITextView()
    
    init(with movie: Movie) {
        super.init(nibName: nil, bundle: nil)
        self.movie = movie
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureScrollView()
        configureUIElements()
        configureLayout()
    }
    
    private func setMovie(with movie: Movie) {
        heroHeaderImageView.fetchImage(with: movie.backdrop_path ?? "")
        
        titleLabel.text             = movie.original_title
        releaseDateLabel.text       = "release at : \(movie.release_date)"
        releaseDateLabel.textColor  = .lightGray
        descriptionTextView.text    = movie.overview
        
        updateFavoriteButtonStatus(animation: false)
    }
    
    private func configureViewController() {
        view.backgroundColor = .white
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
    }
    
    private func configureUIElements() {
        setMovie(with: movie)
        
        descriptionTextView.font = UIFont(name: Fonts.SFPro_Regular, size: 20)
        descriptionTextView.isEditable = false
        descriptionTextView.isScrollEnabled = false
        
        dismissButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        heartButton.addTarget(self, action: #selector(tappedHeartButton), for: .touchUpInside)
    }
    
    private func configureLayout() {
        
        [heroHeaderImageView, playButton, heartButton, dismissButton, titleLabel, releaseDateLabel, descriptionTextView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            dismissButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            dismissButton.widthAnchor.constraint(equalToConstant: 35),
            dismissButton.heightAnchor.constraint(equalToConstant: 35),
            
            heroHeaderImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            heroHeaderImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            heroHeaderImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            heroHeaderImageView.heightAnchor.constraint(equalToConstant: (450)),
            
            playButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            playButton.bottomAnchor.constraint(equalTo: heroHeaderImageView.bottomAnchor, constant: -45),
            playButton.heightAnchor.constraint(equalToConstant: 45),
            
            heartButton.centerYAnchor.constraint(equalTo: playButton.centerYAnchor),
            heartButton.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 10),
            heartButton.heightAnchor.constraint(equalToConstant: 45),
            
            titleLabel.topAnchor.constraint(equalTo: heroHeaderImageView.bottomAnchor, constant: -30),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            releaseDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            
            descriptionTextView.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 10),
            descriptionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            descriptionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            contentView.bottomAnchor.constraint(equalTo: descriptionTextView.bottomAnchor),
        ])
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    @objc func tappedHeartButton() {
        PersistenceManager.isFavorite(movie, complete: { [weak self] isFavorite in
            guard let self else { return }
            if isFavorite {
                PersistenceManager.updateFavorites(.remove, with: movie)
            } else {
                PersistenceManager.updateFavorites(.add, with: movie)
            }
        })
        
        updateFavoriteButtonStatus(animation: true)
    }
    
    private func updateFavoriteButtonStatus(animation: Bool) {
        PersistenceManager.isFavorite(movie, complete: { [weak self] isFavorite in
            guard let self else { return }
            self.heartButton.setImage(isFavorite ? "heart.fill" : "heart", animation: animation)
        })
    }
}

#Preview {
    MovieDetailVC(with: Movie(adult: true, backdrop_path: "", genre_ids: [], id: 0, original_language: "en", original_title: "Hello", overview: "dsjakdjskajkldjasdlsajdlkasjkldjkalsjdjaskdjlkasjkdjlkasjdkljaslkjdlkasjlkdjalksjdkljasldjlkasjdkajsdjlasjdlksajdkljaslkdjklasjdlkasjkldjaslkjdkjfkjsdaklfjkldsjfajlkfjlkdsjflajifjleiwklfmc.xzjieowfkldsiafejwr;elfkdls;kcvlxs;aijejfkldswf", popularity: 0.0, poster_path: "", release_date: "2024-01-01", title: "", video: false, vote_average: 0.0, vote_count: 0))
}
