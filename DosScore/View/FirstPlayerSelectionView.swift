//
//  FirstPlayerSelectionView.swift
//  DosScore
//
//  Created by Romain Poyard on 07/04/2023.
//

import SwiftUI

struct FirstPlayerSelectionView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
   
    init(table: Table) {
        self.playerViewModel = PlayerViewModel(table: table)
        self.table = table
        playerViewModel.fetchPlayers()
        UITableView.appearance().tintColor = .white
    }
    
    @EnvironmentObject var nav: NavigationManager
    
    @State var imageSelection: String = ""
    
    @ObservedObject var table: Table
    @ObservedObject var playerViewModel: PlayerViewModel
    
    
    @State var imagesArray = ["profilImage2", "profilImage3", "profilImage4", "profilImage5", "profilImage6", "profilImage7", "profilImage8", "profilImage9", "profilImage10", "profilImage11"]
    
    
    
    @State var isQuitGameAlertOn: Bool = false
    
    @State var isNavToGame: Bool = false
    var body: some View {
        VStack {
            if table.gamersArray[0].score > 0 {
                HStack {
                    Button {
                        isQuitGameAlertOn = true
                    }label: {
                        Image(systemName: "chevron.left")
                            .frame(width: 45, height: 45)
                            .foregroundColor(.textColor)
                            .font(.title2)
                            
                           
                    }
                    
                    TitleView(isJustTitle: false, title: "Quitter le jeu")
                        .padding(.trailing, 45)
                
            }
                .padding(.top, 15)

            } else {
                MyBackButtonWithTitleView(title: "Définis l'ordre de jeu")
            }
            List {
                ForEach(table.gamersArray, id: \.unwrappedUUID) { gamer in
                    HStack {
                        Text("\(gamer.gamerPosition + 1)")
                            .poppinsItalic16neonBlue()
                            .padding(.leading)
                            
                        Text(gamer.name!)
                            .poppinsItalic16TextColor()
                        Spacer()
                       
                        UnwrapPlayerPictureView(player: gamer, imageFrame: 45, paddingHorizontal: 20)
                                    .padding(.vertical, 10)
                        
                    }
                    .myCardCellView(isBorderTakeAll: false, cornerRadius: 10)
                    
                    

                }
                .onMove(perform: table.gamersArray[0].score > 0 ? nil : move)
                .preferredColorScheme(.dark)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                   
            }
            .listStyle(.plain)
            
            .environment(\.editMode, .constant(.active))
            
           
            
            
            
            Button {
                isNavToGame.toggle()
                nav.selectionPath.append(NavPath.navToGame)
            } label: {
                MyButtonLabelView(buttonText: "Commencer", color: .textColor, textSize: 18)
            }
            .padding(.bottom)
            
        }
        .navigationBarBackButtonHidden(true)
        .background(BackgroundDarkModeView())
        .onDisappear {
            playerViewModel.save()
           
        }
        .alert("Êtes-vous sûr de quitter le jeu ?", isPresented: $isQuitGameAlertOn) {
            Button {
                nav.popToRoot()
            } label: {
                Text("Oui")
            }
            Button {
                
            } label: {
                Text("Non")
            }


        }
        
    }
        
    
    func move(from source: IndexSet, to destination: Int) {
        let newIndices = playerViewModel.playersArray.newIndices(moving: source, to: destination)
        playerViewModel.playersArray.enumerated().forEach { currentIndex, entity in
                if (newIndices[currentIndex] != currentIndex) {
                    entity.gamerPosition = Int64(newIndices[currentIndex]!)
                }
            
            }
        playerViewModel.save()
        playerViewModel.fetchPlayers()
        }

}

struct FirstPlayerSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        FirstPlayerSelectionView(table: TableViewModel().tableArray[0])
    }
}

