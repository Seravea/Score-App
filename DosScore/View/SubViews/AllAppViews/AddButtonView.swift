//
//  AddButtonView.swift
//  DosScore
//
//  Created by Romain Poyard on 02/05/2023.
//

import SwiftUI

struct AddButtonView: View {
    
    let buttonLabel: String
    
    var body: some View {
        VStack(alignment: .center) {
           Image(systemName: "plus")
                .foregroundColor(.textColor)
                .padding()
                .overlay(content: {
                    Circle()
                        .stroke(Color("textColor"), lineWidth: 1.5)
                })
                //.matchedGeometryEffect(id: "firstPlus", in: namespace)
            Text(buttonLabel)
                .font(.custom("Poppins-Regular", size: 15))
                .padding(.horizontal, 75)
                
        }
        .padding(.vertical, 25)
        .tint(.textColor)
        
    }
}

struct AddButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddButtonView(buttonLabel: "Test")
    }
}
