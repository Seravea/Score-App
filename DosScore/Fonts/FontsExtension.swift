//
//  FontsExtension.swift
//  DosScore
//
//  Created by Romain Poyard on 15/03/2023.
//

import Foundation
import SwiftUI

extension Font {
    static let regularPoppins: Font = .custom("Poppins-Regular", size: 16, relativeTo: .body)
    static let boldItalicPoppins: Font = .custom("Poppins-BlackItalic", size: 18, relativeTo: .title)
    static let mediumItalicPoppins: Font = .custom("Poppins-MediumItalic", size: 18, relativeTo: .title)
    static let italicPoppins: Font = .custom("Poppins-Italic", size: 18, relativeTo: .title)
    static let boldPoppins: Font = .custom("Poppins-Black", size: 18, relativeTo: .title)
    static let lightPoppins: Font = .custom("Poppins-Light", size: 18, relativeTo: .title)
    static let poppinsItalic14 : Font = .custom("Poppins-Italic", size: 14)
}

extension Text {
    
   func titlePage() -> some View {
      self
           .font(.custom("Poppins-MediumItalic", size: 20, relativeTo: .title))
           .italic()
           .foregroundColor(.textColor)
    }
    
    func trophyTitle() -> some View {
        self
            .font(.custom("Poppins-MediumItalic", size: 20, relativeTo: .title))
            .italic()
            .foregroundColor(.white)
        
    }
    
    func classicMediumText() -> some View {
        self
            .font(.custom("Poppins-Medium", size: 17))
            .foregroundColor(.textColor)
    }
    
    func buttonText(color: Color, size: Double) -> some View {
        self
            .shadow(radius: 0.5)
            .foregroundColor(color)
            .font(.custom("Poppins-MediumItalic", size: size))
    }
    
    func classicRegularItalicText() -> some View {
        self
            .font(.custom("Poppins-Regular", size: 14))
            .foregroundColor(.textColor)
            .italic()
    }
    
    func subTextLightItalic() -> some View {
        self
            .font(.custom("Poppins-Light", size: 15))
            .italic()
            .foregroundColor(Color("neonBlue"))
        
    }
    
    func tableText() -> some View {
        self
            .font(.custom("Poppins-SemiBoldItalic", size: 14))
            .foregroundColor(.textColor)
    }
    
    func subTitlePage(size: Double) -> some View {
        self
            .font(.custom("Poppins-MediumItalic", size: size, relativeTo: .title))
            .italic()
            .foregroundColor(.white)
    }
    
    func textFieldText() -> some View {
        self
            .font(.custom("Poppins-Regular", size: 16))
            .italic()
            .foregroundColor(.textColor)
    }
    
    func regulartPoppins14TextColor() -> some View {
        self
            .font(.custom("Poppins-Regular", fixedSize: 14))
            .foregroundColor(.textColor)
    }
    func poppinsItalic16TextColor() -> some View {
        self
            .font(.custom("Poppins-Italic", size: 16))
            .foregroundColor(.textColor)
    }
    func poppinsItalic16neonBlue() -> some View {
        self
            .font(.custom("Poppins-Italic", size: 16))
            .foregroundColor(Color("neonBlue"))
    }
    
    func ladderPositionNumber(index: Int) -> some View {
        self
            .font(.custom(index <= 2 ? "Poppins-SemiBoldItalic" : "Poppins-Italic", size: index <= 2 ? 22 : 20))
            .foregroundStyle(positionColorLadderMenuView(index: index + 1))
    }
    
    func poppinsItalic12() -> some View {
        self
            .font(.custom("Poppins-Italic", size: 12))
            .foregroundStyle(Color.textColor)
    }
    
    func ladderNamePosition(index: Int) -> some View {
        self
            .font(.custom("Poppins-MediumItalic", size: index <= 2 ? 16 : 14))
            .foregroundStyle(index <= 2 ? Color.white : Color.textColor.opacity(0.7))
    }
    
    func ladderPointText(index: Int) -> some View {
        self
            .font(.custom(index <= 2 ? "Poppins-SemiBoldItalic" : "Poppins-MediumItalic", size: index <= 2 ? 24 : 18))
            .foregroundStyle(positionColorLadderMenuView(index: index + 1))
    }
    
}
