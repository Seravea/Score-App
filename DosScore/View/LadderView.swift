//
//  LadderView.swift
//  DosScore
//
//  Created by Romain Poyard on 24/01/2023.
//

import SwiftUI

struct LadderView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
   
    
    
    init(table: Table, tableViewModel: TableViewModel, ladderViewModel: LadderViewModel) {
        self.ladderViewModel = ladderViewModel
        self.playerViewModel = PlayerViewModel(table: table)
        self.table = table
        self.tableViewModel = tableViewModel
        
        playerViewModel.fetchPlayers()
        
    }
    var winningPlayers: [Player] {
        if playerViewModel.playersArray[0].table!.gameCategory == .winnerAsMaxPoints {
      return playerViewModel.playersArray.sorted(by: {$0.score > $1.score })
    }else if playerViewModel.playersArray[0].table!.gameCategory == .winnerAsMinPoints {
      return playerViewModel.playersArray.sorted(by: {$0.score < $1.score })
    } else {
        return playerViewModel.playersArray
    }
    }
    @ObservedObject var table: Table
    @ObservedObject var playerViewModel: PlayerViewModel
    @ObservedObject var tableViewModel: TableViewModel
    @ObservedObject var ladderViewModel: LadderViewModel
    
    
    @EnvironmentObject var nav: NavigationManager
    @State var isNavToTrophys: Bool = false
    
    var body: some View {
        ZStack {
         
            BackgroundDarkModeView()
             
            VStack {
                TitleView(isJustTitle: true, title: "Résultat final")
                
                HStack(alignment: .top) {
                        if winningPlayers.count > 2 {
                            LadderPodiumCellView(player: winningPlayers[1], position: 2)
                        }
                        LadderPodiumCellView(player: winningPlayers[0], position: 1)
                        if winningPlayers.count > 2 {
                            LadderPodiumCellView(player: winningPlayers[2], position: 3)
                        }
                        if winningPlayers.count == 2 {
                            VStack {
                                LadderPodiumCellView(player: winningPlayers[1], position: 2)
                                    .frame(height: 250)
                               
                            }
                        
                        }
                        
                    }
                VStack {
                    SubTitleView(title: "Les mauvais", backgroundColor: .lesMauvaisBckg, size: 18)
                        .padding(.top, 30)
                    ScrollView {
                        if winningPlayers.count <= 3 {
                            Text("Sûrement sur le \npodium")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .italic()
                                .bold()
                                .padding(.vertical)
                                .multilineTextAlignment(.center)
                            
                            
                        } else {
                            ForEach(winningPlayers.suffix(winningPlayers.count - 3).indices, id: \.self) { index in
                                LadderOutsidePodiumView(player: winningPlayers[index], index: index + 1)
                                
                            }
                       
                             
                        }
                        Button {
                            nav.selectionPath.append(NavPath.navToTrophys)
                        }label: {
                            MyButtonLabelView(buttonText: "Voir les prix", color: .white, textSize: 18)
                        }
                        .padding()
                    }
                                
                        }
                        .background(
                            Rectangle()
                                .foregroundColor(.lesMauvaisBckg)
                                .cornerRadius(40, corners: [.topLeft,.topRight])
                                .padding(.horizontal, -20)
                        )
                        .padding(.top, -80)
  
            }
            .onAppear {
                ladderViewModel.savePlayers(playersToSave: playerViewModel.playersArray)
                tableViewModel.addTrophysEndGame(endGamePlayers: winningPlayers, table: table)
            }
            
        }
        .navigationBarBackButtonHidden(true)
        
//        .sheet(isPresented: $isShowingSheet) {
//            ZStack {
//                Color(red: 0.95, green: 0.9, blue: 1)
//                Text("This is my sheet. It could be a whole view, or just a text.")
//            }
//
//            .presentationDetents([.medium])
//            .interactiveDismissDisabled(isShowingSheet)
//
//
//        }
    }
}

struct LadderView_Previews: PreviewProvider {
    static var previews: some View {
        LadderView(table: TableViewModel().tableArray[0], tableViewModel: TableViewModel(), ladderViewModel: LadderViewModel())
    }
}

struct LadderPodiumCellView: View {
    let player: Player
    let position: Int
    var color: Color {
        if position == 1 {
            return Color.firstGamer
        } else if position == 2 {
            return Color.secondGamer
        }else {
            return Color.thirdGamer
        }
    }
    var body: some View {
        VStack {
            if position == 1 {
                Image("crown")
                    .padding(.bottom, -10)
            }
                
            
            ZStack(alignment: .top) {
                if position == 1 {
                    RoundedRectangle(cornerRadius: 100)
                        .foregroundStyle(LinearGradient(colors: [Color.firstGamer.opacity(0.5),Color.firstGamer.opacity(0.3),Color.firstGamer.opacity(0.1), Color("darkMBackground"),Color("darkMBackground")], startPoint: .top, endPoint: .bottom))
                        .frame(width: 155, height: 305)
                    RoundedRectangle(cornerRadius: 100)
                        .foregroundStyle(LinearGradient(colors: [Color.firstGamer,Color.firstGamer.opacity(0.5),Color.firstGamer.opacity(0.2), Color("darkMBackground"),Color("darkMBackground")], startPoint: .top, endPoint: .bottom))
                        .frame(width: 130, height: 280)
                        .padding(15)
                }
                
                VStack {
                    if position != 1 {
                        Spacer()
                        Text(String(position))
                            .foregroundColor(.white)
                            
                            
                    }
                    ZStack {
                        if position != 1 {
                            PlayerImageView(player: player, color: color, circleFrame: 64)
                            
                        } else {
                           
                             
                            Image(player.unwrappedImage)
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .frame(height: 110)
                                .padding(.top, 25)

                            
                        }
                    }
                        
                    Text(String(player.score))
                        .foregroundColor(color)
                        .bold()
                        .italic()
                        .font(.system(size: position == 1 ? 24 : 16))
                        
                       
                    Text(player.name!)
                        .italic()
                        .foregroundColor(.white)
                        .font(.system(size: position == 1 ? 15 : 14))
                        
                    if position != 1 {
                        Spacer()
                        Spacer()
                        Spacer()
                    
                    }
                }
                
            }
            .padding(.top, 20)
            
        }
    }
}

struct PlayerImageView: View {
    let player: Player
    let color: Color
    let circleFrame: Double
    var body: some View {
        Group {
            Image(player.unwrappedImage)
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(width: circleFrame, height: circleFrame)
                .overlay(
                    Circle()
                        .strokeBorder(color, lineWidth: 4)
                    
                )
                .overlay(
                    Circle()
                        .stroke(color.opacity(0.15), lineWidth: 8)
                )
            
        }
    }
}
