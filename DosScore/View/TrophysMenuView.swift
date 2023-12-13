//
//  TrophysMenuView.swift
//  DosScore
//
//  Created by Romain Poyard on 06/10/2023.
//

import SwiftUI

struct TrophysMenuView: View {
    
    init() {
        
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(.white.opacity(0.5))], for: .normal)
    }
    
    var savedTrophys: [Trophy] {
        var returnTrophys: [Trophy] = []
        if let savedTrophysData = UserDefaults.standard.object(forKey: "TrophysWon") as? Data {
            let decoder = JSONDecoder()
            if let loadedTrophy = try? decoder.decode([Trophy].self, from: savedTrophysData) {
                returnTrophys = loadedTrophy
            }
            
        }
        return returnTrophys
    }
    
    var pickerStates = ["À receuillir", "Ma collection"]
    @State var selectedPicker = "À receuillir"
    
    var body: some View {
        
       
        ZStack {
            BackgroundDarkModeView()
            VStack {
                TitleView(isJustTitle: true, title: "Trophées")
                    
                
                Picker("What is your favorite color?", selection: $selectedPicker) {
                    ForEach(pickerStates, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                
                .colorMultiply(.textColor)
                
                ScrollView {
                    
                    ForEach(selectedPicker == "Ma collection" ? savedTrophys : Trophy.allTrophy) { trophy in
                        
                        
                        WinTrophyCellView(trophy: trophy)
                        
                        
                            
                    }
                    
                    
                    if savedTrophys.isEmpty && selectedPicker == "Ma collection" {
                       
                        Text("Faites des parties pour gagner des trophées")
                            .classicMediumText()
                            .padding()
                            .multilineTextAlignment(.center)
                    }
                    
                }
            }

            
        }
        
       
        
        
    }
}

#Preview {
    TrophysMenuView()
}

struct WinTrophyCellView: View {
    let trophy: Trophy
    var body: some View {
        HStack(alignment: .top) {
            if trophy.trophyImage.isEmpty {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 120 , height: 120)
                    .foregroundColor(.gray)
            }else {
                Image(trophy.trophyImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
                    .cornerRadius(10, corners: .allCorners)
            }
            VStack(alignment: .leading) {
                Text(trophy.trophyTitle)
                    .trophyTitle()
                Text(trophy.trophyDescription)
                    .font(.poppinsItalic14)
                    .opacity(0.7)
                    .foregroundColor(.textColor)
            }
            Spacer()
            
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
    }
}
