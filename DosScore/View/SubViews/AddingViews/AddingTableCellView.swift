//
//  AddingTableCellView.swift
//  DosScore
//
//  Created by Romain Poyard on 02/05/2023.
//

import SwiftUI

struct AddingTableCellView: View {
    
    @StateObject var viewModel: TableViewModel
   
    @Binding var newGamerName: String
    @Binding var textFieldText: String
    @Binding var isAddingPlayer: Bool
    @Binding var isEditingTable: Bool
    
    var promptText: String
    @State var isPlayersShowing: Bool = false
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                if !isPlayersShowing {
                    MyTextFieldView(textFieldText: $textFieldText, promptText: promptText)
                } else {
                    Text(viewModel.tableArray[0].tableName!)
                        .classicMediumText()
                }
                
            }
            if !isPlayersShowing{
                Button {
                    withAnimation {
                        if textFieldText.isEmpty == false {
                            viewModel.addDataToCoreData(tableName: textFieldText)
                            isPlayersShowing = true
                            textFieldText = ""
                            newGamerName = ""
                        }
                    }
                }label: {
                    
                    MyButtonLabelView(buttonText: "Valider", color: .textColor, textSize: 14)
                    .padding(.vertical, 25)
                    .tint(.textColor)
                    

                    
                }
                
            }else {
                MyNewPlayersListView(table: viewModel.tableArray[0], viewModel: viewModel, isAddingPlayer: $viewModel.isAddingPlayer, isEditingTable: $isEditingTable, isPlayerShowing: $isPlayersShowing)
            }
        }
    }
}

struct AddingTableCellView_Previews: PreviewProvider {
    static var previews: some View {
        AddingTableCellView(viewModel: TableViewModel(), newGamerName: .constant("Romain"), textFieldText: .constant("Romain"), isAddingPlayer: .constant(false), isEditingTable: .constant(false), promptText: "tableName")
    }
}
