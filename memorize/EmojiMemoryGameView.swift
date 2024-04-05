//
//  ContentView.swift
//  memorize
//
//  Created by Kevin Sweeney on 3/22/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    // TODO
    // Refactor this to not initialize this way
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Spacer()
            gameTitle
            cardStack.animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: viewModel.cards)
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
        GridItem(.adaptive(minimum: 85), spacing: 0),
    ]
    
    var cardStack: some View {
        LazyVGrid(columns: cardColumns, spacing: 0) {
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
    }
    
    var gameActions: some View {
        VStack {
            Button("Shuffle") {
                viewModel.shuffle()
            }
        }
    }
}

struct CardView: View {
    let card:MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 10.0)
            
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 4.0)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }.opacity(card.isFaceUp ? 1 : 0)
            
            base.fill()
                .opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
