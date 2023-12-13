//
//  CardCellView.swift
//  DosScore
//
//  Created by Romain Poyard on 24/01/2023.
//

import SwiftUI

struct CardCellView: View {
    
    let frameCardWidth: Double
    let frameCardHeight: Double
    let card: Card
   
    var body: some View {
       
        Image(card.image)
            .resizable()
            .scaledToFill()
            .frame(width: frameCardWidth, height: frameCardHeight)
    
           
            
    }
}

struct CardCellView_Previews: PreviewProvider {
    static var previews: some View {
        CardCellView(frameCardWidth: 121, frameCardHeight: 210, card: Card.cardNine)
    }
}
