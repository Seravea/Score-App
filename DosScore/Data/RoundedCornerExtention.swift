//
//  RoundedCornerExtention.swift
//  DosScore
//
//  Created by Romain Poyard on 02/03/2023.
//

import Foundation
import SwiftUI


struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    func myCardCellView(isBorderTakeAll: Bool, cornerRadius: Double) -> some View {
        self
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .foregroundColor(Color("tableBckg"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(LinearGradient(colors: [.white.opacity(0.12), isBorderTakeAll ? .white.opacity(0.12) : .clear], startPoint: .top, endPoint: .bottom), lineWidth: 1)
                    )
                
            )
//            .padding(.horizontal)
//            .padding(.vertical, 8)
    }
}



