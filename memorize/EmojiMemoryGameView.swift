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
        VStack(spacing: 0) {
            gameTitle
            Spacer()
            gamePlayArea
            Spacer()
            gameActions
        }
    }
    
    var gameTitle: some View {
        VStack(spacing: 4) {
            Text("Memorize")
                .font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundStyle(Color("TextColor"))
            
            Text("Score: 0")
                .font(.caption)
            
            Rectangle()
                .frame(width: .infinity, height: 1)
                .foregroundColor(.gray)
        }
    }
    
    var gamePlayArea: some View {
        Group {
            cardGrid.animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: viewModel.cards)
        }.padding(10)
    }
    
    var cardGrid: some View {
        // TODO: Calculate based off the number of cards rendered
        let cardColumns = [GridItem(.adaptive(minimum: 85), spacing: 0)]
        
        return LazyVGrid(columns: cardColumns, spacing: 0) {
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
        HStack {
            Button("New Game") {
                // TODO: Create a new game
            }.buttonStyle(.borderedProminent)
            
            Button("Shuffle") {
                viewModel.shuffle()
            }.buttonStyle(.bordered)
        }.font(.title2)
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
            
            base
                .fill()
                .opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
