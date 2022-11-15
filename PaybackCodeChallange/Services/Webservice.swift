//
//  Webservice.swift
//  PaybackCodeChallange
//
//  Created by **** on 26/08/2022.
//

import SwiftUI

class Webservice {
    func getDataFeed(completion: @escaping (([TileValues]?) -> Void)) {
        guard let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/payback-test.appspot.com/o/feed.json?alt=media&token=3b3606dd-1d09-4021-a013-a30e958ad930") else {
            fatalError("URL is not correct")
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            print("decoding...")
            
            if let result = try? JSONDecoder().decode(TileModel.self, from: data) {
                completion(result.tiles)
                return
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            
        }.resume()
    }
}
