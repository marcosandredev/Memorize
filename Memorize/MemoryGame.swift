//
//  MemoryGame.swift
//  Memorize
//
//  Created by Marcos André Novaes de Lara on 15/04/22.
//
//  Model

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable { // Equatable significa que é possivel fazer ==, transformando para "eu me importo um pouco"
  
  private(set) var cards: Array<Card>
  
  private var indexOfTheOneAndOnlyFaceUpCard: Int?
  
  mutating func choose(_ card: Card) {
    if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}), !cards[chosenIndex].isFaceUp,
       !cards[chosenIndex].isMatched {
      if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
        if cards[chosenIndex].content == cards[potentialMatchIndex].content {
          cards[chosenIndex].isMatched = true
          cards[potentialMatchIndex].isMatched = true
        }
        indexOfTheOneAndOnlyFaceUpCard = nil
      } else {
        for index in cards.indices { // .indes == 0..<cards.count
          cards[index].isFaceUp = false
        }
        indexOfTheOneAndOnlyFaceUpCard = chosenIndex
      }
      cards[chosenIndex].isFaceUp.toggle()
    }
  }
  
  init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
    cards = Array<Card>()
    // add numberOfPairsOfCards x 2 cards to cards array
    for pairIndex in 0..<numberOfPairsOfCards {
      let content = createCardContent(pairIndex)
      cards.append(Card(content: content, id: pairIndex*2))
      cards.append(Card(content: content, id: pairIndex*2+1))
    }
  }
  
  struct Card: Identifiable {
    var isFaceUp: Bool = false
    var isMatched: Bool = false
    var content: CardContent
    var id: Int
  }
}
