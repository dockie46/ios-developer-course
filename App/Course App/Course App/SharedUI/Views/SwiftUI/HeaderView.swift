//
//  HeaderView.swift
//  Course App
//
//  Created by Patrik Urban on 03.06.2024.
//

import SwiftUI

struct HeaderView: View {
    var title: String
    var body: some View {
        HStack{
            Text(title)
                .textTypeModifier(textType: .h2Title)
            Spacer()
        }.padding([.top,.leading], 10)
    }
}

#Preview {
    HeaderView(title: "test")
}
