//
//  File.swift
//  memorize
//
//  Created by Kevin Sweeney on 4/1/24.
//

import Foundation

class EmojiMemoryGame {
    private static let emojis = ["🥐", "🧀", "🌭", "🥞", "🌮", "🥧"]
    
    private static func createMemoryGame() -> MemorizeGame<String> {
        MemorizeGame(numberOfPairsOfCards: 4) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            }
            
            return "⁉️"
        }
    }
    
    private var model = createMemoryGame()
    
    var cards: [MemorizeGame<String>.Card] {
        return model.cards
    }
    
    func choose(_ card: MemorizeGame<String>.Card) {
        model.choose(card: card)
    }
}
