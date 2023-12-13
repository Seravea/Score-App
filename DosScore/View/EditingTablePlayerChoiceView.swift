//
//  EditingTablePlayerChoiceView.swift
//  DosScore
//
//  Created by Romain Poyard on 05/05/2023.
//

import SwiftUI

struct EditingTablePlayerChoiceView: View {
//    init(table: Table, tableViewModel: TableViewModel) {
//        self.tableViewModel = tableViewModel
//        self.table = table
//        self.playerViewModel = PlayerViewModel(table: table)
//
//
//        tableViewModel.fetchTableData()
//        playerViewModel.fetchPlayers()
//
//    }
    @Environment(\.dismiss) var dismiss
    @ObservedObject var tableViewModel: TableViewModel
    @ObservedObject var playerViewModel: PlayerViewModel
    @Binding var table: Table
    //@Binding var isShowingEditingTable: Bool
    @State var isEditingPlayerShowing: Bool = false
    @State var newTableName: String = ""
    @State var selectedPlayer: Player?
    var isEditingTableName: Bool {
        if newTableName.isEmpty {
            return false
        }else {
            return true
        }
    }
    
    
    var body: some View {
       
       
        VStack {
            HStack(alignment: .bottom) {
                MyTextFieldView(textFieldText: $newTableName, promptText: table.unwrappedTableName)
                    .padding([.top])
//
                if isEditingTableName {
                    Button {
                        withAnimation {
                            tableViewModel.changeTableName(table: table, newTableName: newTableName)
                            newTableName = ""
                            
                            
                            
                        }
                    }label: {
                        Image("checkmark.figma")
                            .background(Color.clear.frame(width: 40, height: 40))
                            .padding([.bottom, .trailing])
                            
                    }
                    .animation(.easeIn, value: isEditingTableName)
                    .transition(.slide)
                    
                    
                    
                }
            }
            ScrollView(.horizontal) {
                HStack {
                    ForEach(table.gamersArray, id: \.id!) { player in
                        Button {
                            selectedPlayer = player
                           
                          
                        }label: {
                            ZStack(alignment: .topLeading) {
                                VStack {
                                    UnwrapPlayerPictureView(player: player, imageFrame: 100, paddingHorizontal: 10)
                                    Text(player.name!)
                                        .regulartPoppins14TextColor()
                                }
                                .padding()
                            Image("Editpencil.figma")
                                    .foregroundColor(Color("neonBlue"))
                                    .padding(10)
                            }
                            .myCardCellView(isBorderTakeAll: true, cornerRadius: 10)
                            
                        }
                        .sheet(item: $selectedPlayer, content: { player in
                            EditingPlayerView(table: table, gamersImage: tableViewModel.imagesArray, selectedPlayer: player)
                        })
                       
                        
                    }
                }
                .padding()
                
                 
            }
            Button{
                if newTableName != "" {
                    tableViewModel.changeTableName(table: table, newTableName: newTableName)
                    newTableName = ""
                }
               
              dismiss()
            }label: {
                MyButtonLabelView(buttonText: "Terminer", color: .textColor, textSize: 16)
            }
         
        }
        .frame(height: 455)
      
        
        .background(BackgroundDarkModeView().shadow(radius: 0.5))
        
        .onAppear {
            tableViewModel.fetchTableData()
            playerViewModel.fetchPlayers()
        }
        
    }
    
}

struct EditingTablePlayerChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        EditingTablePlayerChoiceView(tableViewModel: TableViewModel(), playerViewModel: PlayerViewModel(table: TableViewModel().tableArray[0]), table: .constant(TableViewModel().tableArray[0]))
    }
}
