////
////  GenreView.swift
////  moviesAPP
////
////  Created by LukeLin on 2024/8/31.
////
//
//import UIKit
//
//class GenreView: UIView {
//    
//    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.generateCollectionViewLayout())
//    let arr = ["action", "comedy", "drama", "horror", "romance", "sci-fi", "thriller"]
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        translatesAutoresizingMaskIntoConstraints = false
//    }
//    
//    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
//    
//    override func layoutSubviews() {
//        
//        configureCollectionView()
//
//    }
//    
//    private func configureCollectionView() {
//        addSubview(collectionView)
//        collectionView.dataSource   = self
//        collectionView.delegate     = self
//        collectionView.pinToEdges(of: self)
//    }
//}
//
//extension GenreView: UICollectionViewDelegate, UICollectionViewDataSource {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { arr.count }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = UICollectionViewCell()
//        let label = UILabel()
//        label.text = arr[indexPath.item]
//        cell.contentView.addSubview(label)
//        cell.backgroundColor = .red
//        return cell
//    }
//}
//
//#Preview {
//    MainTabbarVC()
//}
