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
  
  private var indexOfTheOneAndOnlyFaceUpCard: Int? {
    get { cards.indices.filter({ cards[$0].isFaceUp}).oneAndOnly }
    
    set { cards.indices.forEach{ cards[$0].isFaceUp = ($0 == newValue) } }  // .indes == 0..<cards.count
  }
  
  mutating func choose(_ card: Card) {
    if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}), !cards[chosenIndex].isFaceUp,
       !cards[chosenIndex].isMatched {
      if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
        if cards[chosenIndex].content == cards[potentialMatchIndex].content {
          cards[chosenIndex].isMatched = true
          cards[potentialMatchIndex].isMatched = true
        }
        cards[chosenIndex].isFaceUp = true
      } else {
        indexOfTheOneAndOnlyFaceUpCard = chosenIndex
      }
    }
  }
  
  init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
    cards = []
    // add numberOfPairsOfCards x 2 cards to cards array
    for pairIndex in 0..<numberOfPairsOfCards {
      let content = createCardContent(pairIndex)
      cards.append(Card(content: content, id: pairIndex*2))
      cards.append(Card(content: content, id: pairIndex*2+1))
    }
  }
  
  struct Card: Identifiable {
    var isFaceUp = false
    var isMatched = false
    let content: CardContent
    let id: Int
  }
}

extension Array { // Extensão de código para Array, para ser utilizado em qualquer Array do projeto
  var oneAndOnly: Element? {
    if count == 1 {
      return first
    } else {
      return nil
    }
  }
}
