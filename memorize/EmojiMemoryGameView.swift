//
//  ContentView.swift
//  memorize
//
//  Created by Kevin Sweeney on 3/22/24.
//

import SwiftUI

// Because we are duplicating emojis in our grid, we need a to key off of them
// within our ForEach without causing collisions. EmojiCard encapsulates the
// String value of the emoji, while also exposing a UUID that is guaranteed
// to be unique.
struct EmojiCard {
    let id = UUID()
    let emoji:String
}

enum Theme: String, CaseIterable {
    case food = "Food"
    case animals = "Animals"
    case ancientTechnology = "Ancient Tech"
    
    func cards() -> [EmojiCard] {
        let emojiSet = switch self {
        case .food:
            ["🥐", "🧀", "🌭", "🥞", "🌮", "🥧"]
        case .animals:
            ["🐿️", "🦔", "🐇", "🦙", "🦥", "🦦"]
        case .ancientTechnology:
            ["💾", "💿", "📼", "☎️", "📟", "📻"]
        }
        
        let output = (emojiSet + emojiSet)
            .map({EmojiCard(emoji: $0)})
            .shuffled()

        return output
    }
    
    func color() -> Color {
        switch self {
        case .food:
            Color.red
        case .animals:
            Color.purple
        case .ancientTechnology:
            Color.mint
        }
    }
    
    func icon() -> String {
        switch self {
        case .food:
            "fork.knife.circle"
        case .animals:
            "pawprint.circle"
        case .ancientTechnology:
            "hourglass.circle"
        }
    }
}

struct EmojiMemoryGameView: View {
    // TODO
    // Refactor this to not initialize this way
    var viewModel: EmojiMemoryGame = EmojiMemoryGame()
    
    @State var currentTheme = Theme.ancientTechnology
    
    var body: some View {
        VStack {
            Spacer()
            gameTitle
            cardStack
            Spacer()
            gameActions
        }
        .imageScale(.large)
        .padding(5)
    }
    
    var gameTitle: some View {
        Text("Memorize!")
            .font(.title)
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
            .foregroundStyle(Color("TextColor"))
            .padding(EdgeInsets(top: 20, leading: 0, bottom: 10, trailing: 0))
    }
    
    let cardColumns = [
        // TODO
        // Calculate min and max vals based on the number of cards displayed
        GridItem(.adaptive(minimum: 90, maximum: 90))
    ]
    
    var cardStack: some View {
        LazyVGrid(columns: cardColumns, spacing: 10) {
            ForEach(currentTheme.cards(), id: \.id) { emojiCard in
                CardView(
                    content: emojiCard.emoji,
                    color: currentTheme.color(),
                    index: index
                )
                .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .frame(maxWidth:600)
    }
    
    var gameActions: some View {
        HStack {
            ForEach(Theme.allCases, id: \.self) { theme in
                Button(action: {
                    currentTheme = theme
                    print("Set theme to \(currentTheme)")
                }, label: {
                    VStack {
                        Image(systemName: theme.icon())
                        Text(theme.rawValue).dynamicTypeSize(.xSmall)
                    }.frame(maxWidth: 90)
                })
                .foregroundColor(currentTheme == theme ? theme.color() : Color.gray)
            }
        }
    }
}

struct CardView: View {
    let card:MemorizeGame<String>.Card
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 10.0)
            
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 4.0)
                Text(card.content)
                    .font(.largeTitle)
            }.opacity(card.isFaceUp ? 1 : 0)
            
            base.fill()
                .opacity(card.isFaceUp ? 0 : 1)
        }
    }
}

#Preview {
    EmojiMemoryGameView()
}
