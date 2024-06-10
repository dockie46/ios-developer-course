//
//  BackgroundColorModifier.swift
//  Course App
//
//  Created by Work on 22.05.2024.
//

import SwiftUI

struct BackgroundColorModifier: ViewModifier {
    var color: Color

    func body(content: Content) -> some View {
        content
            .background(color)
    }
}

extension View {
    func defaultBackgroundColor() -> some View {
        self.modifier(BackgroundColorModifier(color: .red))
    }
}
