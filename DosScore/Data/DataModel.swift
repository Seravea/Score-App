//
//  DataModel.swift
//  DosScore
//
//  Created by Romain Poyard on 24/01/2023.
//

import Foundation
import SwiftUI


struct Card: Identifiable, Equatable {
    var id: UUID = UUID()
    var number: Int
    var score: Int
    var image: String
    
}

extension Card {
    static let cardZero = Card(number: 0, score: 0, image: "card0")
    static let cardOne = Card(number: 1, score: 1, image: "card1")
    static let cardTwo = Card(number: 2, score: 2, image: "card2")
    static let cardThree = Card(number: 3, score: 3, image: "card3")
    static let cardFour = Card(number: 4, score: 4, image: "card4")
    static let cardFive = Card(number: 5, score: 5, image: "card5")
    static let cardSix = Card(number: 6, score: 6, image: "card6")
    static let cardSeven = Card(number: 7, score: 7, image: "card7")
    static let cardEight = Card(number: 8, score: 8, image: "card8")
    static let cardNine = Card(number: 9, score: 9, image: "card9")
    static let cardStop = Card(number: 20, score: 20, image: "cardStop")
    static let cardChangeDirection = Card(number: 20, score: 20, image: "cardChangeDirection")
    static let cardPlusFour = Card(number: 40, score: 40, image: "cardPlusFour")
    static let cardPlusTwo = Card(number: 20, score: 20, image: "cardPlusTwo")
    static let cardChangeColor = Card(number: 20, score: 20, image: "cardChangeColor")
    
    
    static let allNumberCards: [Card] = [cardZero, cardOne, cardTwo, cardThree, cardFour, cardFive, cardSix, cardSeven, cardEight, cardNine]
    static let allSpecialCards: [Card] = [cardChangeDirection, cardStop, cardPlusTwo, cardChangeColor, cardPlusFour]
}

class CardsViewModel: ObservableObject {
    @Published var selectedCard: [Card] = []
    @Published var scoreToAdd: Int = 0
    
    func countScore() {
        
        for card in selectedCard {
            self.scoreToAdd += card.score
        }
    }
}


struct Trophy: Identifiable, Comparable, Codable {
    static func <(lhs: Trophy, rhs: Trophy) -> Bool {
            return lhs.trophyTitle < rhs.trophyTitle
        }
    
    
    var id: UUID = UUID()
    var trophyImage: String
    var trophyTitle: String
    var trophyDescription: String
    var isWon: Bool = false
    
}

extension Trophy {
    static let remontada: Trophy = Trophy(trophyImage: "remontada", trophyTitle: "La remontada", trophyDescription: "Tu es passé du dernier au premier")
    static let tumble: Trophy = Trophy(trophyImage: "tumble", trophyTitle: "La dégringolade", trophyDescription: "Tu es passé du premier au dernier")
    static let miser: Trophy = Trophy(trophyImage: "miserImage", trophyTitle: "L'avare", trophyDescription: "Il n'a jamais suffisamment de cartes. Le conservateur.")
   // static let lucky: Trophy = Trophy(trophyImage: "", trophyTitle: "Chanceux", trophyDescription: "Je ne sais pas")
    static let invisible: Trophy = Trophy(trophyImage: "invisible", trophyTitle: "L'invisible", trophyDescription: "En moyenne tu n'est pas bon... mais pas mauvais non plus")
    static let participate: Trophy = Trophy(trophyImage: "participate", trophyTitle: "L'important c'est de participer", trophyDescription: "Tout est dans le titre")
    static let godFather: Trophy = Trophy(trophyImage: "godfather", trophyTitle: "Le Parrain", trophyDescription: "Tu as tout miser, pour gagner")
    static let jackpot: Trophy = Trophy(trophyImage: "jackpot", trophyTitle: "777", trophyDescription: "Bravo tu as gagné le jackpot ! (Dommage ! Ce n'est pas un jeu d'argent)")
    static let afterAll: Trophy = Trophy(trophyImage: "boss", trophyTitle: "Enfin", trophyDescription: "Tu en as mis du temps, 5 parties sans gagner ! mais cette fois-ci c'est toi le boss (pour l'instant)")
    static let theMule: Trophy = Trophy(trophyImage: "theMule", trophyTitle: "La Mule", trophyDescription: "Ton but c'est de stocker les cartes c'est ça ?!")
    static let messi: Trophy = Trophy(trophyImage: "messi", trophyTitle: "Le Messi", trophyDescription: "Laisse gagner les autres, sinon tu vas perdre tes amis")
    static let looser: Trophy = Trophy(trophyImage: "looser", trophyTitle: "Looser", trophyDescription: "T'es souvent dernier non ?")
//    static let neverTwoWitThreeWinner: Trophy = Trophy(trophyImage: "", trophyTitle: "Jamais deux sans trois", trophyDescription: "Bravo celon le dicton ça devrait s'arrêter ici")
    static let wheelWillTurn: Trophy = Trophy(trophyImage: "wheel", trophyTitle: "Jamais deux sans trois", trophyDescription: "J'éspère pour toi que la roue tourne va tourner")
    
    
    static let allTrophy = [remontada, tumble, miser, invisible, participate, godFather, jackpot, afterAll, theMule, messi, looser, wheelWillTurn]
    
    
}


func isGodfatherOnThisStep(selectedCard : [Card]) -> Bool {
    var counter: Int = 0
    
    for card in selectedCard {
        if card.score == 40 {
            counter += 1
        }
    }
    
    if counter >= 3 {
        return true
    } else {
        return false
    }
    
    
}

struct PlayerLadder: Identifiable, Codable, Equatable {
    
    var id: UUID
    var playerImage: String
    var playerName: String
    var numberOfGame: Int
    var playerCumulPoints: Int
    
    var averageScore: Int {
       return playerCumulPoints / numberOfGame
    }
    
}



//struct Player: Identifiable {
//    var id: UUID = UUID()
//    var name: String
//    var score: Int
//    var image: String?
//
//}

//struct Table: Identifiable {
//    var id: UUID = UUID()
//    var tableName: String
//   // var gamers: [Player]
//    var gamesNumber: Int
//    var creationDate: Date
//}


//extension Player {
//    static let player1 = Player(name: "Romain", score: 18, image: nil)
//    static let player2 = Player(name: "Benjamin", score: 109, image: "profil2")
//    static let player3 = Player(name: "N'nady", score: 409, image: "profil3")
//
//}

//extension Table {
//    static let table1 = Table(tableName: "Les Moches", gamers: [Player.player1, Player.player2, Player.player3, Player.player2,Player.player1, Player.player2, Player.player3, Player.player2], gamesNumber: 18, creationDate: .now)
//
//    static let table2 = Table(tableName: "Coton Ouaté", gamers: [Player.player2,Player.player3, Player.player3, Player.player3, Player.player2], gamesNumber: 5, creationDate: .now)
//
//    static let table3 = Table(tableName: "Tramayes", gamers: [Player.player2,Player.player1, Player.player2], gamesNumber: 2, creationDate: .now)
//
//    static let table4 = Table(tableName: "Test NoPhoto", gamers: [Player.player1, Player.player1, Player.player1], gamesNumber: 25, creationDate: .now)
//}
