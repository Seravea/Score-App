//
//  AddingPlayerCellView.swift
//  DosScore
//
//  Created by Romain Poyard on 02/05/2023.
//

import SwiftUI

struct AddingPlayerCellView: View {
    @ObservedObject var viewModel : PlayerViewModel
    @ObservedObject var tableViewModel: TableViewModel
    init(table: Table, tableViewModel: TableViewModel) {
        self.viewModel = PlayerViewModel(table: table)
        self.tableViewModel = tableViewModel
        viewModel.fetchPlayers()
        
    }

    
    @State var newGamerName = ""
//    @Binding var newGamerName: String
//    @Namespace var plusAnimationEnd
//    @Namespace var plusAnimationStart
    @State var imageName: String = "profilImage2"
   
    @State var indexImage = 0
    
    var body: some View {
        
        VStack {
            Image(tableViewModel.imagesArray[indexImage])
                .resizable()
                .clipShape(Circle())
                .scaledToFit()
                .frame(width: 120, height: 120)
                .onTapGesture {
                    if indexImage == tableViewModel.imagesArray.count - 1 {
                        indexImage = 0
                    }else {
                        indexImage += 1
                    }
                }
            Text("Appuie pour\nchanger")
                .regulartPoppins14TextColor()
                .multilineTextAlignment(.center)
                .padding(.top, -5)
                .padding(.bottom)
                
            
          
               
                    MyTextFieldView(textFieldText: $newGamerName, promptText: "")
                
                Button {
                    
                    withAnimation(.spring(response: 1)) {
                        if newGamerName.isEmpty == false {
                            viewModel.addPlayer(playerName: newGamerName, imageName: tableViewModel.imagesArray[indexImage])
                            tableViewModel.imagesArray.remove(at: indexImage)
                            tableViewModel.isAddingPlayer.toggle()
                            
                        }
                    
                        newGamerName = ""
                        
                    }
                }label: {
                    MyButtonLabelView(buttonText: "Valider", color: .textColor, textSize: 14)
                    
                    
                    
                }
                .padding(.top)
                
                
            
        }
        .onAppear {
            if viewModel.playersArray.count == 0 || tableViewModel.imagesArray.count < 2 {
                tableViewModel.imagesArray = ["profilImage2", "profilImage3", "profilImage4", "profilImage5", "profilImage6", "profilImage7", "profilImage8", "profilImage9", "profilImage10", "profilImage11"]
                
            }
        }
        
    }
}

struct AddingPlayerCellView_Previews: PreviewProvider {
    static var previews: some View {
        AddingPlayerCellView(table: TableViewModel().tableArray[0], tableViewModel: TableViewModel())
    }
}
