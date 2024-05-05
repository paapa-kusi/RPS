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
    @State var showComputerChoice = false
    @State var backgroundColor: Color = .white
    var body: some View {
        GeometryReader{geometry in
            VStack {
                VStack {
                    // Computer Choices
                    if !showComputerChoice {
                        Text("Opponent Option")
                            .font(.system(size: 20))
                        Text("🤖")
                            .font(.system(size: 100))
                    } else {
                        Text("Opponent Option")
                            .font(.system(size: 20))
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
                    Text("You \(gameOutcome)!")
                        .font(.title)
                        .padding()
                        .foregroundColor(.white)
                } .frame(width: geometry.size.width, height: geometry.size.height/2)
            }
        }
        .background(backgroundColor.edgesIgnoringSafeArea(.all))
        
    }
    func checkWinner(playerChoice: Choices) {
        withAnimation {
            switch playerChoice {
            case .Scissors:
                if computerChoice == .Scissors {
                    gameOutcome = "Draw"
                    backgroundColor = .mint
                } else if computerChoice == .Paper {
                    gameOutcome = "Win"
                    win += 1
                    backgroundColor = .green
                } else {
                    gameOutcome = "Lose"
                    backgroundColor = .red
                }
            case .Paper:
                if computerChoice == .Scissors {
                    gameOutcome = "Lose"
                    backgroundColor = .red
                } else if computerChoice == .Paper {
                    gameOutcome = "Draw"
                    backgroundColor = .mint
                } else {
                    gameOutcome = "Win"
                    win += 1
                    backgroundColor = .green
                }
            case .Rock:
                if computerChoice == .Scissors {
                    gameOutcome = "Win"
                    win += 1
                    backgroundColor = .green
                } else if computerChoice == .Paper {
                    gameOutcome = "Lose"
                    backgroundColor = .red
                } else {
                    gameOutcome = "Draw"
                    backgroundColor = .mint
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
