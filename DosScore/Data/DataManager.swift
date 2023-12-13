//
//  DataManager.swift
//  DosScore
//
//  Created by Romain Poyard on 11/04/2023.
//

import Foundation
import CoreData





struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }

    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Model")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

//class AppProfilViewModel: ObservableObject {
//    private let viewContext = PersistenceController.shared.viewContext
//
//    @Published var isConnected: Bool = false
//
//    init() {
//        fetchAppProfil()
//    }
//
//    func fetchAppProfil() {
//        let request = NSFetchRequest<AppProfil>(entityName: "AppProfil")
//
//        do {
//
//            let viewContext = try viewContext.fetch(request).count == 0 ? false : try viewContext.fetch(request)[0].isConnected
//
//
//                isConnected = viewContext
//
//
//        }catch {
//            print("DEBUG: Some error occured while fetching")
//        }
//    }
//
//    func getConnected() {
//        let appProfil = AppProfil(context: viewContext)
//        appProfil.isConnected = true
//
//
//        save()
//        fetchAppProfil()
//    }
//
//    func disconect() {
//
//        viewContext.delete(AppProfil(context: viewContext))
//
//        save()
//        fetchAppProfil()
//    }
//
//    func deleteAll(appProfil: AppProfil) {
//
//        viewContext.delete(appProfil)
//        save()
//        fetchAppProfil()
//    }
//
//    func save() {
//        do {
//            try viewContext.save()
//        }catch {
//            print("Error saving")
//        }
//    }
//
//}




class PlayerViewModel: ObservableObject {
    private let viewContext = PersistenceController.shared.viewContext
    @Published var playersArray: [Player] = []
    
    
    
    
    var winningPlayer: [Player] = []
  
    
    let table: Table // (NSManagedObject)

    
    init(table: Table) {
        self.table = table
        
    }
    
    func fetchPlayers() {
        
        playersArray = table.gamersArray
    }
    
    
    func addPlayer(playerName: String, imageName: String) {
        let player = Player(context: viewContext)
        player.id = UUID()
        player.name = playerName
        player.gamerPosition = Int64(calculGamerPosition())
        player.id = UUID()
        player.imageString = imageName
        player.stepsWon = 0
        player.stepsLoose = 0
        
        
        table.addToGamers(player)
        save()
        fetchPlayers()
    }
    
    func addLoosingPointToPlayer(EndGamePlayers: [Player]) {
        EndGamePlayers.last?.gamesLoose += Int64(1)
        
        save()
        fetchPlayers()
    }
    
    func addWinningPointToPlayer(EndGamePlayers: [Player]) {
        EndGamePlayers.first?.gamesWon += Int64(1)
        
        save()
        fetchPlayers()
    }
    
    func addCardsInGame(player: Player, numberOfCards: Int) {
        
        if numberOfCards >= 5 {
            player.numberOfCardsInGame += Int64(numberOfCards)
        }
        
        save()
        fetchPlayers()
    }
    
    
    func addLooseStep() {
        if table.gameCategory == .winnerAsMinPoints {
            var playersLoose: [Player] = []
            let minScore = playersArray.map { $0.score }.min()
            playersLoose = playersArray.filter { $0.score == minScore }
            
            for player in playersLoose {
                player.stepsLoose += 1
            }
        }else {
            var playersLoose: [Player] = []
            let minScore = playersArray.map { $0.score }.max()
            playersLoose = playersArray.filter { $0.score == minScore }
            
            for player in playersLoose {
                player.stepsLoose += 1
            }
        }
        
    }
    func isGameIsEnding() -> Bool {
        
            let endPlayers = self.playersArray.sorted(by: {$0.score < $1.score })
            
            
            if endPlayers.last!.score > Int64(500) {
                return true
            }else {
                return false
            }
        
         
    }
    
    func addWonStep() {
        if table.gameCategory == .winnerAsMaxPoints {
            var playersWon: [Player] = []
            let maxScore = playersArray.map { $0.score }.max()
            playersWon = playersArray.filter { $0.score == maxScore }
            
            for player in playersWon {
                player.stepsWon += 1
            }
        }else {
            var playersWon: [Player] = []
            let maxScore = playersArray.map { $0.score }.min()
            playersWon = playersArray.filter { $0.score == maxScore }
            
            for player in playersWon {
                player.stepsWon += 1
            }
        }
    }
    
