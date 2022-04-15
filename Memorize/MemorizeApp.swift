//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Marcos André Novaes de Lara on 12/04/22.
//

import SwiftUI

@main
struct MemorizeApp: App {
  let game = EmojiMemoryGame()
  
  var body: some Scene {
      WindowGroup {
          ContentView(viewModel: game)
      }
  }
}
