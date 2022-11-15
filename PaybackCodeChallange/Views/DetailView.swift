//
//  DetailView.swift
//  FirstSwiftUIApp
//
//  Created by **** on 25/08/2022.
//

import SwiftUI
import WebKit

struct DetailView: View {
    
    @State var tilesType: TileValues
    
    var body: some View {
        VStack {
            if tilesType.name == CellType.image {
                ImageView(imageUrl: tilesType.data!)
                    .navigationTitle(tilesType.headline)
            }
            else if tilesType.name == CellType.video {
                VideoView(videoUrl: tilesType.data!)
                    .navigationTitle(tilesType.headline)
            }
            else if tilesType.name == CellType.website {
                VStack {
                    WebView(url: self.tilesType.data!)
                        .navigationTitle(tilesType.headline)
                }
            }
            else if tilesType.name == CellType.shopping_list {
                ShoppingListView(fullPageHeight: true)
                    .navigationTitle(tilesType.headline)
            }
            
            if tilesType.subline != "" {
                SecondaryTextView(subline: tilesType.subline ?? "")
            }
            Spacer()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(tilesType: TileValues(name: CellType.shopping_list, headline: "", subline: "", data: "", score: 0))
        }
    }
}
