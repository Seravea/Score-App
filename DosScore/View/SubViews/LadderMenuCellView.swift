//
//  LadderMenuCellView.swift
//  DosScore
//
//  Created by Romain Poyard on 12/10/2023.
//

import SwiftUI

struct LadderMenuCellView: View {
    @ObservedObject var ladderViewModel: LadderViewModel
    let player: PlayerLadder
    let index: Int
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("\(index + 1)")
                    .ladderPositionNumber(index: index)
                    
                   
                
                
                Image(player.playerImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 45)
                    .overlay {
                        if index + 1 <= 3  {
                            Circle()
                                .stroke(lineWidth: 2)
                                .foregroundStyle(positionColorLadderMenuView(index: index + 1))
                        }
                            
                    }
                    .padding(.horizontal, 14)
                    .padding(.leading, index == 0 ? 4 : 0)
                    
                Text(player.playerName)
                    .ladderNamePosition(index: index)
                Spacer()
                Text("\(player.playerCumulPoints)")
                    .ladderPointText(index: index)
                    .padding(10)
                    
            }
            .frame(minHeight: 60)
           
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(Color.textColor.opacity(0.30))
                .padding(.vertical, 10)
                
        }
        .padding(.horizontal, 25)
        
    }
}

#Preview {
    ZStack {
        BackgroundDarkModeView()
        VStack {
            Spacer()
            LadderMenuCellView(ladderViewModel: LadderViewModel(), player: LadderViewModel().players[3], index: 0)
                .background(BackgroundDarkModeView())
            LadderMenuCellView(ladderViewModel: LadderViewModel(), player: LadderViewModel().players[3], index: 1)
            LadderMenuCellView(ladderViewModel: LadderViewModel(), player: LadderViewModel().players[3], index: 2)
            LadderMenuCellView(ladderViewModel: LadderViewModel(), player: LadderViewModel().players[3], index: 3)
            Spacer()
                
        }
    }
}
