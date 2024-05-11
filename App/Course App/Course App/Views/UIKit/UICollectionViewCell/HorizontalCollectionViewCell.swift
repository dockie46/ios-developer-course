//
//  HorizontalCollectionViewCell.swift
//  Course App
//
//  Created by Patrik Urban on 12.05.2024.
//

import UIKit

class HorizontalCollectionViewCell: UICollectionViewCell, ReusableIdentifier {
    
    typealias DataSource = UICollectionViewDiffableDataSource<SectionData, Joke>
    typealias Snapshot = NSDiffableDataSourceSnapshot<SectionData, Joke>
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