    func addPoints(index: Int, cardsArray: [Card], playerViewModel: PlayerViewModel) {
        var pointsToAdd: Int = 0
        for card in cardsArray {
            pointsToAdd += card.score
        }
        
        playerViewModel.playersArray[index].score += Int64(pointsToAdd)
        
        
        save()
        fetchPlayers()
    }
    
    
    func removePlayer(playerToRemove: Player) {
        let player = Player(context: viewContext)
        
        table.removeFromGamers(player)
        save()
        fetchPlayers()
    }
    
    
    func addPlayerImage(player: Player, imageName: String) {
        let player = Player(context: viewContext)
        
        player.imageString = imageName
        save()
        fetchPlayers()
    }
    
    
    func changePlayerName(player: Player, newName: String) {
        player.name = newName
        
        save()
        fetchPlayers()
    }
    
    func changePlayerImage(player: Player, newImageName: String) {
        player.imageString = newImageName
        
        save()
        fetchPlayers()
    }
    
    
    func save() {
        do {
            try viewContext.save()
        }catch {
            print("Error saving")
        }
    }
    
    
    func calculGamerPosition() -> Int {
        return self.table.gamersArray.count
    }
    
    
    
    
}



@MainActor
final class TableViewModel: ObservableObject {
    
    private let viewContext = PersistenceController.shared.viewContext
        @Published var tableArray: [Table] = []
        @Published var isAddingPlayer: Bool = false
        @Published var imagesArray: [String] = ["profilImage2", "profilImage3", "profilImage4", "profilImage5", "profilImage6", "profilImage7", "profilImage8", "profilImage9", "profilImage10", "profilImage11"]
    @Published var playerAndTrophyDic: [Player : Trophy] = [ : ]
    init() {
            fetchTableData()
        }
     
    func fetchTableData() {
        let request = NSFetchRequest<Table>(entityName: "Table")
        
        do {
            tableArray = try viewContext.fetch(request).sorted(by: {
                $0.creationDate! > $1.creationDate!
            })
            
        }catch {
            print("DEBUG: Some error occured while fetching")
        }
    }
    
    
    func addGamingStep(table: Table, playerViewModel: PlayerViewModel, playerIndex: Int) {
        if playerIndex == playerViewModel.playersArray.count - 1 {
            table.inGameStep += 1
            
            save()
            fetchTableData()
            
        }
    }
    
    
    func changeTableMode(mode: String, table: Table) {
       
        table.gameProperties = mode
        
        save()
        self.fetchTableData()
    }
    
    
    func addDataToCoreData(tableName: String) {
            let table = Table(context: viewContext)
            table.id = UUID()
            table.tableName = tableName
            table.creationDate = .now
            table.inGameStep = Int64(0)
           // table.gamesNumber = Int64(0)
            
            save()
            self.fetchTableData()
        }
    
    
    func deleteTable(table: Table) {
        viewContext.delete(table)
        
        do{
            try viewContext.save()
            
            
        }catch{
            print(error)
        }
        self.fetchTableData()
    }
    
    
        func save() {
            
            do {
                try viewContext.save()
            }catch {
                print("Error saving")
            }
        }
    
    
    func canAddTable(tableName: String, gamers: [Player]) -> Bool {
        let firstAnswer = gamers.count >= 2 ? true : false
        let secondAnswer = tableName.count > 2 ? true : false
        
        if firstAnswer && secondAnswer {
            return true
        }else {
            return false
        }
    }
    
    
    func changeTableName(table: Table, newTableName: String) {
       
        table.tableName = newTableName
        save()
        self.fetchTableData()
    }
    
    func addGamesNumber(table: Table){
        table.gamesNumber += 1
        
        save()
        fetchTableData()
    }
    
