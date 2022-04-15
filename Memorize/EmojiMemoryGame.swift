//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Marcos André Novaes de Lara on 15/04/22.
//
//  ViewModel

import SwiftUI

class EmojiMemoryGame: ObservableObject { // ObservableObject Reconhece mudanças
  static let emojis = ["🚀", "✈️", "🏎", "🚂", "🚘", "🚖", "🏍", "🚗", "🚕", "🚓", "🚋", "🚅", "🛶", "🚁", "🛸", "🛳", "🛥","🚙", "🚌", "🚎"]
  
  static func createMemoryGame() -> MemoryGame<String> {
    MemoryGame<String>(numberOfPairsOfCards: 5) {
      pairIndex in emojis[pairIndex]
    }
  }
  
  @Published private var model: MemoryGame<String> = createMemoryGame() //@Published é para atualizar sempre que o model mudar
  
  var cards: Array<MemoryGame<String>.Card> {
    model.cards
  }
  
  // MARK: - Intent(s)
  func choose(_ card: MemoryGame<String>.Card) {
    model.choose(card)
  }
}
