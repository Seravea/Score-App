//
//  colorData.swift
//  DosScore
//
//  Created by Romain Poyard on 18/01/2023.
//

import Foundation
import SwiftUI

extension LinearGradient {
    static let gradientRectangle1 = LinearGradient(colors: [.white,Color("myYellow").opacity(0.4), Color("myYellow")], startPoint: .leading, endPoint: .trailing)
    static let gradientRectangle2 = LinearGradient(colors: [.white,Color("myBlue").opacity(0.4), Color("myBlue")], startPoint: .leading, endPoint: .trailing)
    static let gradientRectangle3 = LinearGradient(colors: [.white,Color("myBronze").opacity(0.4), Color("myBronze")], startPoint: .leading, endPoint: .trailing)
    
    static let firstBorder = LinearGradient(colors: [.white,Color("first").opacity(0.4), Color("first")], startPoint: .leading, endPoint: .trailing)
    static let secondBorder = LinearGradient(colors: [.white,Color("second").opacity(0.4), Color("second")], startPoint: .leading, endPoint: .trailing)
    static let thirdBorder = LinearGradient(colors: [.white,Color("third").opacity(0.4), Color("third")], startPoint: .leading, endPoint: .trailing)
    static let newTableBorder = LinearGradient(colors: [Color("neonBlue"), Color("neonPurple"), Color("neonPink")], startPoint: .leading, endPoint: .trailing)
    static let clearLinearGradient = LinearGradient(colors: [.clear], startPoint: .leading, endPoint: .trailing)
}


extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}


extension Color {
    static let firstGamer = Color("first")
    static let secondGamer = Color("second")
    static let thirdGamer = Color("third")
    static let lesMauvaisBckg = Color("lesMauvaisBckg")
    static let appBackground = Color("darkMBackground")
    static let textColor = Color("textColor")
    static let myNeonPurple = Color("neonPurple")
    static let neonBlue = Color("neonBlue")
    static let myPink = Color("myPink")
    
    
    
}

    
func positionColorLadderMenuView(index: Int) -> Color {
    switch index {
    case 1:
        return Color.firstGamer
    case 2:
        return Color.neonBlue
    case 3:
        return Color.myPink
    default:
        return Color.textColor.opacity(0.7)
    }
    
//    if index == 1 {
//        return Color.firstGamer
//    }else if index == 2 {
//        return Color.neonBlue
//    }else if index == 3 {
//        return Color.myNeonPurple
//    }else {
//       return Color.textColor
//    }
    
    
}
    





