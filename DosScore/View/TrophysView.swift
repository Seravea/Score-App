//
//  TrophysView.swift
//  DosScore
//
//  Created by Romain Poyard on 30/05/2023.
//

import SwiftUI

struct TrophysView: View {
    init(tableViewModel: TableViewModel, table: Table) {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(named: "textColor")
       UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
       
       
        self.tableViewModel = tableViewModel
        self.table = table
        
       }
    
    
    
    @EnvironmentObject var nav: NavigationManager
    @State var players : [Player] = []
    @State var pageIndex: Int = 0
    @ObservedObject var tableViewModel: TableViewModel
   
    var table: Table
    
    var body: some View {
        ZStack {
            
            BackgroundDarkModeView()
           
            VStack {
                
                if tableViewModel.playerAndTrophyDic.isEmpty == false {
                    
                    TabView {
                        
                        ForEach(tableViewModel.playerAndTrophyDic.sorted(by: {$0.key.unwrappedName > $1.key.unwrappedName }), id: \.key) { key, value in
                            VStack {
                                PlayerImageView(player: key, color: .myNeonPurple, circleFrame: 120)
                                
                                Text(key.unwrappedName)
                                    .poppinsItalic16TextColor()
                                    .padding(.bottom, 10)
                                
                                Image(value.trophyImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 241, height: 241)
                                    .cornerRadius(10, corners: .allCorners)
                                    .shadow(color: .white, radius: 0.2)
                                
                                
                                
                                Text(value.trophyTitle)
                                    .trophyTitle()
                                    .fontWeight(.medium)
                                    .padding(.bottom)
                                    .foregroundColor(.white)
                                
                                Text(value.trophyDescription)
                                    .font(.poppinsItalic14)
                                    .opacity(0.7)
                                    .foregroundColor(.textColor)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 241)
                                
                            }
                            
                            //                        .onAppear {
                            //                            if !players.contains(key) {
                            //                                players.append(key)
                            //                            }else {
                            //                                if let playerIndex = players.firstIndex(of: key) {
                            //                                    players.remove(at: playerIndex)
                            //                                }
                            //                            }
                            //
                            //
                            //                                if let playerIndex = players.firstIndex(of: key) {
                            //                                    pageIndex = playerIndex + 1
                            //                                }
                            //
                            //
                            //                        }
                            
                            
                            
                            
                            
                            
                        }
                        
                        
                        
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                    
                    
                    
                    
                }else {
                    Text("Pas de trophés gagnés pour cette partie")
                        .classicMediumText()
                }
                
                Button {
                    
                    
                    nav.popToRoot()
                } label: {
                    MyButtonLabelView(buttonText: "Quitter", color: .appBackground, textSize: 18)
                }
                
            }
            
        }
        .onAppear {
            print(tableViewModel.playerAndTrophyDic.keys)
            tableViewModel.saveWonTrophys()
             
            tableViewModel.addGamesNumber(table: table)
            tableViewModel.restartScoreToZero(table: table)
        }
        .navigationBarBackButtonHidden(true)
       
        
        
    }
}

struct TrophysView_Previews: PreviewProvider {
    static var previews: some View {
        TrophysView(tableViewModel: TableViewModel(), table: TableViewModel().tableArray[0])
    }
}
