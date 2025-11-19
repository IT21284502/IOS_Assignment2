import SwiftUI

struct PlayerView: View {
    @ObservedObject var audio: AudioManager
    let startIndex: Int

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 40) {

            // Top bar with Back button
            HStack {
                Button("← Back") {
                    dismiss()
                }
                .font(.title2)
                .padding()

                Spacer()
            }

            Spacer()

            // Song name
            Text(audio.songs[audio.currentIndex])
                .font(.largeTitle)
                .padding(.bottom, 20)

            // Progress bar
            ProgressView(value: audio.progress)
                .frame(width: 600)
                .padding(.bottom, 20)

            // Controls
            HStack(spacing: 50) {
                Button("⏮ Prev") {
                    audio.previous()
                }
                .font(.title2)

                Button(audio.isPlaying ? "⏸ Pause" : "▶️ Play") {
                    audio.playPause()
                }
                .font(.title2)

                Button("⏭ Next") {
                    audio.next()
                }
                .font(.title2)
            }

            // Repeat toggle
            Button(audio.repeatOn ? "🔁 Repeat: ON" : "🔁 Repeat: OFF") {
                audio.repeatOn.toggle()
            }
            .font(.title2)
            .padding(.top, 20)

            Spacer()
        }
        .onAppear {
            audio.selectSong(at: startIndex)
        }
    }
}
