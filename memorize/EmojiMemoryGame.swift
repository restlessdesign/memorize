import Foundation
import SwiftUI

/// ViewModel of an emoji-specifc version of the memory game
class EmojiMemoryGame: ObservableObject {
    
    /// Holds all of the properties necessary to construct a new emoji matching game theme
    struct MemoryGameTheme {
        /// The name of this theme
        var name: String
        /// A theme-based color to “paint” the back of the cards
        var color: Color
        /// An array of emoji to use as the content for this theme’s cards
        var deck: [String]
        /// How many pairs will be displayed and need to be matched by the player
        var pairsToMatch: Int
        
        /// Selects the appropriate number of card values to use based on the themes `pairsToMatch` value
        /// - Returns: An array of emojis that will be used to construct our cards
        func pickCards() -> [String] {
            Array(deck.shuffled().prefix(upTo: pairsToMatch))
        }
    }
    
    /// Picks a random theme and returns the associated card content for that them
    /// - Returns: The set of emojis that will be used to construct cards
    private static func getRandomTheme() -> MemoryGameTheme? {
        [
            MemoryGameTheme(name: "Ancient Technology", color: .teal, deck: ["💾", "💿", "📼", "☎️", "📟", "📻"], pairsToMatch: 6),
            MemoryGameTheme(name: "Animals", color: .green, deck: ["🐿️", "🦔", "🐇", "🦙", "🦥", "🦦"], pairsToMatch: 4),
            MemoryGameTheme(name: "Food", color: .red, deck: ["🥐", "🧀", "🌭", "🥞", "🌮", "🥧", "🍗", "🥟"], pairsToMatch: 8),
        ].randomElement()
    }
    
    /// Constructs the model to be used for this version of the game, using `emojis` as the source for card content
    /// - Returns: An instance of a String-based memory game model
    private static func createMemoryGame() -> MemoryGame<String> {
        let theme = getRandomTheme()!
        let emojis = theme.pickCards()
        
        return MemoryGame(numberOfPairsOfCards: theme.pairsToMatch) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            }
            
            return "⁉️"
        }
    }
    
    /// Exposes the model for the purposes of being observed, so that our view has something to react to
    @Published private var model = createMemoryGame()
    
    /// Exposes the cards that have been constructed by our model for use in our view
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    
    // MARK: - Intents
    
    /// Picks a specific card
    /// - Parameter card: A user-selected card
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    /// Shuffles the cards
    func shuffle() {
        model.shuffle()
    }
    
    func newGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
