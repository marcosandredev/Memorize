//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Marcos André Novaes de Lara on 12/04/22.
//

import SwiftUI

@main
struct MemorizeApp: App {
  private let game = EmojiMemoryGame()
  
  var body: some Scene {
      WindowGroup {
          EmojiMemoryGameView(game: game)
      }
  }
}
