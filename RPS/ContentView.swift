//
//  ContentView.swift
//  Rock Paper Scissors
//
//  Created by Paapa Kusi on 5/5/24.
//

import SwiftUI

enum Choices:String, CaseIterable {
    case Scissors = "✂️", Paper = "📄", Rock = "🗿"
}

struct ContentView: View {
    
    @State var computerChoice = Choices.allCases.first!
    @State var gameOutcome = ""
    @State var win = 0
    @State var round = 0
    @State var showAlert = false
    @State var showComputerChoice = false
    var body: some View {
        GeometryReader{geometry in
            VStack {
                VStack {
                    // Computer Choices
                    if !showComputerChoice {
                        Text("🤖")
                            .font(.system(size: 100))
                    } else {
                        Text(computerChoice.rawValue)
                            .font(.system(size: 100))
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height/2)
                VStack{
                    // Player Choices
                    Text("Make your selection: ")
                        .padding()
                    
                    HStack(spacing:0){
                        ForEach(Choices.allCases, id:\.self){option in
                            Button(action:{
                                // Starts new round
                                round += 1
                                // Creates computers choice
                                let index = Int.random(in: 0...Choices.allCases.count-1)
                                computerChoice   = Choices.allCases[index]
                                showComputerChoice = true
                                // Check for winner
                                checkWinner(playerChoice: option)
                            }){Text(option.rawValue)}
                                .font(.system(size: geometry.size.width/CGFloat(Choices.allCases.count)))
                        }
                    }
                    HStack{
                        Spacer()
                        Text("Wins: \(win)")
                        Spacer()
                        Text("Round: \(round)")
                        Spacer()
                    }
                } .frame(width: geometry.size.width, height: geometry.size.height/2)
            } .alert("You \(gameOutcome)!", isPresented: $showAlert){
                Button("Play again!", role: .cancel){showComputerChoice = false}
            }
        }
    }
    func checkWinner(playerChoice:Choices){
        switch playerChoice {
        case .Scissors:
            if computerChoice == .Scissors{
                gameOutcome = "Draw"
            } else if computerChoice == .Paper{
                gameOutcome = "Win"
                win += 1
            } else {
                gameOutcome = "Lose"
            }
        case .Paper:
            if computerChoice == .Scissors{
                gameOutcome = "Lose"
            } else if computerChoice == .Paper{
                gameOutcome = "Draw"
            } else {
                gameOutcome = "Win"
                win += 1
            }
        case .Rock:
            if computerChoice == .Scissors{
                gameOutcome = "Win"
                win += 1
            } else if computerChoice == .Paper{
                gameOutcome = "Lose"
            } else {
                gameOutcome = "Draw"
            }
        }
        showAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
