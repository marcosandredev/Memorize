//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Marcos Andrรฉ Novaes de Lara on 15/04/22.
//
//  ViewModel

import SwiftUI

class EmojiMemoryGame: ObservableObject { // ObservableObject Reconhece mudanรงas
  typealias Card = MemoryGame<String>.Card // Alias para limpar o cรณdigo
  
  private static let emojis = ["๐", "โ๏ธ", "๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐ถ", "๐", "๐ธ", "๐ณ", "๐ฅ","๐", "๐", "๐"]
  
  private static func createMemoryGame() -> MemoryGame<String> {
    MemoryGame<String>(numberOfPairsOfCards: 15) {
      pairIndex in emojis[pairIndex]
    }
  }
  
  @Published private var model = createMemoryGame() //@Published รฉ para atualizar sempre que o model mudar
  
  var cards: Array<Card> {
    model.cards
  }
  
  // MARK: - Intent(s)          // Intenรงรฃo de fazer mudanรงas
  func choose(_ card: Card) {
    model.choose(card)
  }
  
  func shuffle() {
    model.shuffle()
  }
  
  func restart() {
    model = EmojiMemoryGame.createMemoryGame()
  }
}
