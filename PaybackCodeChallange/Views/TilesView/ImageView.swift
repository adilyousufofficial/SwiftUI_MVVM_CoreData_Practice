//
//  ImageView.swift
//  FirstSwiftUIApp
//
//  Created by **** on 30/08/2022.
//

import SwiftUI

struct ImageView: View {
    @State var imageUrl: String
    var body: some View {
        VStack {
            HStack {
                Spacer()
                AsyncImage(url: URL(string: imageUrl), transaction: .init(animation: .spring(response: 1.6))) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .progressViewStyle(.circular)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    case .failure:
                        Text("Failed fetching image.")
                            .foregroundColor(.red)
                    @unknown default:
                        Text("Unknown error. Please try again.")
                            .foregroundColor(.red)
                    }
                }
                Spacer()
            }
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/37/IPhone_11_Pro_Max_Midnight_Green.svg/150px-IPhone_11_Pro_Max_Midnight_Green.svg.png")
    }
}
