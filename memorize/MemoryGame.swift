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
            
            cards.append(Card(content: content, id: "\(pairIndex)_a"))
            cards.append(Card(content: content, id: "\(pairIndex)_b"))
        }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}) {
            // card is a value type here, so we can’t toggle() its .isFaceUp property!
            // We must instead go to our cards property…
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    private func index(of card:Card) -> Int? {
        for index in cards.indices {
            if cards[index].id == card.id {
                return index
            }
        }
        
        // FIXME: Should probably throw here…
        return nil
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var debugDescription: String {
            return "\(id) (\(content))"
        }
        
        let content: CardContent
        var isFaceUp = false
        var isMatched = false
        
        let id: String
    }
}
