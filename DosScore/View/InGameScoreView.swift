//
//  InGameScoreView.swift
//  DosScore
//
//  Created by Romain Poyard on 03/01/2024.
//

import SwiftUI

struct InGameScoreView: View {
    var gamersArray: [Player] = []
    @Binding var isShowingScoreView: Bool
    var body: some View {
       VStack {
           HStack {
               
               Spacer()
               
               Button {
                   isShowingScoreView = false
               }label: {
                   ZStack {
                   BackgroundButtonView()
                   Text("Quitter")
                       .buttonText(color: .textColor, size: 14)
                       .shadow(radius: 5)
                   
               }
               .frame(width: 75, height: 30)
               }
               .padding(10)
           }

        TitleView(isJustTitle: true, title: "Score")
            
            List {
                
                ForEach(gamersArray.sorted(by: {$0.score < $1.score
                }), id: \.self) { gamer in
                
                    HStack{
                            
                        Text(gamer.name!)
                            .poppinsItalic16TextColor()
                            .padding(.leading, 20)
                        Spacer()
                       
                        Text("\(gamer.score) points")
                            .poppinsItalic16TextColor()
                        
                        UnwrapPlayerPictureView(player: gamer, imageFrame: 45, paddingHorizontal: 20)
                                    .padding(.vertical, 10)
                        
                    }
                    .myCardCellView(isBorderTakeAll: false, cornerRadius: 10)

                    
                    
                }
                .preferredColorScheme(.dark)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                
            }
            .listStyle(.plain)
           
                
                
            
         
        }
        
        .background(BackgroundDarkModeView().ignoresSafeArea()
            .opacity(0.95))

    }
}

#Preview {
    InGameScoreView(isShowingScoreView: .constant(true))
}
