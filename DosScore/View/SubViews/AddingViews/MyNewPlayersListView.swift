//
//  MyNewPlayersListView.swift
//  DosScore
//
//  Created by Romain Poyard on 02/05/2023.
//

import SwiftUI

struct MyNewPlayersListView: View {
   
    @ObservedObject var table: Table
    var viewModel: TableViewModel
    @Binding var isAddingPlayer: Bool
    @Binding var isEditingTable: Bool
    @Binding var isPlayerShowing: Bool
    var body: some View {
        
        VStack {
            
            if !viewModel.isAddingPlayer {
                ForEach(table.gamersArray) { gamer in
                    HStack{
                        if gamer.unwrappedImage != "" {
                            Image(gamer.unwrappedImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 45, height: 45)
                                .clipShape(Circle())
                                .padding([.bottom, .trailing])
                            
                        }
                        
                        Text(gamer.unwrappedName)
                            .italic()
                            .font(.regularPoppins)
                            .foregroundColor(.textColor)
                        Spacer()
                        
                        Button {
                            withAnimation(.spring()) {
                                table.removeFromGamers(gamer)
                            }
                        }label: {
                            Image("trash.figma")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .opacity(0.5)
                        }
                    }
                    
                    Rectangle()
                        .frame(height: 1)
                        .opacity(0.4)
                        .foregroundColor(.white)
                        .padding(.top, -15)
                    
                    
                }
            }
            if viewModel.isAddingPlayer {
                AddingPlayerCellView(table: table, tableViewModel: viewModel)
            }else {
              
                    VStack {
                        
                        Button {
                            withAnimation(.spring(response: 1)) {
                                viewModel.isAddingPlayer.toggle()
                                
                            }
                        }label: {
                            if table.gamersArray.isEmpty {
                                AddButtonView(buttonLabel: "Ajouter un joueur")
                            }else {
                                HStack {
                                   Image(systemName: "plus")
                                        .foregroundColor(.textColor)
                                        .padding()
                                        .overlay(content: {
                                            Circle()
                                                .stroke(Color("textColor"), lineWidth: 1.5)
                                                .frame(width: 43.5, height: 43.5)
                                        })
                                        .padding(.leading, -5)
                                    Text("Ajouter un joueur")
                                        .font(.custom("Poppins-Regular", size: 15))
                                        .padding(.leading)
                                    
                                        Spacer()
                                }
                                .padding(.top, -5)
                                .tint(.textColor)

                            }
                        }
                        if table.gamersArray.count > 1 {
                            Button{
                                withAnimation(.spring()) {
                                    isPlayerShowing.toggle()
                                    isEditingTable.toggle()
                                    isAddingPlayer.toggle()
                                }
                            }label: {
                                MyButtonLabelView(buttonText: "Valider", color: .textColor, textSize: 14)
                            }
                        }
                }
            }
        }
    }
}

struct MyNewPlayersListView_Previews: PreviewProvider {
    static var previews: some View {
        MyNewPlayersListView(table: TableViewModel().tableArray[0], viewModel: TableViewModel(), isAddingPlayer: .constant(false), isEditingTable: .constant(false), isPlayerShowing: .constant(false))
    }
}
