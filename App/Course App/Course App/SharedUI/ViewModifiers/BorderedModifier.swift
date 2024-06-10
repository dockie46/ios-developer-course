//
//  BorderedModifier.swift
//  Course App
//
//  Created by Patrik Urban on 19.05.2024.
//

import Foundation
import SwiftUI

struct BorderedModifier: ViewModifier {
    private enum UIConstant {
        static let lineWidth: CGFloat = 2
        static let radius: CGFloat = 2
    }
    
    var cornerRadius: CGFloat
    var color: Color
    func body(content: Content) -> some View {
        content
            .background(.gray)
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(color, lineWidth: UIConstant.lineWidth)
            )
            .shadow(radius: UIConstant.radius)
    }
}

extension View {
    func bordered(cornerRadius: CGFloat, color: Color = .white) -> some View {
        self.modifier(BorderedModifier(cornerRadius: cornerRadius, color: color))
    }
}
