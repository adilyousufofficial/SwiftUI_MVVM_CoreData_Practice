//
//  HomeViewModel.swift
//  PaybackCodeChallange
//
//  Created by **** on 26/08/2022.
//

import SwiftUI
import CoreData

struct HomeViewModel { 
    
    let tiles: TileValues
    
    var name: CellType {
        return self.tiles.name
    }
    
    var headline: String {
        return self.tiles.headline
    }
    
    var subline: String {
        guard self.tiles.subline != nil else {
            return ""
        }
        return self.tiles.subline!
    }
    
    var data: String {
        guard self.tiles.data != nil else {
            return ""
        }
        return self.tiles.data!
    }
    
    var score: Int {
        return self.tiles.score
    }
}
