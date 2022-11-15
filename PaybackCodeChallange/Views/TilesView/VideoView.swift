//
//  VideoView.swift
//  FirstSwiftUIApp
//
//  Created by **** on 30/08/2022.
//

import SwiftUI
import AVKit

struct VideoView: View {
    @State private var player : AVPlayer?
    @State var videoUrl: String
    var body: some View {
        VStack {
            VideoPlayer(player: player)
                .onSubmit({
                    player?.play()
                })
                .onAppear() {
                    guard let url = URL(string: videoUrl) else {
                        return
                    }
                    print(url)
                    let player = AVPlayer(url: url)
                    self.player = player
                    self.player?.seek(to: CMTime.zero)
                    // self.player!.play()
                }
                .onDisappear() {
                    player?.pause()
                }
                .frame(width: UIScreen.main.bounds.width - 20, height: (UIScreen.main.bounds.width-20)*(9.0/16.0), alignment: .center)
            Spacer()
        }
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView(videoUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d5/Tim_Cook_2009_cropped.jpg/220px-Tim_Cook_2009_cropped.jpg")
    }
}
