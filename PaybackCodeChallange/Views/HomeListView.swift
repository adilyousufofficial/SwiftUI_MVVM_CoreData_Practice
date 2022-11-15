//
//  HomeListView.swift
//  FirstSwiftUIApp
//
//  Created by **** on 26/08/2022.
//

import SwiftUI

struct HomeListView: View {
    
    let tiles: [HomeViewModel]
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(self.tiles, id: \.headline) { tile in
                    VStack (alignment: .leading) {
                        Divider()
                        NavigationLink(destination: DetailView(tilesType: tile.tiles)) {
                            PrimaryTextView(headline: tile.headline)
                        }
                        if tile.name == CellType.image {
                            
                            NavigationLink(destination: DetailView(tilesType: tile.tiles)) {
                                HStack {
                                    ImageView(imageUrl: tile.data)
                                        .padding(.vertical)
                                }
                                .frame(width: UIScreen.main.bounds.width-20, height: 250, alignment: .center)
                            }
                        } else if tile.name == CellType.video {
                            HStack {
                                VideoView(videoUrl: tile.data)
                            }
                            .frame(width: UIScreen.main.bounds.width-20, alignment: .center)
                            .padding([.horizontal,.bottom], 10)
                        }
                        else if tile.name == CellType.website {
                            WebView(url: tile.data)
                                .frame(width: UIScreen.main.bounds.width-20, height: 250, alignment: .center)
                                .padding(.horizontal, 10)
                        } else if tile.name == CellType.shopping_list {
                            ShoppingListView(fullPageHeight: false)
                        }
                        NavigationLink(destination: DetailView(tilesType: tile.tiles)) {
                            
                            HStack {
                                if tile.subline != "" {
                                    SecondaryTextView(subline: tile.subline)
                                        .frame(width: UIScreen.main.bounds.width-53, alignment: .leading)
                                }
                                Spacer()
                                Image(systemName: "chevron.forward")
                                    .foregroundColor(.gray)
                                    .padding(.trailing,20)
                            }
                            .padding(.bottom,10)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }
}

struct HomeListView_Previews: PreviewProvider {
    static var previews: some View {
        let tile = TileValues(name: CellType.image, headline: "Shopping List", subline: "Shop", data: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/37/IPhone_11_Pro_Max_Midnight_Green.svg/150px-IPhone_11_Pro_Max_Midnight_Green.svg.png", score: 1)
        HomeListView(tiles: [HomeViewModel(tiles: tile)])
    }
}
