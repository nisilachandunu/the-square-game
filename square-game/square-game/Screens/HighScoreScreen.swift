//
//  HighScoreScreen.swift
//  square-game
//
//  Created by Nisila Chandunu on 2025-01-11.
//

import SwiftUI

struct HighScoreScreen: View {
    var body: some View {
        VStack {
            Text("High Scores")
                .font(.largeTitle)
                .padding()
            
            Spacer()
        }
        //.navigationBarHidden(true)
    }
}

struct HighScoreScreen_Previews: PreviewProvider {
    static var previews: some View {
        HighScoreScreen()
    }
}
