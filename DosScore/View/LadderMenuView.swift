//
//  LadderMenuView.swift
//  DosScore
//
//  Created by Romain Poyard on 10/10/2023.
//

import SwiftUI

struct LadderMenuView: View {
    
    @ObservedObject var ladderViewModel: LadderViewModel
    
    
    var body: some View {
        ZStack {
            
            BackgroundDarkModeView()
            
            VStack {
                TitleView(isJustTitle: true, title: "Classement général")

                if ladderViewModel.players.isEmpty {
                   
                    Text("Faites des parties pour monter dans le classement")
                        .classicMediumText()
                        .padding()
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                }else {
                    
                    HStack {
                        Spacer()
                        Text("Points/Parties")
                            .poppinsItalic12()
                            .padding(.trailing, 25)
                            .padding(.top, 10)
                    }
                    
                    ScrollView {
                        ForEach($ladderViewModel.players.indices, id: \.self) { index in
                            
                            LadderMenuCellView(ladderViewModel: ladderViewModel, player: ladderViewModel.players[index], index: index)
                               
                            
                            
                        }
                        
                        .padding(.vertical, 10)
                        
                    }
                }
            }
        }
        
    }
}

#Preview {
    LadderMenuView(ladderViewModel: LadderViewModel())
}


