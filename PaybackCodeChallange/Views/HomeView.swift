//
//  HomeView.swift
//  PaybackCodeChallange
//
//  Created by **** on 25/08/2022.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject private var homeListVM = HomeListViewModel()
    
    init() {
        homeListVM.load()
    }
    
    var body: some View {
        
        var filteredStocks = homeListVM.searchTerm.isEmpty ? homeListVM.tiles : homeListVM.tiles.filter { $0.headline.lowercased().starts(with: homeListVM.searchTerm.lowercased() ) }
        filteredStocks.sort { $0.score > $1.score }
        
        return  VStack(alignment: .leading) {
            SearchView(searchTerm: self.$homeListVM.searchTerm)
            
            HomeListView(tiles: filteredStocks)
                .navigationTitle("Payback")
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
        }
    }
}
