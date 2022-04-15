//
//  MemoryGame.swift
//  Memorize
//
//  Created by Marcos André Novaes de Lara on 15/04/22.
//
//  Model

import Foundation

struct MemoryGame<CardContent> {
  private(set) var cards: Array<Card>
  
  func choose(card: Card) {
    
  }
  
  init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
    cards = Array<Card>()
    // add numberOfPairsOfCards x 2 cards to cards array
    for pairIndex in 0..<numberOfPairsOfCards {
      let content = createCardContent(pairIndex)
      cards.append(Card(content: content))
      cards.append(Card(content: content))
    }
  }
  
  struct Card {
    var isFaceUp: Bool = false
    var isMatched: Bool = false
    var content: CardContent
  }
}
