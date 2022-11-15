//
//  SecondaryTextView.swift
//  FirstSwiftUIApp
//
//  Created by **** on 30/08/2022.
//

import SwiftUI

struct SecondaryTextView: View {
    @State var subline: String
    var body: some View {
        VStack {
            Text(subline)
                .font(.custom("Arial",size: 18))
                .fontWeight(.semibold)
                .foregroundColor(Color.gray)
                .padding([.leading,.trailing],20)
                .frame(width: UIScreen.main.bounds.width, alignment: .leading)
        }
    }
}

struct SecondaryTextView_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryTextView(subline: "sfsafs")
    }
}
