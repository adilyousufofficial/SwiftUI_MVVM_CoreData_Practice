//
//  HomeListViewModel.swift
//  PaybackCodeChallange
//
//  Created by **** on 26/08/2022.
//

import SwiftUI
import Foundation
import CoreData

class HomeListViewModel: ObservableObject {
    
    @Published var searchTerm: String = ""
    @Published var tiles: [HomeViewModel] = [HomeViewModel]()
    let persistentContainer = CoreDataManager.shared.persistentContainer
    
    func load() {
        RefreshManager.shared.loadDataIfNeeded { dayPassed in
            if (dayPassed) {
                fetchDataFeed()
            } else {
                self.tiles = retrieveDataFeed() ?? []
                print(self.tiles)
                print("today call done")
            }
        }
    }
    
    func fetchDataFeed() {
        Webservice().getDataFeed { tiles in
            if let tiles = tiles {
                DispatchQueue.main.async {
                    self.tiles = tiles.map(HomeViewModel.init)
                    if (self.deleteDataFeed()) {
                        self.saveDataFeed(self.tiles)
                    }
                }
            }
        }
    }
    
    func saveDataFeed(_ feeds: [HomeViewModel]) {
        for feed in feeds {
            let dataFeed = DataFeed(context: persistentContainer.viewContext)
            dataFeed.name = feed.name.rawValue
            dataFeed.headline = feed.headline
            dataFeed.subline = feed.subline
            dataFeed.data = feed.data
            dataFeed.score = NSDecimalNumber(value: feed.score)
        }
        do {
            try persistentContainer.viewContext.save()
            print("Success")
        } catch {
            print("Error saving: \(error)")
        }
    }
    
    func deleteDataFeed() -> Bool {
        let context = persistentContainer.viewContext
        let request: NSFetchRequest<DataFeed> = DataFeed.fetchRequest()
        do {
            let results = try context.fetch(request)
            if !results.isEmpty {
                for result in results as [NSManagedObject] {
                    context.delete(result)
                    return true
                }
            } else {
                return true
            }
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
    
    func retrieveDataFeed() -> [HomeViewModel]? {
        let request: NSFetchRequest<DataFeed> = DataFeed.fetchRequest()
        
        request.returnsObjectsAsFaults = false
        var retrievedUsers: [HomeViewModel] = []
        do {
            let results = try persistentContainer.viewContext.fetch(request)
            if !results.isEmpty {
                for result in results as [NSManagedObject] {
                    guard let name = result.value(forKey: "name") as? String else { return nil }
                    guard let headline = result.value(forKey: "headline") as? String else { return nil }
                    guard let subline = result.value(forKey: "subline") as? String else { return nil }
                    guard let data = result.value(forKey: "data") as? String else { return nil }
                    guard let score = result.value(forKey: "score") as? Int else { return nil }
                    
                    var tileType: CellType
                    switch name {
                    case "image":
                        tileType = CellType.image
                    case "video":
                        tileType = CellType.video
                    case "website":
                        tileType = CellType.website
                    case "shopping_list":
                        tileType = CellType.shopping_list
                    default:
                        tileType = CellType.shopping_list
                    }
                    
                    let tile = TileValues(name: tileType, headline: headline, subline: subline, data: data, score: score)
                    let feed = HomeViewModel(tiles: tile)
                    retrievedUsers.append(feed)
                }
            }
        } catch {
            print("Error retrieving: \(error)")
        }
        return retrievedUsers
    }
}

