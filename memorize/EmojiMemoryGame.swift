//
//  File.swift
//  memorize
//
//  Created by Kevin Sweeney on 4/1/24.
//

import Foundation

class EmojiMemoryGame {
    private var model: MemorizeGame<String>
    
    var cards: [MemorizeGame<String>.Card] {
        return model.cards
    }
    
    func choose(card: MemorizeGame<String>.Card) {
        model.choose(card: card)
    }
}
