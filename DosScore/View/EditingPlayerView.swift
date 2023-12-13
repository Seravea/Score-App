//
//  EditingPlayerView.swift
//  DosScore
//
//  Created by Romain Poyard on 05/05/2023.
//

import SwiftUI

struct EditingPlayerView: View {
    @Namespace var textToTextField
    @Environment(\.dismiss) var dismiss
    
    init(table: Table, gamersImage: [String], selectedPlayer: Player) {
        self.playerViewModel = PlayerViewModel(table: table)
        self.gamersImage = gamersImage
        self.selectedPlayer = selectedPlayer
        playerViewModel.fetchPlayers()
    }
    var gamersImage: [String]
    
    @ObservedObject var playerViewModel: PlayerViewModel
    @State var newNameText = ""
    @State var isEditing: Bool = false
    @State var selectedImage: String = ""
    var selectedPlayer: Player
    var body: some View {
        VStack {
            TitleView(isJustTitle: true, title: "Modifications du joueur")
            HStack {
                
                
                   
                  
                    MyTextFieldView(textFieldText: $newNameText, promptText: "\(selectedPlayer.unwrappedName)")
                        .padding()
                    
            }
            
            ScrollView(.horizontal) {
                HStack {
                    
                    ForEach(gamersImage, id: \.self) { image in
                        Button {
                            withAnimation {
                               selectedImage = image
                                
                            }
                        }label: {
                            Image(image)
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .frame(width: 150, height: 150)
                                .overlay(
                                    
                                    Circle()
//                                        .stroke(selectedImage == image ? .green : .clear, lineWidth: 6)
                                        .stroke(style: StrokeStyle(lineWidth: 5))
                                    
                                        .foregroundStyle(selectedImage == image ?  LinearGradient.newTableBorder : .clearLinearGradient)
                                        
                                    
                                )
                                .padding([.trailing, .vertical])
                                
                                
                        }
                        .buttonStyle(.borderless)
                        
                        
                    }
                    
                }
                .padding(.leading, 5)
                
            }
          Spacer()
            HStack(spacing: 50) {
                Button{
                    if selectedImage != selectedPlayer.imageString && selectedImage != "" {
                        playerViewModel.changePlayerImage(player: selectedPlayer, newImageName: selectedImage)
                    }
                    if newNameText != selectedPlayer.name && newNameText != "" {
                        playerViewModel.changePlayerName(player: selectedPlayer, newName: newNameText)
                    }
                    playerViewModel.save()
                    playerViewModel.fetchPlayers()
                    
                    newNameText = ""
                    dismiss()
                    
                }label: {
                    MyButtonLabelView(buttonText: "Valider", color: .white, textSize: 14)
            }
               
                Button{
                  
                    selectedPlayer.imageString = ""
                    selectedImage = ""
                    dismiss()
                }label: {
                    Text("Annuler")
                        .buttonText(color: .textColor, size: 14)
                    
                        .frame(width: 145, height: 47)
                    //.padding(.horizontal, 5)
                        .overlay(
                            
                            Capsule()
                            
                                .stroke(style: StrokeStyle(lineWidth: 1.5,
                                                           lineCap: .round,
                                                           lineJoin: .miter,
                                                           miterLimit: 0,
                                                           dashPhase: 0))
                            
                                .foregroundStyle(LinearGradient.newTableBorder)
                            
                            
                        )
                }
            }
            .padding(.bottom)
            if selectedPlayer.imageString == "" {
            Text("Pas d'avatar selectionné")
                    .font(.mediumItalicPoppins)
                    .foregroundColor(.textColor)
            }else {
                Text(" ")
                    .font(.mediumItalicPoppins)
            }
            
            Spacer()
            
        }
        
        .background(BackgroundDarkModeView().ignoresSafeArea()
            .opacity(0.95))
        
    }
    
}

struct EditingPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        EditingPlayerView(table: TableViewModel().tableArray[0], gamersImage: ["profilImage2", "profilImage3", "profilImage4", "profilImage5", "profilImage6", "profilImage7", "profilImage8", "profilImage9", "profilImage10", "profilImage11"] , selectedPlayer: TableViewModel().tableArray[0].gamersArray[0])
    }
}
