//
//  SelecteGameCategoryView.swift
//  DosScore
//
//  Created by Romain Poyard on 17/05/2023.
//

import SwiftUI

struct SelecteGameCategoryView: View {
    @ObservedObject var tableViewModel: TableViewModel
    @ObservedObject var table: Table
    @ObservedObject var playerViewModel: PlayerViewModel
    
    @State var selectedGamingMode: String = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
   
    
    
    @State var isClassicSelected: Bool = false
    @State var isSpecialSelected: Bool = false
    
    @EnvironmentObject var nav: NavigationManager
    
    @State var isNavToGame: Bool = false
    
    var body: some View {
        VStack {
            MyBackButtonWithTitleView(title: "Choisis ton mode")
           // ScrollView {
               
                HStack {
                    Text("Classique")
                        .buttonText(color: .textColor, size: 18)
                        .padding(.leading, 25)
                        Spacer()
                    Image("classiqueMode")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .cornerRadius(10)
                }
                .frame(width: 347, height: 102)
                .myCardCellView(isBorderTakeAll: false, cornerRadius: 15)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(style: StrokeStyle(lineWidth: 3,
                                                   lineCap: .round,
                                                   lineJoin: .miter,
                                                   miterLimit: 0,
                                                   dashPhase: 0))
                        .foregroundStyle(isClassicSelected ? LinearGradient.newTableBorder : .clearLinearGradient)
                )

            
                .padding(.horizontal)
                    .onTapGesture {
                        if isSpecialSelected {
                            withAnimation(.spring()) {
                                isSpecialSelected = false
                            }
                            withAnimation(.spring()) {
                                isClassicSelected = true
                            }
                        }else {
                            withAnimation(.spring()) {
                                isClassicSelected.toggle()
                            }
                        }
                    }
                    .transition(.move(edge: .top))
//                Button{
//                    let mode: GameProperties = .winnerAsMaxPoints
//                    withAnimation {
//                        if selectedGamingMode != mode.rawValue {
//                            selectedGamingMode = mode.rawValue
//                            table.gameProperties = selectedGamingMode
//                            tableViewModel.save()
//
//                        }else {
//                            selectedGamingMode = ""
//                        }
//                    }
//                }label: {
//                    HStack {
//                        Text("Premier à 500 points")
//                            .buttonText(color: .textColor, size: 16)
//                            .padding(.leading, 15)
//                            .opacity(selectedGamingMode == GameProperties.winnerAsMaxPoints.rawValue ? 1 : 0.7)
//                        Spacer()
//
//                    }
//                    .frame(width: 340, height: 56)
//                    .myCardCellView(isBorderTakeAll: false, cornerRadius: 15)
//                }
            if isClassicSelected {
                Button{
                    let mode: GameProperties = .winnerAsMinPoints
                    withAnimation {
                        if selectedGamingMode != mode.rawValue {
                            selectedGamingMode = mode.rawValue
                            table.gameProperties = selectedGamingMode
                            tableViewModel.save()
                            
                        }else {
                            selectedGamingMode = ""
                        }
                    }
                    
                }label: {
                    HStack {
                        Text("Perdant a 500 points")
                            .buttonText(color: .textColor, size: 16)
                            .padding(.leading, 15)
                            .opacity(selectedGamingMode == GameProperties.winnerAsMinPoints.rawValue ? 1 : 0.7)
                        Spacer()
                        
                    }
                    .frame(width: 340, height: 56)
                    .myCardCellView(isBorderTakeAll: false, cornerRadius: 15)
                    
                }
               
            }
                    HStack {
                        Text("Spécial")
                            .buttonText(color: .textColor, size: 18)
                            .padding(.leading, 25)
                        Spacer()
                        Image("specialMode")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                            .cornerRadius(10)
                    }
                    .frame(width: 347, height: 102)
                    .myCardCellView(isBorderTakeAll: false, cornerRadius: 15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(style: StrokeStyle(lineWidth: 3,
                                                       lineCap: .round,
                                                       lineJoin: .miter,
                                                       miterLimit: 0,
                                                       dashPhase: 0))
                            .foregroundStyle(isSpecialSelected ? LinearGradient.newTableBorder : .clearLinearGradient)
                            
                    )
                    .onTapGesture {
                        withAnimation {
                            if isClassicSelected {
                                withAnimation(.spring()) {
                                    isClassicSelected = false
                                    isSpecialSelected = true
                                }
                            }else {
                                withAnimation(.spring()) {
                                    isSpecialSelected.toggle()
                                }
                            }
                            
                        }
                    }
                    .padding(.top, 30)
                   
            
            if isSpecialSelected {
                Button {
                    
                }label: {
                    HStack {
                        Text("À venir")
                            .buttonText(color: .textColor, size: 16)
                            .padding(.leading, 15)
                            .opacity(selectedGamingMode == GameProperties.winnerAsMinPoints.rawValue ? 1 : 0.7)
                        Spacer()
                        
                    }
                    .frame(width: 340, height: 56)
                    .myCardCellView(isBorderTakeAll: false, cornerRadius: 15)
                    
                }
                .disabled(true)
            }
            
             Spacer()
            
            Button{
                nav.selectionPath.append(NavPath.navToFirstPlayerSelection)
               
            }label: {
                MyButtonLabelView(buttonText: "Commencer", color: .textColor, textSize: 18)
                    .opacity(selectedGamingMode == "" ? 0.5 : 1)
            }
            .disabled(selectedGamingMode == "")
            .padding(.bottom)
            
          
            
        }
        .navigationBarBackButtonHidden(true)
        .background(BackgroundDarkModeView())
        
    }
}

struct SelecteGameCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        SelecteGameCategoryView(tableViewModel: TableViewModel(),table: TableViewModel().tableArray[0], playerViewModel: PlayerViewModel(table: TableViewModel().tableArray[0]))
    }
}
