//
//  TextTypeModifiers.swift
//  Course App
//
//  Created by Patrik Urban on 03.06.2024.
//

import Foundation
import SwiftUI

struct TextTypeModifier: ViewModifier {
    let textType: TextType
    func body(content: Content) -> some View {
        content
            .font(textType.font)
            .foregroundColor(textType.color)
    }
}

extension View {
    func textTypeModifier(textType: TextType) -> some View {
        self.modifier(TextTypeModifier(textType: textType))
    }
}
