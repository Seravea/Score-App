//
//  Player+CoreDataProperties.swift
//  DosScore
//
//  Created by Romain Poyard on 26/04/2023.
//
//

import Foundation
import CoreData
import SwiftUI

extension Player {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Player")
    }
    
    @NSManaged public var gamesWon: Int64
    @NSManaged public var gamesLoose: Int64
    @NSManaged public var numberOfCardsInGame: Int64
    @NSManaged public var stepsLoose: Int64
    @NSManaged public var stepsWon: Int64
    @NSManaged public var imageString: String?
    @NSManaged public var gamerPosition: Int64
    @NSManaged public var id: UUID?
    @NSManaged public var image: Data?
    @NSManaged public var name: String?
    @NSManaged public var score: Int64
    @NSManaged public var table: Table?
    

    public var unwrappedName: String {
        return name ?? ""
    }
   public var unwrappedImage: String {
        return imageString ?? ""
    }
    public var unwrappedUUID: UUID {
        return id ?? UUID()
    }
}

extension Player : Identifiable {

}
