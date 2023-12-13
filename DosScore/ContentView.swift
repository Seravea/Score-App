//
//  ContentView.swift
//  DosScore
//
//  Created by Romain Poyard on 17/01/2023.
//

import SwiftUI
import UIKit
import CoreData

struct ContentView: View {
    @State var isShowingFirstPage: Bool = true
    
    
    init() {
        
       // UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().unselectedItemTintColor = UIColor.lightGray
        UITabBar.appearance().backgroundColor = UIColor(Color("tabBarBckg"))
        UITabBar.appearance().barTintColor = UIColor(Color("tabBarBckg"))
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.init(name: "Poppins-Regular", size: 10)! ], for: .normal)
        
        
    }
    @State var selectedIcon = 0
    @State var tabItemColor: Color = Color("neonBlue")
    @StateObject var ladderViewModel = LadderViewModel()
    
    @EnvironmentObject var nav: NavigationManager
    var body: some View {
        TabView(selection: $selectedIcon) {
            TablesView(ladderViewModel: ladderViewModel)
                
                .accentColor(.white)
                .tabItem {
                    VStack {
                        Image("joystick\(returnTextColor(selectedIcon: selectedIcon, tag: 0)).figma")
                        Text("Jeu")
                    }
                        
                }.tag(0)
            
                
                
                
            TrophysMenuView()
                
                .tabItem {
                    VStack {
                        Image("trophy\(selectedIcon == 1 ? "Color" : "").figma")
                        Text("Trophées")
                            .font(.custom("Poppins-Regular", size: 10))
                    }
                }
                .tag(1)
            
            LadderMenuView(ladderViewModel: ladderViewModel)
                .tabItem {
                    VStack {
                        Image("ladder\(returnTextColor(selectedIcon: selectedIcon, tag: 2)).figma")
                        Text("Classement")
                    }
                }
                .tag(2)
                
                
                
            
//            LadderView(players: Table.table1)
//                .tabItem {
//                    Label("Classement", systemImage: "trophy")
//                        
//                }
            
        }
        .onAppear {
            if ladderViewModel.players.isEmpty {
                ladderViewModel.fetchPlayers()
            }
            
        }
        .tint(.textColor)
        .fullScreenCover(isPresented: $isShowingFirstPage) {
            LandingPageView(isShowingFirstPage: $isShowingFirstPage)
               //.frame(minWidth: 405)
        }
        
        
       
      
        
        
        
            
    }
    
}
func returnTextColor(selectedIcon: Int, tag: Int) -> String {
    if selectedIcon == tag {
        return "Color"
    }else {
        return ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MyPodiumCellView: View {
    let backgroundColor: LinearGradient
    let borderColor: LinearGradient
    let name: String
    let number: Int
    let badgeName: String?
    let textColor: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .frame(height: 80)
                .foregroundStyle(backgroundColor)
                .border(borderColor, width: 6)
                .cornerRadius(8)
            
            HStack {
                Text(String(number))
                    .font(.title)
                if let badgeName = badgeName {
                    Image(systemName: badgeName)
                        .font(.largeTitle)
                }
                
                Text(name)
                    .font(.title)
                Spacer()
            }
            .padding(.horizontal)
        }
        .foregroundColor(Color(textColor))
        .bold()
    }
}

struct BackgroundDarkModeView: View {
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            
            Color("darkMBackground")
            Circle()
                .foregroundColor(Color("myPink"))
                .opacity(0.11)
                .position(x: 400)
                .blur(radius: 50)
            
            
        }
        .ignoresSafeArea()
    }
}
