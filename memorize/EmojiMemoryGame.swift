//
//  File.swift
//  memorize
//
//  Created by Kevin Sweeney on 4/1/24.
//

import Foundation

class EmojiMemoryGame {
    private static let emojis = ["🥐", "🧀", "🌭", "🥞", "🌮", "🥧"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame(numberOfPairsOfCards: 4) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            }
            
            return "⁉️"
        }
    }
    
    private var model = createMemoryGame()
    
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
