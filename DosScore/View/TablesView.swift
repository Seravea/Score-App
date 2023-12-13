//
//  TablesView.swift
//  DosScore
//
//  Created by Romain Poyard on 27/01/2023.
//

import SwiftUI
import CoreData


struct TablesView: View {
    
    @State var isShowingAlert: Bool = false
    @State var selectedTable: Table? = nil
    
    
    @StateObject var tableViewModel = TableViewModel()
    
    @Namespace var plusAnimationStart
    @Namespace var plusAnimationEnd
    @Namespace var firstPlusTable
    
    @State var isEditingTable: Bool = false
    
   // @State var isAddingPlayer = false
    @State var newTableName = ""
    @State var newGamerName = ""
    
    @StateObject var nav = NavigationManager()
    @ObservedObject var ladderViewModel: LadderViewModel
    var body: some View {
        NavigationStack(path: $nav.selectionPath) {
            
            VStack(alignment: .leading) {
                TitleView(isJustTitle: true, title: "Tables de jeu")
                
                
                ScrollView {
                    Spacer()
                    VStack {
                        VStack {
                            if !isEditingTable {
                                
                                Button {
                                    withAnimation(.spring()) {
                                        isEditingTable = true
                                    }
                                } label: {
                                    VStack {
                                        AddButtonView(buttonLabel: "Créer une nouvelle table")
                                        
                                    }
                                    
                                    
                                }
                                .padding(.horizontal)
                                
                                
                                
                            } else {
                                
                                AddingTableCellView(viewModel: tableViewModel,newGamerName: $newGamerName, textFieldText: $newTableName, isAddingPlayer: $tableViewModel.isAddingPlayer, isEditingTable: $isEditingTable, promptText: "Nom de la table")
                                
                                
                            }
                        }
                        .padding(40)
                        .background(
                            AddButtonBackgroundView()
                                .padding(.horizontal)
                               // .frame(minWidth: 350)
                                
                        )
                        
                        SubTitleView(title: "Mes tables", backgroundColor: .appBackground, size: 18)
                            .padding(.horizontal, 80)
                            .padding(.top, 30)
                            .onAppear {
                                selectedTable = nil
                                
                            }
                        
                        
                        ForEach($tableViewModel.tableArray) { $table in
                            if table.gamersArray.count > 1 {
                                MyTableCellView(selectedTable: selectedTable, table: $table ,playerViewModel: PlayerViewModel(table: table), tableViewModel: tableViewModel)
                                    .onTapGesture {
                                        if selectedTable == nil {
                                            withAnimation(.spring()) {
                                                selectedTable = table
                                            }
                                        }else if selectedTable == table {
                                            withAnimation() {
                                                selectedTable = nil
                                            }
                                        }else {
                                            withAnimation(.spring()) {
                                                selectedTable = table
                                            }
                                        }
                                    }
                                    .padding()
                                    .onTapGesture {
                                        if selectedTable == nil {
                                            withAnimation(.spring()) {
                                                selectedTable = table
                                            }
                                        }else if selectedTable == table {
                                            withAnimation() {
                                                selectedTable = nil
                                            }
                                        }else {
                                            withAnimation(.spring()) {
                                                selectedTable = table
                                            }
                                        }
                                    }
                            }
                            
                        }
                        .padding(.top, -15)
                    }
                    .navigationDestination(for: NavPath.self) { navigation in
                        switch navigation {
                        case .navToSelectGame:
                            SelecteGameCategoryView(tableViewModel: tableViewModel, table: selectedTable!, playerViewModel: PlayerViewModel(table: selectedTable!))
                        case .navToFirstPlayerSelection:
                            FirstPlayerSelectionView(table: selectedTable!)
                        case .navToGame:
                            GameView(table: selectedTable!, tableViewModel: tableViewModel)
                        case .navToLadder:
                            LadderView(table: selectedTable!, tableViewModel: tableViewModel, ladderViewModel: ladderViewModel)
                        case .navToTrophys:
                            TrophysView(tableViewModel: tableViewModel, table: selectedTable!)
                        }
                        
                        
                    }
                }
               
                
            }
            .background(BackgroundDarkModeView())
            
            
        }
        .environmentObject(nav)
        .navigationBarTitleDisplayMode(.inline)
    
        
    }
}


struct TablesView_Previews: PreviewProvider {
    static var previews: some View {
        TablesView(ladderViewModel: LadderViewModel())
    }
}









struct AddButtonBackgroundView: View {
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(style: StrokeStyle(lineWidth: 3,
                                               lineCap: .round,
                                               lineJoin: .miter,
                                               miterLimit: 0,
                                               dashPhase: 0))
                    .foregroundStyle(LinearGradient.newTableBorder)
                    //.padding(.horizontal)
                
                
            )
            .foregroundColor(.clear)
           // .padding(.top)
        
        
    }
}











