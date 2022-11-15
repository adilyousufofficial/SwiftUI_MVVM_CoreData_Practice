//
//  SearchView.swift
//  FirstSwiftUIApp
//
//  Created by **** on 26/08/2022.
//

import SwiftUI

struct SearchView: View {
    
    @Binding var searchTerm: String
    
    var body: some View {
        
        HStack {
            Spacer()
            Image(systemName: "magnifyingglass")
            
            TextField("Search", text: self.$searchTerm).foregroundColor(Color.primary)
                .edgesIgnoringSafeArea(Edge.Set([.leading,.trailing,.top]))
                .frame(width: UIScreen.main.bounds.width-90, alignment: .center)
                .padding(10)
            
            Spacer()
        }.foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10)
            .padding(10)
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(searchTerm: .constant("sho"))
    }
}
