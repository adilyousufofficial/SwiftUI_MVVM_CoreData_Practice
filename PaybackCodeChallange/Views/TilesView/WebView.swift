//
//  WebView.swift
//  FirstSwiftUIApp
//
//  Created by **** on 29/08/2022.
//

import SwiftUI
import WebKit

struct WebViewMethod : UIViewRepresentable {
    let requestURLString: String
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: requestURLString) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
}

struct WebView: View {
    @State var url: String
    var body: some View {
        VStack {
            WebViewMethod(requestURLString: url)
            Spacer()
        }
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(url: "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d5/Tim_Cook_2009_cropped.jpg/220px-Tim_Cook_2009_cropped.jpg")
    }
}
