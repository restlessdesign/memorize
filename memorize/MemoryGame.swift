import Foundation

/// Constructs the data model for a card-matching game in which the player must find matching pairs of cards
struct MemoryGame<CardContent> where CardContent: Equatable {
    
    /// The set of all (unpaired) cards that a player can choose
    private(set) var cards: [Card]
    
    
    /// Initializes the MemoryGame model
    /// - Parameters:
    ///   - numberOfPairsOfCards: The number of pairs that must be matched by a player
    ///   - cardContentFactory: A factory which determines the content that will be printed on a given card
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            
            cards.append(Card(content: content, id: "\(pairIndex)_a"))
            cards.append(Card(content: content, id: "\(pairIndex)_b"))
        }
    }
    
    /// An optional integer of the card that is currently flipped over (“face up”). When this value is set, all other cards are explicitly
    /// set to not be face up.
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    /// Selects a given card that the player has chosen. If no cards are face up, that card becomes the new card to compare to and
    /// `MemoryGame.indexOfTheOneAndOnlyFaceUpCard` is updated accordingly. If there is already a card that is face up,
    /// then the content of the selected card is compared with that of the card that is face up to determine if there is a match.
    /// If the cards match, they are marked as matched so that a user cannot selected them again.
    /// - Parameter card: The `MemoryGame.Card` instance that the user has selected.
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                }
                else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    /// Shuffle the cards
    mutating func shuffle() {
        cards.shuffle()
    }
    
    /// Holds the relevant state of each card in our game
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        
        /// A simplified description for debugging purposes
        var debugDescription: String {
            return "\(id) (\(content))"
        }
        
        /// The “value” of our cards that a player will attempt to match
        let content: CardContent
        
        /// Whether or not the card is currently displayed
        var isFaceUp = false
        
        /// Whether or not the card has been matched yet
        var isMatched = false
        
        /// A unique identifier for every card that is played. This differs from `content` as each card in a pair
        /// still needs to be unique is some way when rendered.
        let id: String
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
