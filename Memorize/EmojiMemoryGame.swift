//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Marcos André Novaes de Lara on 15/04/22.
//
//  ViewModel

import SwiftUI

class EmojiMemoryGame: ObservableObject { // ObservableObject Reconhece mudanças
  typealias Card = MemoryGame<String>.Card // Alias para limpar o código
  
  private static let emojis = ["🚀", "✈️", "🏎", "🚂", "🚘", "🚖", "🏍", "🚗", "🚕", "🚓", "🚋", "🚅", "🛶", "🚁", "🛸", "🛳", "🛥","🚙", "🚌", "🚎"]
  
  private static func createMemoryGame() -> MemoryGame<String> {
    MemoryGame<String>(numberOfPairsOfCards: 15) {
      pairIndex in emojis[pairIndex]
    }
  }
  
  @Published private var model = createMemoryGame() //@Published é para atualizar sempre que o model mudar
  
  var cards: Array<Card> {
    model.cards
  }
  
  // MARK: - Intent(s)
  func choose(_ card: Card) {
    model.choose(card)
  }
}