    func deleteTrophys() {
        let savedTrophys: [Trophy] = []
        
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(savedTrophys) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "TrophysWon")
        }
        
    }
    
    func saveWonTrophys(){
        var trophysWon: [Trophy] = []
        var savedTrophys: [Trophy] = []
        
        if let savedTrophysData = UserDefaults.standard.object(forKey: "TrophysWon") as? Data {
            let decoder = JSONDecoder()
            if let loadedPerson = try? decoder.decode([Trophy].self, from: savedTrophysData) {
               savedTrophys = loadedPerson
            }
        }
        
        trophysWon = playerAndTrophyDic.values.map { trophy in
           return trophy
        }
        
        
        
        for trophy in trophysWon {
            if savedTrophys.contains(trophy) == false {
                savedTrophys.append(trophy)
            }
        }
    
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(savedTrophys) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "TrophysWon")
        }
        
    }
    
    func restartScoreToZero(table: Table) {
        
        for player in table.gamersArray {
            player.score = 0
        }
        
        table.inGameStep = 0
        
        save()
        fetchTableData()
    }
    
    func addTrophysEndGame(endGamePlayers: [Player], table: Table){
        
        let winner = endGamePlayers.first!
        let looser = endGamePlayers.last!
        let sortedPlayers = endGamePlayers
        var winningTrophys: [Player : Trophy] = [:]
        
        var maxCards: Int64 {
            var maximumCardsInGame: Int64 = 0
            
            if let maxCards = endGamePlayers.map({ $0.numberOfCardsInGame }).max() {
               maximumCardsInGame = maxCards
            }
            
            return maximumCardsInGame
        }
        
        
        if sortedPlayers[0].stepsLoose >= Int(60 * sortedPlayers[0].table!.inGameStep / 100) {
            winningTrophys.updateValue(Trophy.remontada, forKey: sortedPlayers[0])
        }
        
        if sortedPlayers[sortedPlayers.count - 1].stepsWon >= Int(60 * sortedPlayers[0].table!.inGameStep / 100) {
            winningTrophys.updateValue(Trophy.tumble, forKey: sortedPlayers[sortedPlayers.count - 1])
        }
        
        
        
        for player in sortedPlayers {
            print(player.numberOfCardsInGame, "cards in game")
            
            
            if !trophyIsAlreadyInTheDic(trophy: Trophy.miser) && player.numberOfCardsInGame >= 40 {
                playerAndTrophyDic.updateValue(Trophy.miser, forKey: player)
                player.numberOfCardsInGame = 0
                save()
                fetchTableData()
            }
            
    //        if sortedPlayers[0].table!.gamesNumber > 3 && player.gamesLoose > 2  {
    //            winningTrophys.updateValue(Trophy.participate, forKey: player)
    //        }
            
            if !trophyIsAlreadyInTheDic(trophy: Trophy.invisible) && player.stepsWon == 4 && player.stepsLoose == 4 && (player != winner && player != looser){
                playerAndTrophyDic.updateValue(Trophy.invisible, forKey: player)
            }
            
            if !trophyIsAlreadyInTheDic(trophy: Trophy.participate) && player.gamesLoose == 6 && player == looser {
                playerAndTrophyDic.updateValue(Trophy.participate, forKey: player)
            }
            
            if !trophyIsAlreadyInTheDic(trophy: Trophy.messi) && player.gamesWon == 6 && player == winner {
                playerAndTrophyDic.updateValue(Trophy.messi, forKey: player)
            }
            
            if !trophyIsAlreadyInTheDic(trophy: Trophy.looser) && player.stepsLoose >= 10 && player == looser {
                playerAndTrophyDic.updateValue(Trophy.looser, forKey: player)
            }
            
            if !trophyIsAlreadyInTheDic(trophy: Trophy.wheelWillTurn) && player.gamesLoose == 5 && player == looser {
                playerAndTrophyDic.updateValue(Trophy.wheelWillTurn, forKey: player)
            }
            
            if !trophyIsAlreadyInTheDic(trophy: Trophy.theMule) && player.numberOfCardsInGame >= 30 {
                playerAndTrophyDic.updateValue(Trophy.theMule, forKey: player)
                player.numberOfCardsInGame = 0
                save()
            }
            
            if !trophyIsAlreadyInTheDic(trophy: Trophy.afterAll) && player.gamesLoose == 5 && player == winner {
                playerAndTrophyDic.updateValue(Trophy.afterAll, forKey: player)
            }
            
            if !trophyIsAlreadyInTheDic(trophy: Trophy.tumble) && player.gamesWon >= 5 && player == looser {
                playerAndTrophyDic.updateValue(Trophy.tumble, forKey: player)
            }
            
            if !trophyIsAlreadyInTheDic(trophy: Trophy.remontada) && player.stepsLoose >= 5 && player == winner {
                playerAndTrophyDic.updateValue(Trophy.remontada, forKey: player)
            }
            
        }
        
    }
    
    func trophyIsAlreadyInTheDic(trophy: Trophy) -> Bool {
            
        var trophyIsIn: Bool = true
        
        for dic in playerAndTrophyDic {
            if dic.value  == trophy {
                trophyIsIn = true
                break
            } else {
                trophyIsIn = false
            }
        }
        
        return trophyIsIn
    }
    
    
}


