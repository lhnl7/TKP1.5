import SwiftUI
import AVKit

struct VideoPlayerFullView: View {
    let urlString: String
    @StateObject private var vm = VideoPlayerViewModel()

    var body: some View {
        ZStack {
            Color.black
            if let player = vm.player {
                VideoPlayer(player: player)
                    .ignoresSafeArea()
                    .onAppear { vm.playIfNeeded() }
                    .onDisappear { vm.pause() }
                    .gesture(LongPressGesture(minimumDuration: 0.25).onEnded { _ in vm.togglePause() })
            } else {
                ProgressView()
                    .onAppear { vm.prepare(urlString: urlString) }
            }
        }
    }
}

class VideoPlayerViewModel: ObservableObject {
    @Published var player: AVPlayer?
    private var isPrepared = false

    func prepare(urlString: String) {
        guard !isPrepared else { return }
        isPrepared = true
        Task {
            if let local = await VideoCacheManager.shared.localURL(for: urlString) {
                await MainActor.run {
                    self.player = AVPlayer(url: local)
                    self.player?.play()
                }
            } else if let url = URL(string: urlString) {
                let item = AVPlayerItem(url: url)
                await MainActor.run {
                    self.player = AVPlayer(playerItem: item)
                    self.player?.play()
                }
                Task { await VideoCacheManager.shared.cache(url: url) }
            }
        }
    }

    func playIfNeeded() { player?.play() }
    func pause() { player?.pause() }
    func togglePause() {
        if player?.timeControlStatus == .playing { pause() } else { playIfNeeded() }
    }
}
