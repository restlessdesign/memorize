//
//  MemorizeGame.swift
//  memorize
//
//  Created by Kevin Sweeney on 4/1/24.
//

import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards: [Card]
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let currentCard = Card(content: cardContentFactory(pairIndex))
            
            cards.append(currentCard)
            cards.append(currentCard)
        }
    }
    
    func choose(_ card: Card) {
        
    }
    
    struct Card {
        let content: CardContent
        var isFaceUp = false
        var isMatched = false
    }
}
