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
  
  mutating func shuffle() {
    cards.shuffle()
  }
  
  init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
    cards = []
    // add numberOfPairsOfCards x 2 cards to cards array
    for pairIndex in 0..<numberOfPairsOfCards {
      let content = createCardContent(pairIndex)
      cards.append(Card(content: content, id: pairIndex*2))
      cards.append(Card(content: content, id: pairIndex*2+1))
    }
    cards.shuffle()
  }
  
  struct Card: Identifiable {
    var isFaceUp = false {
      didSet { // Observador de propriedade
        if isFaceUp {
          startUsingBonusTime()
        } else {
          stopUsingBonusTime()
        }
      }
    }
    var isMatched = false {
      didSet {
        stopUsingBonusTime()
      }
    }
    let content: CardContent
    let id: Int
    
    // MARK: - Bonus Time
    
    // Isso pode dar pontos de bônus correspondentes
    // Se o usuário corresponder ao card
    // Antes que passe um certo período de tempo durante o qual o card está virado para cima
    // Pode ser zero, o que nears "nenhum bônus disponível" para este card
    var bonusTimeLimit: TimeInterval = 6
    
    // Há quanto tempo este card está virado para cima?
    private var faceUpTime: TimeInterval {
      if let lastFaceUpDate = self.lastFaceUpDate {
        return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
      } else {
        return pastFaceUpTime
      }
    }
    
    // A última vez que este card foi virado para cima (e ainda está pronto)
    var lastFaceUpDate: Date?
    
    // O tempo acumulado que este card ficou virado para cima no passado
    // (Ou seja, não incluindo a hora atual em que está virado para cima, se for atualmente assim)
    var pastFaceUpTime: TimeInterval = 0
    
    // Quanto tempo resta antes que a oportunidade de bônus se esgote
    var bonusTimeRemaining: TimeInterval {
      max(0, bonusTimeLimit - faceUpTime)
    }
    
    // Porcentagem do tempo de bônus restante
    var bonusRemaining: Double {
      (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
    }
    
    // Se o card foi correspondido durante o período de bônus
    var hasEarnedBonus: Bool {
      isMatched && bonusTimeRemaining > 0
    }
    
    // Se estamos atualmente virados para cima, incomparáveis e ainda não esgotamos a janela de bônus
    var isConsumingBonusTime: Bool {
      isFaceUp && !isMatched && bonusTimeRemaining > 0
    }
    
    // Chamado quando o card passa para o estado de face para cima
    private mutating func startUsingBonusTime() {
      if isConsumingBonusTime, lastFaceUpDate == nil {
        lastFaceUpDate = Date()
      }
    }
    
    // Chamado quando o card volta virado para baixo (ou é correspondido)
    private mutating func stopUsingBonusTime() {
      pastFaceUpTime = faceUpTime
      self.lastFaceUpDate = nil
    }
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
