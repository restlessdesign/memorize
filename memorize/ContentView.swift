//
//  ContentView.swift
//  memorize
//
//  Created by Kevin Sweeney on 3/22/24.
//

import SwiftUI

enum Theme: String, CaseIterable {
    case food, animals, ancientTechnology
    
    func emojis() -> [String] {
        switch self {
        case .food:
            ["🥐", "🧀", "🌭", "🥞", "🌮", "🥧"]
        case .animals:
            ["🐿️", "🦔", "🐇", "🦙", "🦥", "🦦"]
        case .ancientTechnology:
            ["💾", "💿", "📼", "☎️", "📟", "📻"]
        }
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

struct ContentView: View {
    
    @State var currentTheme = Theme.animals
    
    var body: some View {
        VStack {
            gameTitle
            Spacer(minLength: 40)
            ScrollView {
                cardStack
            }
            Spacer()
            gameActions
        }
        .imageScale(.large)
        .padding(40)
    }
    
    var gameTitle: some View {
        Text("Memorize!")
            .font(.title)
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
            .foregroundStyle(Color.black)
    }
    
    let cardColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var cardStack: some View {
        LazyVGrid(columns: cardColumns, spacing: 10) {
            ForEach(currentTheme.emojis().indices, id: \.self) { index in
                CardView(
                    content: currentTheme.emojis()[index],
                    color: currentTheme.color()
                )
                .aspectRatio(2/3, contentMode: .fit)
            }
        }
    }
    
    var gameActions: some View {
        HStack {
            ForEach(Theme.allCases, id: \.self) { theme in
                Button(action: {
                    currentTheme = theme
                    print("Set theme to \(currentTheme)")
                }, label: {
                    Image(systemName: theme.icon())
                })
                .foregroundColor(currentTheme == theme ? theme.color() : Color.gray)
            }
        }.font(.largeTitle)
    }
}

struct CardView: View {
    let content: String
    let color: Color
    
    @State var isFaceUp = false
    
    var body: some View {
        let roundedRect = RoundedRectangle(cornerRadius: 25.0)
        ZStack {
            roundedRect
                .fill(isFaceUp ? .white : color)
           
            Text(content)
                .font(.largeTitle)
                .opacity(isFaceUp ? 1 : 0)
            
            roundedRect
                .strokeBorder(lineWidth: 4.0)
                .foregroundColor(color)
        }
        .onTapGesture {
            isFaceUp.toggle()
            print((isFaceUp ? "Showing" : "Hiding") + " \(content)")
        }
    }
}

#Preview {
    ContentView()
}
