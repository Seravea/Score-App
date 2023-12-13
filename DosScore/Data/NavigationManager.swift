//
//  NavigationManager.swift
//  DosScore
//
//  Created by Romain Poyard on 05/10/2023.
//

import Foundation
import SwiftUI

enum NavPath {
    case navToSelectGame, navToFirstPlayerSelection, navToGame, navToLadder, navToTrophys
}


class NavigationManager: ObservableObject {
    @Published var selectionPath: [NavPath] = []
    
    func popToRoot() {
        selectionPath.removeAll()
    }
    
    func goBack() {
        selectionPath.removeLast()
    }
    
    
}
