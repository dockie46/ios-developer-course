//
//  HorizontalCollectionViewCell.swift
//  Course App
//
//  Created by Patrik Urban on 12.05.2024.
//

import SwiftUI
import UIKit

class HorizontalScrollingCell: UICollectionViewCell {
    private enum UIConstant {
        static let radius: CGFloat = 10
    }
    private let collectionView: UICollectionView
    private var jokes: [Joke] = []
    private var didTapCallback: Action<Joke>?
    private var didLikeCallback: Action<Joke>?
    
    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: frame)
        setupCollectionView()
        setupConstraints()
    }
    // swiftlint:disable:next unavailable_function
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(UICollectionViewCell.self)
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
extension HorizontalScrollingCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        jokes.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let joke = jokes[indexPath.row]
        cell.contentConfiguration = UIHostingConfiguration { [weak self] in
            if let url = try?
                ImagesRouter.size300x200.asURLRequest().url {
                AsyncImage(url: url) { image in
                    image.resizableBordered(cornerRadius: UIConstant.radius, color: .blue)
                        .scaledToFit()
                } placeholder: {
                    Color.gray
                }
                ButtonLike(selected: joke.liked, callback: {
                    self?.didLikeCallback?(joke)
                })
            } else {
                Text("ERROR MESSAGE")
            }
        }
        
        return cell
    }
}

// MARK: UICollectionViewLayout
extension HorizontalScrollingCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: bounds.width, height: bounds.height)
    }
}

// MARK: PassData
extension HorizontalScrollingCell {
    func setAndReloadData(_ jokes: [Joke], callback: Action<Joke>? = nil, didLike: Action<Joke>? = nil) {
        self.jokes = jokes
        collectionView.reloadData()
        didTapCallback = callback
        didLikeCallback = didLike
    }
}

// MARK: - UICollectionViewDelegate
extension HorizontalScrollingCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didTapCallback?(jokes[indexPath.row])
    }
}

extension UICollectionViewCell: ReusableIdentifier {}


struct ButtonLike: View {
    @State private var selected: Bool
    var callback: (() -> Void)?
    
    init(selected: Bool, callback: (() -> Void)? = nil) {
        self.selected = selected
        self.callback = callback
    }

    var body: some View {
        Button(action: {
            selected.toggle()
            self.callback?()
        }, label: {
            Image(systemName: "heart")
        })
        .buttonStyle(SelectableButtonStyle(isSelected: $selected, color: Color.gray))
    }
}
