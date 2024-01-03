//
//  GameView.swift
//  DosScore
//
//  Created by Romain Poyard on 24/01/2023.
//

import SwiftUI

class ScrollToModel: ObservableObject {
    enum Action {
        case end
        case top
    }
    @Published var direction: Action? = nil
}



struct GameView: View {
    @State var isGameEnding: Bool = false
    @State var indexSelectedPlayer = 0
    @StateObject var vm = ScrollToModel()
    init(table: Table, tableViewModel: TableViewModel) {
        self.playerViewModel = PlayerViewModel(table: table)
        self.table = table
        self.tableViewModel = tableViewModel
       
        playerViewModel.fetchPlayers()
        //tableViewModel.fetchTableData()
        
    }
    @ObservedObject var tableViewModel: TableViewModel
    @ObservedObject var table: Table
    @ObservedObject var playerViewModel: PlayerViewModel
   
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var allNumberCards = Card.allNumberCards
    var allSpecialCards = Card.allSpecialCards
    
    @ObservedObject var cardsViewModel = CardsViewModel()
    @State var selectedCards: [Card] = []
    
    var jackpotOnThisStep: Bool {
        var counter: Int = 0
        for card in selectedCards {
            if card.number == 7 {
                counter += 1
            }
        }
        if counter == 3 {
            return true
        }else {
            return false
        }
    }
    
    @EnvironmentObject var nav: NavigationManager
    @State var isNaToLadder: Bool = false
    
    @State var isQuitGameAlertOn: Bool = false
    @State var isShowingScoreView: Bool = false
    
