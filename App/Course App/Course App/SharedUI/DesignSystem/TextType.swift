//
//  TextType.swift
//  Course App
//
//  Created by Patrik Urban on 03.06.2024.
//

import Foundation
import SwiftUI

enum TextType {
    case h1Title
    case h2Title
    case navbarTitle
    case normal
    
    var font: Font {
        switch self {
        case .navbarTitle:
            .bold(with: .size28)
        case .h1Title:
            .bold(with: .size36)
        case .normal:
            .normal(with: .size28)
        default:
            .regular(with: .size20)
        }
    }
    
    var uiFont: UIFont {
        switch self {
        case .navbarTitle:
            .bold(with: .size28)
        case .h1Title:
            .bold(with: .size36)
        case .normal:
            .normal(with: .size28)
        default:
            .regular(with: .size20)
        }
    }
    
    var color: Color {
        switch self {
        case .navbarTitle:
            .white
        case .h1Title:
            .white
        case .normal:
            .yellow
        default:
            .gray
        }
    }
}
