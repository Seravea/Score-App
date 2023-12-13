//
//  SelectPlayerImageModalView.swift
//  DosScore
//
//  Created by Romain Poyard on 26/04/2023.
//

import SwiftUI

struct SelectPlayerImageModalView: View {
    @Namespace var textToTextField
    @Environment(\.dismiss) var dismiss
    @Binding var gamersImage: [String]
    
    @ObservedObject var playerViewModel: PlayerViewModel
    @State var newNameText = ""
    @State var isEditing: Bool = false
    @State var selectedImage: String = ""
    @Binding var selectedPlayer: Player?
    var body: some View {
        VStack {
            TitleView(isJustTitle: true, title: "Modifie le joueur")
            HStack {
                
                if !isEditing {
                    if selectedPlayer != nil{
                        Text("\(selectedPlayer!.unwrappedName )  ")
                            .titlePage()
                    } else {
                        Text("\(newNameText)")
                            .titlePage()
                    }
                    Button {
                        withAnimation {
                            isEditing.toggle()
                        }
                    }label: {
                        Image("Editpencil.figma")
                            .padding()
                    }
                    .matchedGeometryEffect(id: "myAnimation", in: textToTextField)
                        
                }else {
                    MyTextFieldView(textFieldText: $newNameText, promptText: "\(selectedPlayer!.unwrappedName)")
                        .padding()
                    Button{
                        selectedPlayer!.name = newNameText
                        playerViewModel.save()
                        playerViewModel.fetchPlayers()
                        withAnimation {
                            isEditing.toggle()
                        }
                    }label: {
                        Image("checkmark.figma")
                    }
                    .padding()
                        .matchedGeometryEffect(id: "myAnimation", in: textToTextField)
                        
                }
                
                
                
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
                                    
                                        .foregroundStyle(selectedPlayer?.imageString == image ?  LinearGradient.newTableBorder : .clearLinearGradient)
                                        
                                    
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
                    selectedPlayer!.imageString = selectedImage
                    
                    playerViewModel.save()
                    playerViewModel.fetchPlayers()
                    selectedPlayer = nil
                }label: {
                    MyButtonLabelView(buttonText: "Valider", color: .white, textSize: 14)
            }
                Button{
                  
                    selectedPlayer?.imageString = nil
                    playerViewModel.save()
                    playerViewModel.fetchPlayers()
                    selectedImage = ""
                    selectedPlayer = nil
                }label: {
                    Text("Annuler")
                        .buttonText(color: .textColor, size: 14)
                        
                        .frame(width: 123, height: 37)
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
           
            
            Spacer()
            
        }
        
        .background(BackgroundDarkModeView().ignoresSafeArea()
            .opacity(0.95))
        
    }
    
}

struct SelectPlayerImageModalView_Previews: PreviewProvider {
    static var previews: some View {
        SelectPlayerImageModalView(gamersImage: .constant(["profilImage2", "profilImage3", "profilImage4", "profilImage5", "profilImage6", "profilImage7", "profilImage8", "profilImage9", "profilImage10", "profilImage11"]), playerViewModel: PlayerViewModel(table: TableViewModel().tableArray[0]), selectedPlayer: .constant(TableViewModel().tableArray[0].gamersArray[0]))
    }
}
