//
//  MemorizeGame.swift
//  memorize
//
//  Created by Kevin Sweeney on 4/1/24.
//

import Foundation

struct MemorizeGame<CardContent> {
    private(set) var cards: Array<Card>
    
    func choose(card: Card) {
        
    }
    
    struct Card {
        var content: CardContent
        var isFaceUp: Bool
        var isMatched: Bool
    }
}
