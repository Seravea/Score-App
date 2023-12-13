//
//  MyButtonLabelView.swift
//  DosScore
//
//  Created by Romain Poyard on 02/03/2023.
//

import SwiftUI

struct MyButtonLabelView: View {
    let buttonText: String
    let color: Color
    let textSize: Double
    var body: some View {
        Text(buttonText)
            
            .buttonText(color: .textColor, size: textSize)
            .padding(.horizontal, 45)
            .padding(.vertical, 14)
            .background(
                BackgroundButtonView()
            )
    }
}

struct MyButtonLabelView_Previews: PreviewProvider {
    static var previews: some View {
        MyButtonLabelView(buttonText: "Suivant", color: .textColor, textSize: 18)
    }
}


struct BackgroundButtonView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 40)
            .foregroundStyle(LinearGradient(colors: [Color("neonBlue"), Color("neonPurple"), Color("neonPink")], startPoint: .leading, endPoint: .trailing))
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    
                    .strokeBorder(LinearGradient(colors: [.white.opacity(0.4), .clear], startPoint: .top, endPoint: .bottom), lineWidth: 2)
                    
                    
                    
                    
                    
            )
    }
}
