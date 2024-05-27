//
//  HomeViewController.swift
//  Course App
//
//  Created by Patrik Urban on 11.05.2024.
//

import Combine
import os
import SwiftUI
import UIKit

struct HomeView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> HomeViewController {
        HomeViewController()
    }
    
    func updateUIViewController(_ uiViewController: HomeViewController, context: Context) {
    }
}


final class HomeViewController: UIViewController {
    private enum UIConstant {
        static let minimumLineSpacing: CGFloat = 8
        static let minimumInteritemSpacing: CGFloat = 10
        static let edgeVertical: CGFloat = 0
        static let edgeHorizontal: CGFloat = 4
        static let headerReferenceSize: CGFloat = 30
    }
    
    @IBOutlet private var categoriesCollectionView: UICollectionView!
    
    // MARK: DataSource
    private lazy var dataProvider = MockDataProvider()
    typealias DataSource = UICollectionViewDiffableDataSource<SectionData, [Joke]>
    typealias Snapshot = NSDiffableDataSourceSnapshot<SectionData, [Joke]>
    
    private lazy var dataSource = makeDataSource()
    private lazy var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        title = "Categories"
        // Do any additional setup after loading the view.
    }
}

// MARK: - UICollectionViewDataSource
private extension HomeViewController {
    func readData() {
        dataProvider.$data.sink { [weak self] data in
            self?.applySnapshot(data: data, animatingDifferences: true)
        }
        .store(in: &cancellables)
    }

    func applySnapshot(data: [SectionData], animatingDifferences: Bool = true) {
        guard dataSource.snapshot().numberOfSections == 0 else {
            let snapshot = dataSource.snapshot()
            dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
            return
            // snapshot.moveItem((data.first?.jokes.first)!, afterItem: (data.first?.jokes.last)!)
        }

        var snapshot = Snapshot()
        snapshot.appendSections(data)

        data.forEach { section in
            snapshot.appendItems([section.jokes], toSection: section)
        }

        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    func makeDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: categoriesCollectionView) { collectionView, indexPath, _ in
            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]

            let imageHorizontalScrollCell: HorizontalScrollingCell = collectionView.dequeueReusableCell(for: indexPath)
            imageHorizontalScrollCell.setAndReloadData(section.jokes)
            
            return imageHorizontalScrollCell
        }

        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else {
                return nil
            }

            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            let labelCell: LabelCollectionViewCell = collectionView.dequeueSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath)
            labelCell.nameLabel.text = section.title
            return labelCell
        }

        return dataSource
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // swiftlint:disable:next disable_print
        print("I have tapped \(indexPath)")
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // swiftlint:disable:next disable_print
        print("will display \(indexPath)")
    }
}


// MARK: - UICollectionViewLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width - 8, height: collectionView.bounds.height / 3)
    }
}

// MARK: - UI setup
private extension HomeViewController {
    func setup() {
        setupCollectionView()
        readData()
    }

    func setupCollectionView() {
        categoriesCollectionView.backgroundColor = .bg
        categoriesCollectionView.isPagingEnabled = true
        categoriesCollectionView.contentInsetAdjustmentBehavior = .never
        categoriesCollectionView.showsVerticalScrollIndicator = false
        categoriesCollectionView.delegate = self
        categoriesCollectionView.register(HorizontalScrollingCell.self)
        categoriesCollectionView.register(LabelCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical // Change this to vertical
        layout.minimumLineSpacing = UIConstant.minimumLineSpacing 
        layout.minimumInteritemSpacing = UIConstant.minimumInteritemSpacing
        layout.sectionInset = UIEdgeInsets(top: UIConstant.edgeVertical, left: UIConstant.edgeHorizontal, bottom: UIConstant.edgeVertical, right: UIConstant.edgeHorizontal)
        layout.sectionHeadersPinToVisibleBounds = true
        layout.headerReferenceSize = CGSize(width: categoriesCollectionView.contentSize.width, height: UIConstant.headerReferenceSize)
        categoriesCollectionView.setCollectionViewLayout(layout, animated: false)
    }
}
