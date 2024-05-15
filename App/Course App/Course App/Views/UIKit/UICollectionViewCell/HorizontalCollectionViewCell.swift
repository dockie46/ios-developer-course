//
//  HorizontalCollectionViewCell.swift
//  Course App
//
//  Created by Patrik Urban on 12.05.2024.
//

import UIKit

class HorizontalScrollingCell: UICollectionViewCell, ReusableIdentifier {
    private let collectionView: UICollectionView!
    private var jokes: [Joke] = []
    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: frame)
        setupCollectionView()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(ImageCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension HorizontalScrollingCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jokes.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ImageCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.imageView.image = jokes[indexPath.item].image
        return cell
    }
}

// MARK: UICollectionViewLayout
extension HorizontalScrollingCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: bounds.width, height: bounds.height)
    }
}

// MARK: PassData
extension HorizontalScrollingCell {
    func setAndReloadData(_ jokes: [Joke]) {
        self.jokes = jokes
        collectionView.reloadData()
    }
}
