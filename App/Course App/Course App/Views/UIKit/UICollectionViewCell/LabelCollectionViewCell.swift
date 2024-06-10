//
//  LabelCollectionViewCell.swift
//  Course App
//
//  Created by Patrik Urban on 11.05.2024.
//

import Foundation
import UIKit

final class LabelCollectionViewCell: UICollectionViewCell {
    private enum UIConstant {
        static let padding: CGFloat = 5
    }
    
    lazy var nameLabel = UILabel()

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

private extension LabelCollectionViewCell {
    func setupUI() {
        addSubviews()
        configureLabel()
        setupConstraints()
    }

    func addSubviews() {
        addSubview(nameLabel)
    }

    func configureLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = .white
        nameLabel.font = UIFont.bold(with: .size20)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstant.padding),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: UIConstant.padding),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1 * UIConstant.padding),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1 * UIConstant.padding),
        ])
    }
}
