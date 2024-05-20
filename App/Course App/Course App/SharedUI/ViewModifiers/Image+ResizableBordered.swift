//
//  Image+ResizableBordered.swift
//  Course App
//
//  Created by Patrik Urban on 19.05.2024.
//

import SwiftUI
extension Image {
    func resizableBordered(cornerRadius: CGFloat) -> some View {
        self
            .resizable()
            .scaledToFill()
            .bordered(cornerRadius: cornerRadius)
    }
}
