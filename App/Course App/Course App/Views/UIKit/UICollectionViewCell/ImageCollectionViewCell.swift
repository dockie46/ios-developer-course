//
//  ImageCollectionViewCell.swift
//  Course App
//
//  Created by Patrik Urban on 11.05.2024.
//

import Foundation
import UIKit

final class ImageCollectionViewCell: UICollectionViewCell, ReusableIdentifier {

    // MARK: UI items
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup UI
private extension ImageCollectionViewCell {
    func setupUI() {
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        addSubview(imageView)
    }

    func setupConstraints() {
        let anchorConstant: CGFloat = 5
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: anchorConstant),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: anchorConstant),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
    }
}
