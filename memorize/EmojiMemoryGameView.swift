import SwiftUI

/// The rendered view for the Emoji memory game
struct EmojiMemoryGameView: View {
    // TODO: Refactor this to not initialize this way
    /// The game’s ViewModel, which serves as an intermediary between our model and our view
    @ObservedObject var viewModel: EmojiMemoryGame
    
    /// The aspect ratio of our cards
    private let cardAspectRatio:CGFloat = 2/3
    
    /// Returns a `VStack` that divides our view into three sections:
    /// 1. A title area that also displays the player’s current score
    /// 2. The main gameplay area where cards are displayed and interacted with
    /// 3. A footer area for various actions that can be taken during the game
    var body: some View {
        ZStack {
            Text("\(viewModel.theme.deck[0])")
                .font(.system(size: 300))
                .opacity(0.4)
            
            VStack(spacing: 0) {
                gameHeader
                Spacer()
                gamePlayArea
                Spacer()
                gameActions
            }
        }
    }
    
    /// Renders the name of the current game as well as the player’s current score
    @ViewBuilder
    private var gameHeader: some View {
        let title = Text("Memorize!")
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            .foregroundStyle(Color("TextColor"))
        
        let theme = Text("\(viewModel.theme.name)")
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            .foregroundStyle(viewModel.theme.color)
        
        let divider = Divider()
            .padding(EdgeInsets(
                top: 10,
                leading: 0,
                bottom: 10,
                trailing: 0
            ))
        
        let score = Text("Score: \(viewModel.score)")
            .font(.headline)
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            .padding(4)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .foregroundColor(.gray)
                    .opacity(0.2)
            )
        
        ViewThatFits {
            VStack(spacing: 0) {
                title.font(.title3)
                theme.font(.title)
                divider
                score
            }
            
            HStack(alignment: .top, spacing: 0) {
                HStack(spacing: 0) {
                    title.font(.title3)
                    Text(" • ")
                    theme.font(.title3)
                }
                Spacer()
                score
            }
            .padding(EdgeInsets(
                top: 10,
                leading: 0,
                bottom: 0,
                trailing: 0
            ))
        }
    }
    
    /// Renders a grid of cards
    private var gamePlayArea: some View {
        AspectVGrid(viewModel.cards, aspectRatio: cardAspectRatio) { card in
            CardView(card, withThemeColor: viewModel.theme.color)
                .padding(4)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }.animation(.easeIn, value: viewModel.cards)
    }
    
    /// Renders a series of actions that can be performed by the player during the game
    private var gameActions: some View {
        HStack {
            Button("New Game") {
                viewModel.newGame()
                viewModel.shuffle()
            }
            .buttonStyle(.borderedProminent)
            .tint(viewModel.theme.color)
        }
        .font(.title2)
    }
}

/// Renders a card using data supplied from the model
struct CardView: View {
    let card: MemoryGame<String>.Card
    let fillColor: Color
    
    init(_ card: MemoryGame<String>.Card, withThemeColor themeColor: Color) {
        self.card = card
        self.fillColor = themeColor
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
            }
            .opacity(card.isFaceUp ? 1 : 0)
            
            base
                .fill(fillColor)
                .opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
