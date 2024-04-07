//
//  AspectVGrid.swift
//  memorize
//
//  Created by Kevin Sweeney on 4/7/24.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    var items: [Item]
    var aspectRatio: CGFloat = 1.0
    var content: (Item) -> ItemView
    
    init(_ items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geo in
            let gridItemSize = gridItemWidthThatFits(
                count: items.count,
                size: geo.size,
                atAspectRatio: aspectRatio
            )
            
            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)],
                spacing: 0
            ) {
                ForEach(items) { item in
                    content(item)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        
        }
    }
    
    /// Determines the optimal size of our cards to fit within the view
    /// - Parameters:
    ///   - count: The number of cards to fit
    ///   - size: The size offered to us
    ///   - aspectRatio: The aspect ratio of the card
    /// - Returns: The ideal width of our card
    private func gridItemWidthThatFits(
        count: Int,
        size: CGSize,
        atAspectRatio aspectRatio: CGFloat
    ) -> CGFloat {
        let count = CGFloat(count)
        var columnCount = 1.0
        
        repeat {
            let width = size.width / columnCount
            let height = width / aspectRatio
            
            let rowCount = (count / columnCount).rounded(.up)
            if rowCount * height < size.height {
                return width.rounded(.down)
            }
            
            columnCount += 1
        } while columnCount < count
        
        return min(size.width / count, size.height * aspectRatio).rounded(.down)
    }

}
//
//#Preview {
//    AspectVGrid()
//}
