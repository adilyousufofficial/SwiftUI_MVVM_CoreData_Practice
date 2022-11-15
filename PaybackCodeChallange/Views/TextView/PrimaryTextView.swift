//
//  PrimaryTextView.swift
//  FirstSwiftUIApp
//
//  Created by **** on 30/08/2022.
//

import SwiftUI

struct PrimaryTextView: View {
    @State var headline: String
    var body: some View {
        VStack {
            Text(headline)
                .font(.custom("Arial",size: 22))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top,10)
                .padding([.leading,.trailing],20)
                .frame(width: UIScreen.main.bounds.width, alignment: .leading)
        }
    }
}

struct PrimaryTextView_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryTextView(headline: "headline")
    }
}
