//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Nicholas Melekian on 10/19/22.
//

import SwiftUI

let moves = ["🪨", "📄", "✂️"]
var moveChoice = Int.random(in: 0..<3)
let beatingMoves = ["📄", "✂️", "🪨"]



struct ContentView: View {
    @State private var comChoice = moves[moveChoice]
    @State private var winGoal = Bool.random()
    @State private var score = 0
    @State private var roundNumber = 1
    @State private var winner = beatingMoves[moveChoice]
    @State private var tag = ""
    @State private var showingScore = false
    @State private var maxQuestions = false
    
    
    
    func winOrLose(_ number: Int) {
        let win = "You won!"
        let lose = "You lost!"
        let tie = "you tied! It's a draw!"
        
        if roundNumber == 10 {
            maxQuestions = true
        }
        
        switch winGoal {
            
        case true:
            if number == moveChoice {
                roundNumber += 1
                tag = tie
                showingScore = true
            } else if number == 0 && moveChoice == 2 {
                roundNumber += 1
                tag = win
                score += 1
                showingScore = true
            } else if number == 1 && moveChoice == 0 {
                roundNumber += 1
                tag = win
                showingScore = true
                score += 1
            } else if number == 2 && moveChoice == 1 {
                roundNumber += 1
                tag = win
                score += 1
                showingScore = true
            } else {
                roundNumber += 1
                tag = lose
                showingScore = true
            }
            
        case false:
            if number == moveChoice {
                roundNumber += 1
                tag = tie
                showingScore = true
            } else if number == 0 && moveChoice == 2 {
                roundNumber += 1
                tag = lose
                showingScore = true
            } else if number == 1 && moveChoice == 0 {
                roundNumber += 1
                tag = lose
                showingScore = true
            } else if number == 2 && moveChoice == 1 {
                roundNumber += 1
                tag = lose
                showingScore = true
            } else {
                roundNumber += 1
                tag = win
                score += 1
                showingScore = true
            }
            
        }
      
    }
    
    func reset(){
        score = 0
        roundNumber = 0
        askQuestion()
    }
    
    func askQuestion() {
        moveChoice = Int.random(in: 0...2)
        winGoal = Bool.random()
    }
    
    var body: some View {
        VStack {
            Text("Round \(roundNumber)/10")
            Text("Your opponent chose \(moves[moveChoice])!")
            HStack {
                Text(winGoal ? "Win" : "Lose")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.red)
                Text("this game!")
            }
            HStack{
                ForEach(0..<3) { move in
                    Button {
                        winOrLose(move)
                    } label: {
                        Text("\(moves[move])")
                    }
                    .padding()
                    .font(.largeTitle)
                }
            }
            .alert(tag, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
            } message: {

                Text("Your score is \(score)")
            }

            .alert(tag, isPresented: $maxQuestions) {
                Button("Restart", action: reset)
            } message: {

                Text("Your score is \(score) out of 8")
            }
            Text("Score: \(score)")
        }
        
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
