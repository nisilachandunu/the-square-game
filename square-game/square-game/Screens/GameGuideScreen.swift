//
//  GameGuideScreen.swift
//  square-game
//
//  Created by Nisila Chandunu on 2025-01-11.
//

import SwiftUI

struct GameGuideScreen: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Game Guide")
                .font(.largeTitle)
                .padding(.bottom)
            
            Text("1. Objective: The goal is to win!")
            Text("2. Controls: Use arrows to move.")
            Text("3. Tips: Avoid obstacles!")
            
            Spacer()
        }
        .padding()
        .navigationBarHidden(true)
    }
}

struct GameGuideScreen_Previews: PreviewProvider {
    static var previews: some View {
        GameGuideScreen()
    }
}
