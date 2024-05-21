//
//  HorizontalCollectionSwiftUICell.swift
//  Course App
//
//  Created by Work on 22.05.2024.
//

import Foundation
import UIKit
import SwiftUI

class HorizontalCollectionSwiftUICell: UICollectionViewCell {
    
    private var hostController: UIHostingController<HorizontalScrollView>?
    
    override init(frame: CGRect) {
            super.init(frame: frame)
    }
    
    func configure(with data: [Joke]) {
        
        let swiftUIView = HorizontalScrollView(data: data)
        hostController = UIHostingController(rootView: swiftUIView)
        
        if let view = hostController?.view {
            view.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(view)
            NSLayoutConstraint.activate([
                view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                view.topAnchor.constraint(equalTo: contentView.topAnchor),
                view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
