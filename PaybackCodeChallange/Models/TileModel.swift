//
//  TileModel.swift
//  PaybackCodeChallange
//
//  Created by **** on 26/08/2022.
//

import SwiftUI

struct TileModel: Decodable { //-> TileModel
    let tiles: [TileValues]
}

struct TileValues: Decodable {
    let name: CellType
    let headline: String
    let subline: String?
    let data: String?
    let score: Int
}

enum CellType: String, Decodable {
    case image = "image"
    case video = "video"
    case website = "website"
    case shopping_list = "shopping_list"
}
