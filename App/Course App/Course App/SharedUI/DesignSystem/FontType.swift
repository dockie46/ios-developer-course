//
//  FontType.swift
//  Course App
//
//  Created by Patrik Urban on 03.06.2024.
//

import Foundation
import UIModule
import SwiftUI

enum FontType: String {
    case regular = "Poppins-Regular"
    case bold = "Poppins-Bold"
    case mediumItalic = "Poppins-MediumItalic"
    case normal = "Academy Engraved LET"
}

extension Font {
    static func regular(with size: FontSize) -> Font {
        Font.custom(FontType.regular.rawValue, size: size.rawValue)
    }
    static func bold(with size: FontSize) -> Font {
        Font.custom(FontType.bold.rawValue, size: size.rawValue)
    }
    static func normal(with size: FontSize) -> Font {
        Font.custom(FontType.normal.rawValue, size: size.rawValue)
    }
}

extension UIFont {
    static func regular(with size: FontSize) -> UIFont {
        UIFont(name: FontType.regular.rawValue, size: size.rawValue)!
    }
    static func bold(with size: FontSize) -> UIFont {
        UIFont(name: FontType.bold.rawValue, size: size.rawValue)!
    }
    static func normal(with size: FontSize) -> UIFont {
        UIFont(name: FontType.normal.rawValue, size: size.rawValue)!
    }
}
