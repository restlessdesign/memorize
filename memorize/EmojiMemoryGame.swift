import Foundation
import SwiftUI

/// ViewModel of an emoji-specifc version of the memory game
class EmojiMemoryGame: ObservableObject {
    
    enum Theme: String, CaseIterable {
        case food = "Food"
        case animals = "Animals"
        case ancientTechnology = "Ancient Tech"
        
        func cards() -> [String] {
            switch self {
            case .food: ["🥐", "🧀", "🌭", "🥞", "🌮", "🥧"]
            case .animals: ["🐿️", "🦔", "🐇", "🦙", "🦥", "🦦"]
            case .ancientTechnology: ["💾", "💿", "📼", "☎️", "📟", "📻"]
            }
        }
        
        func color() -> Color {
            switch self {
            case .food: Color.red
            case .animals: Color.purple
            case .ancientTechnology: Color.mint
            }
        }
        
        func icon() -> String {
            switch self {
            case .food: "fork.knife.circle"
            case .animals: "pawprint.circle"
            case .ancientTechnology: "hourglass.circle"
            }
        }
    }
    
    /// The set of emojis that will be used to construct cards
    private static let emojis = ["🥐", "🧀", "🌭", "🥞", "🌮", "🥧"]
    
    /// Constructs the model to be used for this version of the game, using `emojis` as the source for card content
    /// - Returns: An instance of a String-based memory game model
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame(numberOfPairsOfCards: 4) { pairIndex in
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
}