    var body: some View {
        VStack {
            
          
                HStack {
                    Button {
                        isQuitGameAlertOn = true
                    }label: {
                        ZStack {
                            BackgroundButtonView()
                            Text("Quitter")
                                .buttonText(color: .textColor, size: 14)
                                .shadow(radius: 5)
                            
                        }
                        .frame(width: 75, height: 30)
                           
                    }
                    
                Spacer()
                
                    Button {
                        isShowingScoreView = true
                    }label: {
                        
                        ZStack {
                            BackgroundButtonView()
                            Text("Score")
                                .buttonText(color: .textColor, size: 14)
                                .shadow(radius: 5)
                            
                        }
                        .frame(width: 75, height: 30)
                            
                            
                           
                    }
               

            }
                .padding(.horizontal, 15)
            
//            HStack {
//                Button {
//                    nav.goBack()
//                   
//                }label: {
//                    Image(systemName: "chevron.left")
//                        .frame(width: 20, height: 20)
//                        .foregroundColor(.textColor)
//                        .font(.title2)
//                       
//                }
//                
//                TitleView(isJustTitle: tru, title: "Partie en cours")
//
//        }
            
            Text("Manche \(table.inGameStep)")
                .font(.custom("Poppins-Italic", size: 14))
                .foregroundColor(Color("neonBlue"))
           
            
                ScrollViewReader { sp in
                    
                    ZStack(alignment: .trailing) {
                       
                        
                        
                    HStack {
                        if indexSelectedPlayer == 0 {
                            Rectangle()
                                .frame(width: 110, height: 1)
                                .foregroundColor(.clear)
                                .opacity(0)
                                
                        }else if indexSelectedPlayer == 1 {
                            Rectangle()
                                .frame(width: 42, height: 1)
                                .foregroundColor(.clear)
                                .opacity(0)
                        }
                       
                        ScrollView(.horizontal) {
                            
                        
                            
                            
                                HStack(spacing: 20) {
                                       
                                        ForEach($playerViewModel.playersArray, id: \.self) { $player in
                                           
                                            VStack {
                                                UnwrapPlayerPictureView(player: player, imageFrame: playerViewModel.playersArray[indexSelectedPlayer] == player ? 120 : 50, paddingHorizontal: 0)
                                                    .overlay(
                                                        
                                                        Circle()
                                                            .stroke(Color("purpleStrokeImage"), lineWidth: playerViewModel.playersArray[indexSelectedPlayer] == player ? 9 : 0)
                                                    )
                                                if playerViewModel.playersArray[indexSelectedPlayer] == player {
                                                    Text(player.unwrappedName)
                                                        .poppinsItalic16TextColor()
                                                    
                                                    
                                                }
                                                
                                            }
                                            .opacity(playerViewModel.playersArray[indexSelectedPlayer] == player ? 1 : 0.6)
                                            .id(player)
                                           
                                            
                                        }
                                        
                                        if indexSelectedPlayer == playerViewModel.playersArray.count - 1 {
                                            Rectangle()
                                                .frame(width: 132, height: 1)
                                                .foregroundColor(.clear)
                                                .opacity(0)
                                        }else if indexSelectedPlayer == playerViewModel.playersArray.count - 2 {
                                            Rectangle()
                                                .frame(width: 68, height: 1)
                                                .foregroundColor(.clear)
                                                .opacity(0)
                                        }
                                    }
                                    .padding(.leading)
                                    .frame(height: 180)
                            
                            }
                            
                        }
                        .scrollDisabled(true)
                       
                        Button{
                            withAnimation {
                                if tableViewModel.trophyIsAlreadyInTheDic(trophy: Trophy.jackpot) && jackpotOnThisStep {
                                    tableViewModel.playerAndTrophyDic.updateValue(Trophy.jackpot, forKey: playerViewModel.playersArray[indexSelectedPlayer])
                                }
                                
                                if tableViewModel.trophyIsAlreadyInTheDic(trophy: Trophy.godFather) &&  isGodfatherOnThisStep(selectedCard: selectedCards) {
                                    tableViewModel.playerAndTrophyDic.updateValue(Trophy.godFather, forKey: playerViewModel.playersArray[indexSelectedPlayer])
                                }
                                
                                playerViewModel.addPoints(index: indexSelectedPlayer, cardsArray: selectedCards, playerViewModel: playerViewModel)
                                playerViewModel.addCardsInGame(player: playerViewModel.playersArray[indexSelectedPlayer], numberOfCards: selectedCards.count)
                                selectedCards = []
                                tableViewModel.addGamingStep(table: table, playerViewModel: playerViewModel, playerIndex: indexSelectedPlayer)
                                
                                if indexSelectedPlayer == playerViewModel.playersArray.count - 1 && playerViewModel.isGameIsEnding() {
                                    playerViewModel.addLooseStep()
                                    playerViewModel.addWonStep()
                                    isGameEnding = playerViewModel.isGameIsEnding()
                                    nav.selectionPath.append(NavPath.navToLadder)
                                    
                                    playerViewModel.save()
                                    playerViewModel.fetchPlayers()
                                }
                                
                                
                                if indexSelectedPlayer <= playerViewModel.playersArray.count - 2 {
                                    
                                    indexSelectedPlayer += 1
                                }else {
                                    
                                    indexSelectedPlayer = 0
                                    
                                }
                               
                                sp.scrollTo(playerViewModel.playersArray[indexSelectedPlayer],anchor: .center)
                            
                                
                            }
                        }label: {
                            if indexSelectedPlayer == playerViewModel.playersArray.count - 1 {
                                Image(systemName: "arrow.counterclockwise")
                                    .frame(width: 45, height: 45)
                                    .foregroundColor(.white)
                                    .font(.system(size: 38))
                                    .padding(.trailing, 5)
                            }else {
                                Image(systemName: "chevron.right")
                                    .frame(width: 45, height: 45)
                                    .foregroundColor(.white)
                                    .font(.system(size: 42))
                                    .padding(.trailing, 5)
                            }
                        }
                    }
                    .onAppear {
                        withAnimation {
                            indexSelectedPlayer = 0
                            sp.scrollTo(playerViewModel.playersArray[indexSelectedPlayer], anchor: .center)
                           
                        }
                        
                    }
                }
                
            SubTitleView(title: "\(playerViewModel.playersArray[indexSelectedPlayer].score)", backgroundColor: Color("darkMBackground"), size: 40)
                .padding(.top, -10)
            ScrollView {
                if selectedCards.isEmpty == false {
                    ScrollView(.horizontal){
                        HStack {
                            ForEach(selectedCards.indices, id: \.self) { index in
                                Button{
                                        selectedCards.remove(at: index)
                                    
                                }label: {
                                    CardCellView(frameCardWidth: 60, frameCardHeight: 105.6 ,card: selectedCards[index])
                                       // .padding()
                                }
                                
                            }
                        }
                        .padding(.leading, 25)
                        
                    }
                    //.padding(.top, -35)
                }else {
//                    VStack{
//                        
//                    }
//                    .frame(height: 157)
//                    .padding(.top, -25)
//                    
                }
            
            
            
            
                ScrollViewReader { classiqueCardReader in
                    ScrollView(.horizontal){
                        HStack {
                            ForEach(allNumberCards) { card in
                                Button{
                                    withAnimation {
                                        selectedCards.append(card)
                                    }
                                }label: {
                                    CardCellView(frameCardWidth: 96.8, frameCardHeight: 168, card: card)
                                        .padding(5)
                                        
                                }
                                .id(card.image)
                               
                                .onChange(of: selectedCards) { test in
                                    if selectedCards.isEmpty {
                                        withAnimation {
                                            classiqueCardReader.scrollTo("card0", anchor: .trailing)
                                        }
                                    }
                                }
                                
                            }
                        }
                        .padding(.leading, 25)
                        
                    }
                    .scrollIndicators(.hidden)
                }
                
                ScrollViewReader { specialCardReader in
                    ScrollView(.horizontal){
                        HStack {
                            ForEach(allSpecialCards) { card in
                                Button{
                                    withAnimation {
                                        selectedCards.append(card)
                                    }
                                }label: {
                                    CardCellView(frameCardWidth: 96.8, frameCardHeight: 168, card: card)
                                        .padding(5)
                                        
                                }
                                .id(card.image)
                               
                                .onChange(of: selectedCards) { test in
                                    if selectedCards.isEmpty {
                                        withAnimation {
                                            specialCardReader.scrollTo("cardChangeDirection", anchor: .trailing)
                                        }
                                    }
                                }
                            }
                            
                        }
                       
                        .padding(.leading, 25)
                        
                    }
                    .scrollIndicators(.hidden)
                    
//                    .onChange(of: selectedCards) {                        specialCardReader.scrollTo("SpacialCardCell-top")
//                    }
                }
                
            }
//            
//          Rectangle()
//                .frame(height: 45)
//                .ignoresSafeArea()
           
        }
        .navigationBarBackButtonHidden(true)
        .background(BackgroundDarkModeView())
        .alert("Êtes-vous sûr de quitter le jeu ?", isPresented: $isQuitGameAlertOn) {
            Button(role: .destructive
            ) {
                nav.popToRoot()
            } label: {
                Text("Oui")
                    .foregroundStyle(Color.green)
            }
            Button(role: .cancel) {
                
            } label: {
                Text("Non")
                    
            }


        }
        .sheet(isPresented: $isShowingScoreView) {
            InGameScoreView(gamersArray: playerViewModel.playersArray, isShowingScoreView: $isShowingScoreView)
        }
        
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            GameView(table: TableViewModel().tableArray[0], tableViewModel: TableViewModel())
        }
    }
}
