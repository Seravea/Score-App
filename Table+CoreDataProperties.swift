//
//  Table+CoreDataProperties.swift
//  DosScore
//
//  Created by Romain Poyard on 12/04/2023.
//
//
import SwiftUI
import Foundation
import CoreData




extension Table {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Table> {
        return NSFetchRequest<Table>(entityName: "Table")
    }

    @NSManaged public var inGameStep: Int64
    @NSManaged public var gameProperties: String?
    @NSManaged public var creationDate: Date?
    @NSManaged public var gamesNumber: Int64
    @NSManaged public var id: UUID?
    @NSManaged public var tableName: String?
    @NSManaged public var gamers: NSSet?
    
    public var unwrappedTableName: String {
        tableName ?? "No Name"
    }
    
    
    public var gamersArray: [Player] {
        let gamerSet = gamers as? Set<Player> ?? []
        
        return gamerSet.sorted {
            $0.gamerPosition < $1.gamerPosition
        }
    }
    var gameCategory: GameProperties {
        if self.gameProperties == "Le gagnant a 500 points" {
            return .winnerAsMaxPoints
        } else if self.gameProperties == "Le gagnant a le minimum de points" {
            return .winnerAsMinPoints
        } else {
            return .noProportieselected
        }
    }
    
}

// MARK: Generated accessors for gamers
extension Table {

    @objc(addGamersObject:)
    @NSManaged public func addToGamers(_ value: Player)

    @objc(removeGamersObject:)
    @NSManaged public func removeFromGamers(_ value: Player)

    @objc(addGamers:)
    @NSManaged public func addToGamers(_ values: NSSet)

    @objc(removeGamers:)
    @NSManaged public func removeFromGamers(_ values: NSSet)

}

extension Table : Identifiable {

}


enum GameProperties: String, CaseIterable {
    case noProportieselected = "Pas de style de jeu encore séléctionner"
    case winnerAsMaxPoints = "Le gagnant a 500 points"
    case winnerAsMinPoints = "Le gagnant a le minimum de points"
}
