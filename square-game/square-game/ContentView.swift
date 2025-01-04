//
//  ContentView.swift
//  square-game
//
//  Created by Nisila Chandunu on 2025-01-04.
//

import SwiftUI

struct ContentView: View {
    // State variables
    @State private var squares: [Color] = Array(repeating: .gray, count: 9)
    @State private var selectedIndices: [Int] = []
    @State private var points: Int = 0
    @State private var showAlert: Bool = false
    @State private var buttonColors: [Color] = []
    @State private var isProcessing: Bool = false // Prevent further clicks while processing
    @State private var gameCompleted: Bool = false // Track if the game is completed
    
    // Initialize colors for the game
    init() {
        var baseColors: [Color] = [.red, .green, .blue, .yellow]
        baseColors += baseColors // Create pairs of colors (8 colors total)
        baseColors.append(.clear) // Add a "dummy" color for the 9th button
        baseColors.shuffle()
        _buttonColors = State(initialValue: baseColors)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            // Game Title
            Text("Color Match Game")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            // Display Points
            Text("Points: \(points)")
                .font(.title)
            
            // Grid of buttons
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 10) {
                ForEach(0..<9, id: \.self) { index in
                    Button(action: {
                        handleSelection(index: index)
                    }) {
                        Rectangle()
                            .fill(squares[index])
                            .frame(width: 100, height: 100)
                            .cornerRadius(8)
                            .shadow(radius: 5)
                    }
                    .disabled(isProcessing || squares[index] != .gray || gameCompleted) // Disable button if processing or game completed
                }
            }
            
            // Restart Button
            Button("Restart Game") {
                restartGame()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .alert(gameCompleted ? "You Have Won!" : "Try Again", isPresented: $showAlert) {
            Button(gameCompleted ? "Play Again" : "OK", role: .cancel) {
                if gameCompleted {
                    restartGame()
                }
            }
        }
    }
    
    func handleSelection(index: Int) {
        // Ignore already revealed squares or dummy tile
        guard squares[index] == .gray, buttonColors[index] != .clear else { return }
        
        // Reveal the color
        squares[index] = buttonColors[index]
        selectedIndices.append(index)
        
        if selectedIndices.count == 2 {
            isProcessing = true // Block further clicks until resolved
            let firstIndex = selectedIndices[0]
            let secondIndex = selectedIndices[1]
            
            if buttonColors[firstIndex] == buttonColors[secondIndex] {
                // Match found
                points += 1
                selectedIndices.removeAll()
                isProcessing = false
                
                // Check if all tiles are matched
                if squares.allSatisfy({ $0 != .gray }) {
                    gameCompleted = true
                    showAlert = true
                }
            } else {
                // No match, show alert and reset colors
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    squares[firstIndex] = .gray
                    squares[secondIndex] = .gray
                    showAlert = true
                    selectedIndices.removeAll()
                    isProcessing = false
                }
            }
        }
    }
    
    func restartGame() {
        squares = Array(repeating: .gray, count: 9)
        buttonColors.shuffle()
        points = 0
        selectedIndices.removeAll()
        isProcessing = false
        gameCompleted = false
    }
}

#Preview {
    ContentView()
}
