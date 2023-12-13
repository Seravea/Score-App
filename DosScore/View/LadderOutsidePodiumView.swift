//
//  LadderOutsidePodiumView.swift
//  DosScore
//
//  Created by Romain Poyard on 27/02/2023.
//

import SwiftUI

struct LadderOutsidePodiumView: View {
    var player: Player
    
    var index: Int
    
    
    var body: some View {
       
            VStack {
                    HStack {
                        
                        Text(String(index))
                            .font(.italicPoppins)
                            .font(.system(size: 20))
                            .foregroundColor(.textColor)
                            .opacity(0.8)
                        
                            Image(player.unwrappedImage)
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(maxWidth: 100)

                        Text(player.name ?? "")
                            .font(.lightPoppins)
                            .italic()
                            .foregroundColor(.textColor)
                            .font(.system(size: 14))
                        Spacer()
                        Text(String(player.score))
                            .font(.mediumItalicPoppins)
                            .font(.system(size: 18))
                            .foregroundColor(.textColor)
                            .opacity(0.8)
                        
                    }
               
                    Rectangle()
                        .frame(height: 1)
                        .opacity(0.4)
                
                }
                .padding(.horizontal)
                .foregroundColor(.white)
                .frame(height: 70)
        
        
    }
}
struct LadderOutsidePodiumView_Previews: PreviewProvider {
    static var previews: some View {
        LadderOutsidePodiumView(player: TableViewModel().tableArray[0].gamersArray[0], index: 0)
    }
}
