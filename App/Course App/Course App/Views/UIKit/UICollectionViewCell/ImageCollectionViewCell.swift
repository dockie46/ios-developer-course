//
//  ImageCollectionViewCell.swift
//  Course App
//
//  Created by Patrik Urban on 11.05.2024.
//

import Foundation
import UIKit

final class ImageCollectionViewCell: UICollectionViewCell {
    private enum UIConstant {
        static let padding: CGFloat = 5
        static let imageCornerRadius: CGFloat = 10
    }
    
    // MARK: UI items
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = UIConstant.imageCornerRadius
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }
    
    // swiftlint:disable:next unavailable_function
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
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstant.padding),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: UIConstant.padding),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1 * UIConstant.padding),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1 * UIConstant.padding)
        ])
    }
}
