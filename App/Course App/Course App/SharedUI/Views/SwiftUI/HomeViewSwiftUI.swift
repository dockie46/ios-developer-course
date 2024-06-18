//
//  HomeViewSwiftUI.swift
//  Course App
//
//  Created by Patrik Urban on 19.05.2024.
//

import SwiftUI

struct HomeViewSwiftUI: View {
    private enum UIConstant {
        static let cornerRadius: CGFloat = 10
        static let padding: CGFloat = 10
    }
    @StateObject private var dataProvider = MockDataProvider()
    var body: some View {
#if DEBUG
        Self._printChanges()
#endif
        return List {
            ForEach(dataProvider.data, id: \.self) { section in
                Section {
                    VStack {
                        ForEach(section.jokes) { joke in
                            ZStack(alignment: .bottomLeading) {
                                Image(uiImage: joke.image ?? UIImage())
                                    .resizableBordered(cornerRadius: UIConstant.cornerRadius)
                                    .onTapGesture {
                                        // swiftlint:disable:next disable_print
                                        print("Tapped joke \(joke)")
                                    }
                                
                                imagePanel
                            }
                        }
                    }
                    .background(.bg)
                    .padding(.leading, UIConstant.padding)
                    .padding(.trailing, UIConstant.padding)
                } header: {
                    Text(section.title)
                        .foregroundColor(.white)
                        .padding(.leading, UIConstant.padding)
                        .padding(.trailing, UIConstant.padding)
                }
                .background(.bg)
                .listRowInsets(EdgeInsets())
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(.bg)
    }
    
    private var imagePanel: some View {
        HStack {
            Text("Text")
                .foregroundStyle(.white)
            Spacer()
            Button {
                // swiftlint:disable:next disable_print
                print("tapped button")
            } label: {
                Image(systemName: "heart")
            }
            .buttonStyle(SelectableButtonStyle(isSelected: .constant(false), color: .gray))
        }
        .padding(UIConstant.padding)
    }
}

#Preview {
    HomeViewSwiftUI()
}