extension Collection {
    func newIndices(moving source: IndexSet, to destination: Int) -> [Int: Int] {
        var oldIndexesByNewIndex: [Int] = Array(0..<self.count)
        oldIndexesByNewIndex.move(fromOffsets: source, toOffset: destination)
        return Dictionary(uniqueKeysWithValues:
                            oldIndexesByNewIndex.enumerated().map{ newIndex, oldIndex in (oldIndex, newIndex) }
        )
    }
    
}


func writeAnS(numberSupToOne: Int) -> String {
    if numberSupToOne > 1 {
        return "s"
    }else {
        return ""
    }
}


class LadderViewModel: ObservableObject {
    
    @Published var players: [PlayerLadder] = [].sorted {$0.playerCumulPoints < $1.playerCumulPoints}
    
    func savePlayers(playersToSave: [Player]) {
        
        var playersWon: [PlayerLadder] {
            playersToSave.map { player in
                return PlayerLadder(id: player.id ?? UUID(), playerImage: player.unwrappedImage, playerName: player.unwrappedName, numberOfGame: 1, playerCumulPoints: Int(player.score))
            }
           
        }
        var savedPlayers: [PlayerLadder] = []
    
        
    
        if let savedPlayersData = UserDefaults.standard.object(forKey: "PlayersLadder") as? Data {
            let decoder = JSONDecoder()
            if let loadedPlayers = try? decoder.decode([PlayerLadder].self, from: savedPlayersData) {
                
                savedPlayers = loadedPlayers
                
            }else {
                print("error when fetch saved PlayersLadder")
            }
        }
        
        for player in playersWon {
            if savedPlayers.contains(where: {$0.id == player.id}) == false {
                savedPlayers.append(player)
            } else {
                if let foundPlayerOffset = savedPlayers.firstIndex(of: player) {
                    savedPlayers[foundPlayerOffset].playerCumulPoints = player.playerCumulPoints
                    savedPlayers[foundPlayerOffset].numberOfGame += 1
                }
            }
            
            
//            if savedPlayers.contains(where: { savedPlayer in
//                if savedPlayer.id == player.id {
//                    print("contains \(player.playerName)")
//                    return true
//                }else {
//                    print("DON'T CONTAINS \(player.playerName)")
//                    return false
//                }
//            }) {
//                savedPlayers.append(player)
//                print("the player: \(player.playerName) is saved")
//
//            }else {
//                savedPlayers[savedPlayers.firstIndex(of: player)!].playerCumulPoints += player.playerCumulPoints
//                print(savedPlayers.isEmpty ? "savedPlayers is Empty" : "\(savedPlayers[0].playerName) est déjà sauvegardé")
//            }
        }
        
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(savedPlayers) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "PlayersLadder")
            players = savedPlayers.sorted {
                $0.playerCumulPoints < $1.playerCumulPoints
            }
        }else {
            print("error when saving PlayersLadder")
        }
    
        
    }
    
    
    func fetchPlayers() {
        var returnPlayers: [PlayerLadder] = []
        
        if let savedPlayersData = UserDefaults.standard.object(forKey: "PlayersLadder") as? Data {
            
            let decoder = JSONDecoder()
            
            if let loadedPlayers = try? decoder.decode([PlayerLadder].self, from: savedPlayersData) {
                returnPlayers = loadedPlayers
            }
        }
        print(players.isEmpty ? "pas de joueurs sauvegardés" : players[0].playerName)
        players = returnPlayers.sorted {$0.playerCumulPoints < $1.playerCumulPoints}
        
    }
    
    
}
