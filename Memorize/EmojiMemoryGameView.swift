//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Marcos André Novaes de Lara on 12/04/22.
//
//  View

import SwiftUI

struct EmojiMemoryGameView: View {
  @ObservedObject var game: EmojiMemoryGame //@ObservedObject para a view ser redesenhada quando algo mudar no ViewModel
  
  var body: some View {
    AspectVGrid(items: game.cards, aspectRatio: 2/3){ card in
      if card.isMatched && !card.isFaceUp{
        Rectangle().opacity(0)
      } else {
        CardView(card: card)
          .padding(4)
          .onTapGesture {
            game.choose(card)
          }
      }
    }
    .foregroundColor(.red)
    .padding(.horizontal)
  }
}

struct CardView: View {
  let card: EmojiMemoryGame.Card
  
  var body: some View {
    GeometryReader{
      geometry in
      ZStack{
        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90)).padding(DrawingConstants.circlePadding).opacity(DrawingConstants.circleOpacity)
        Text(card.content)
          .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
          .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
          .font(Font.system(size: DrawingConstants.fontSize))
          .scaleEffect(scale(thatFits: geometry.size))
      }
      .cardify(isFaceUp: card.isFaceUp)
    }
  }
  
  private func scale(thatFits size: CGSize) -> CGFloat {
    min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
  }
  
  private struct DrawingConstants {
    static let fontScale: CGFloat = 0.7
    static let circlePadding: CGFloat = 5
    static let circleOpacity: CGFloat = 0.5
    static let fontSize: CGFloat = 32
  }
}






struct ContentView_Previews:  PreviewProvider {
  static var previews: some View {
    let game = EmojiMemoryGame()
    game.choose(game.cards.first!)
    return EmojiMemoryGameView(game: game)
//      .preferredColorScheme(.dark)
//    EmojiMemoryGameView(game: game)
//      .preferredColorScheme(.light)
  }
}
