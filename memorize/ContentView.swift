//
//  ContentView.swift
//  memorize
//
//  Created by Kevin Sweeney on 3/22/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView(isFaceUp: true)
            CardView()
            CardView()
            CardView()
        }
        .foregroundColor(.orange)
        .imageScale(.small)
        .padding()
    }
}

struct CardView: View {
    var isFaceUp:Bool = false
    
    var body: some View {
        let base = RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
        ZStack {
            base.fill(.white)
            base.strokeBorder(lineWidth: 4.0)
            
            if isFaceUp {
                Text("👻")
                    .font(.largeTitle)
            }
            else {
                base
            }
        }
    }
}

#Preview {
    ContentView()
}
