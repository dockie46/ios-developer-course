//
//  ReusableIdentifier.swift
//  Course App
//
//  Created by Patrik Urban on 11.05.2024.
//

import Foundation
import UIKit

protocol ReusableIdentifier {
    static var identifier: String { get }
}

extension ReusableIdentifier where Self: UICollectionViewCell {
    static var identifier: String {
        String(describing: Self.self)
    }
}
