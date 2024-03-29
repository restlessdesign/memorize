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
    var body: some View {
        VStack {
            HStack {
                ForEach(0..<cardCount, id: \.self) { index in
                    CardView(content: emojis[index])
                }
            }
            HStack {
                Button("Add Card") {
                    cardCount = min(emojis.count, cardCount + 1)
                }
                Spacer()
                Button("Remove Card") {
                    cardCount = max(1, cardCount - 1)
                }
            }
        }
        .foregroundColor(.orange)
        .imageScale(.small)
        .padding()
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
