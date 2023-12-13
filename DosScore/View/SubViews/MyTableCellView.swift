//
//  MyTableCellView.swift
//  DosScore
//
//  Created by Romain Poyard on 02/05/2023.
//

import SwiftUI

struct MyTableCellView: View {
    @Namespace var isSelectedOff
    @Namespace var isSelectedOn
    var selectedTable: Table?
    @Binding var table: Table
    @State var isShowingAlert: Bool = false
    @ObservedObject var playerViewModel: PlayerViewModel
    @ObservedObject var tableViewModel: TableViewModel
  
    var gamersNumber: Int {
        return playerViewModel.table.gamersArray.count
    }
   
    var isOpen: Bool {
        if selectedTable == table {
            return true
        }else {
            return false
        }
    }
    @State var isLiked = false
    @State var isShowingEditing: Bool = false
    
    @EnvironmentObject var nav: NavigationManager
    @State var isNavToSelectGame: Bool = false
    var body: some View {
        if playerViewModel.table.tableName != nil {
            ZStack {
                ZStack {
                    if !isOpen {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color("tableBckg"))
                            .frame(height: 102)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .strokeBorder(LinearGradient(colors: [.white.opacity(0.12), .clear], startPoint: .top, endPoint: .bottom), lineWidth: 1)
                                    .matchedGeometryEffect(id: "action", in: isSelectedOn)
                                
                            )
                           
                            
                          
                    }else {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color("tableBckg"))
                            .frame(height: 220)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .strokeBorder(LinearGradient(colors: [.white.opacity(0.12), .clear], startPoint: .top, endPoint: .bottom), lineWidth: 1)
                                    
                                
                            )
                        
                        
                        //  Message in the Debug Terminal with the GeometryEffect "actionOff", Testing but nothing change without the matchedGeometry modifier and the error message is deleted.. so...
                        
//                            .matchedGeometryEffect(id: "actionOff", in: isSelectedOff)
                      
                        
                            .overlay {
                                AddButtonBackgroundView()
                                    .matchedGeometryEffect(id: "action", in: isSelectedOn)
                                    
                                    
                            }
                            
                    }
                    
                }
               // .animation(.spring().delay(2), value: isOpen)
                
                VStack {
                    Spacer()
                    if isOpen {
                        HStack {
                            Spacer()
                            Button {
                                isShowingEditing.toggle()
                            }label: {
                                Image("Editpencil.figma")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25.98, height: 26)
                                    .opacity(0.35)
                            }
                            .frame(width: 40, height: 40)
                            
                            
                            Button{
                                isShowingAlert.toggle()
                                
                            }label: {
                                Image("trash.figma")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25.57, height: 27)
                                    .opacity(0.35)
                            }
                            .frame(width: 40, height: 40)
                        }
                        .foregroundColor(.white)
                        .padding(.trailing, 25)
                        .sheet(isPresented: $isShowingEditing) {
                            EditingTablePlayerChoiceView(tableViewModel: tableViewModel, playerViewModel: playerViewModel, table: $table)
                                .presentationDetents([.height(400)])
                        }
                       
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            Text(playerViewModel.table.tableName ?? "")
                                .tableText()
                            
                            Text("\(playerViewModel.table.gamesNumber) partie\(writeAnS(numberSupToOne: Int(playerViewModel.table.gamesNumber))) jouée\(writeAnS(numberSupToOne: Int(playerViewModel.table.gamesNumber)))")
                                .subTextLightItalic()
                            
                        }
                        
                        Spacer()
                        
                        HStack {
                            ForEach(playerViewModel.table.gamersArray.prefix(3)) { gamer in
                                UnwrapPlayerPictureView(player: gamer, imageFrame: 40, paddingHorizontal: -10)
                            }
                            
                            if gamersNumber > 3 {
                                ZStack {
                                    Circle()
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(Color("circleBckg"))
                                    Text("+\(gamersNumber - 3)")
                                        .font(.custom("Poppins-SemiBoldItalic", size: 16))
                                        .foregroundColor(.white)
                                }
                                .padding(.horizontal, -10)
                                
                                
                            }
                           
                        }
                        .padding(.trailing)
                        
                    }
                    .padding()
                    .foregroundColor(.white)
                   
                    if isOpen {
                        HStack {
                            Spacer()
                            
                            
                            Button {
                               
                                nav.selectionPath.append(NavPath.navToSelectGame)
                            }label: {
                                MyButtonLabelView(buttonText: "Commencer la partie", color: .white, textSize: 18)
                                    
                            }
                            .transition(.slide)
                            
                            .padding(.bottom)
                            
                            
                            
                        
                            
                            
                            .alert(isPresented: $isShowingAlert) {
                                Alert(title: Text("Voulez-vous vraiment supprimer la table \(playerViewModel.table.unwrappedTableName)"), primaryButton: .destructive(Text("Supprimer")) {
                                    withAnimation {
                                        tableViewModel.deleteTable(table: playerViewModel.table)
                                    }
                                    
                                }, secondaryButton: .default(Text("Annuler")))
                            }
                            Spacer()
                        }
                        .matchedGeometryEffect(id: "actionOff", in: isSelectedOff)
                        
                    
                        
                    }
                    
                    Spacer()
                }
                
                .padding(.vertical)
 
            }
//            .navigationDestination(for: NavPath.self) { navigation in
//                switch navigation {
//                case .navToSelectGame:
//                    SelecteGameCategoryView(tableViewModel: tableViewModel, table: table, playerViewModel: playerViewModel)
//                case .navToFirstPlayerSelection:
//                    FirstPlayerSelectionView(table: table)
//                case .navToGame:
//                    GameView(table: table, tableViewModel: tableViewModel)
//                case .navToLadder:
//                    LadderView(table: table, tableViewModel: tableViewModel)
//                case .navToTrophys:
//                    Text("Trophys")
////                    TrophysView(playerAndTrophyDic: endGameTrophys, tableViewModel: tableViewModel, table: table)
//                }
//                
//                
//            }
            

            
            
            
        }
            
    }
        
}
struct MyTableCellView_Previews: PreviewProvider {
    static var previews: some View {
        MyTableCellView(selectedTable: TableViewModel().tableArray[0], table: .constant(TableViewModel().tableArray[1]), playerViewModel: PlayerViewModel(table: TableViewModel().tableArray[0]), tableViewModel: TableViewModel())
    }
}
