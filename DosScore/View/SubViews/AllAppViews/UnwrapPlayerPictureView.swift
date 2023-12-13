//
//  UnwrapPlayerPictureView.swift
//  DosScore
//
//  Created by Romain Poyard on 07/04/2023.
//

import SwiftUI

struct UnwrapPlayerPictureView: View {
    @ObservedObject var player: Player
    var imageFrame: Double
    
    var paddingHorizontal: Double
    
    var body: some View {
       
            Image(player.unwrappedImage)
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: imageFrame, height: imageFrame)
                .padding(.horizontal, paddingHorizontal)
                
        
    }
}

struct UnwrapPlayerPictureView_Previews: PreviewProvider {
    static var previews: some View {
        UnwrapPlayerPictureView(player: TableViewModel().tableArray[0].gamersArray[0], imageFrame: 50, paddingHorizontal: 0)
    }
}
