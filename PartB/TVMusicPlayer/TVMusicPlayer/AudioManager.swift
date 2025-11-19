import Foundation
import AVFoundation
import Combine

class AudioManager: ObservableObject {
    @Published var songs = ["song1", "song2", "song3"]
    @Published var currentIndex = 0
    @Published var isPlaying = false
    @Published var progress: Double = 0
    @Published var repeatOn = false

    var player: AVAudioPlayer?
    var timer: Timer?

    func selectSong(at index: Int) {
        currentIndex = index
        playCurrent()
    }

    func playCurrent() {
        let name = songs[currentIndex]

        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            print("File not found: \(name)")
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
            isPlaying = true
            startProgressTimer()
        } catch {
            print("Error loading file: \(error)")
        }
    }

    func startProgressTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
            guard let player = self.player, player.duration > 0 else { return }

            self.progress = player.currentTime / player.duration

            if player.currentTime >= player.duration {
                if self.repeatOn {
                    self.playCurrent()
                } else {
                    self.next()
                }
            }
        }
    }

    func playPause() {
        if isPlaying {
            player?.pause()
            isPlaying = false
        } else {
            player?.play()
            isPlaying = true
        }
    }

    func next() {
        currentIndex = (currentIndex + 1) % songs.count
        playCurrent()
    }

    func previous() {
        currentIndex = (currentIndex - 1 + songs.count) % songs.count
        playCurrent()
    }
}
