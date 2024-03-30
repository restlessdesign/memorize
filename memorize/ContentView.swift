//
//  ContentView.swift
//  memorize
//
//  Created by Kevin Sweeney on 3/22/24.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["😈", "🍺", "🥳", "🦉", "🏃‍♂️‍➡️", "🌯", "🌭", "🎾", "🧲"]
    @State var cardCount = 4
    let maxCards = 8
    
    var body: some View {
        VStack {
            gameTitle
            cardStack
            gameActions
        }
        .foregroundColor(.orange)
        .imageScale(.small)
        .padding()
    }
    
    var gameTitle: some View {
        Text("Memorize!")
            .font(.title)
            .foregroundStyle(.white)
    }
    
    var cardStack: some View {
        HStack {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
            }
        }
    }
    var gameActions: some View {
        VStack {
            cardActions
        }
    }
    
    func cardCountAdjuster(by offset:Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .imageScale(.large)
        .disabled(cardCount <= 1 || cardCount > maxCards)
    }
    
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "minus.square.fill")
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: 1, symbol: "plus.square.fill")
    }
    
    var cardActions: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
    }
}


struct CardView: View {
    let content: String
    @State var isFaceUp = false
    
    var body: some View {
        let base = RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
        ZStack {
            base.fill(.white)
            base.strokeBorder(lineWidth: 4.0)
            
            if isFaceUp {
                Text(content)
                    .font(.largeTitle)
            }
            else {
                base
            }
        }
        .onTapGesture {
            print("tapped")
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
