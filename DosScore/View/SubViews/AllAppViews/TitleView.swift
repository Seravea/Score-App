//
//  TitleView.swift
//  DosScore
//
//  Created by Romain Poyard on 27/01/2023.
//
import UIKit
import SwiftUI

struct TitleView: View {
    var isJustTitle: Bool

    let title: String
    
    var body: some View {
        HStack {
            
            Spacer()
            Text(title)
                .titlePage()
                
            Spacer()
        }
        .padding(.top, isJustTitle ? 15 : 0)
       
            
    }
}

struct SubTitleView: View {
    let title: String
    let backgroundColor: Color
    let size: Double
    var body: some View {
 
        ZStack {
            Rectangle()
                .frame(maxWidth: 340, maxHeight: 1)
                .foregroundStyle(LinearGradient.newTableBorder)
            Text(title)
                .subTitlePage(size: size)
                .padding(.horizontal)
                .background(backgroundColor)
                
        }
        .frame(maxHeight: 65)
        //.padding(.vertical)
        
    }
}

struct SubTitleView_Previews: PreviewProvider {
    static var previews: some View {
        SubTitleView(title: "465", backgroundColor: .red, size: 40)
    }
}

