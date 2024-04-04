//
//  MemorizeGame.swift
//  memorize
//
//  Created by Kevin Sweeney on 4/1/24.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    func choose(_ card: Card) {
        
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable {
        static func == (lhs: MemoryGame<CardContent>.Card, rhs: MemoryGame<CardContent>.Card) -> Bool {
            return lhs.content == rhs.content &&
            lhs.isFaceUp == rhs.isFaceUp &&
            lhs.isMatched == rhs.isMatched
        }
        
        let content: CardContent
        var isFaceUp = true
        var isMatched = false
    }
}
