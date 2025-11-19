import SwiftUI

struct PlaylistView: View {
    @StateObject var audio = AudioManager()

    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                Text("Playlist")
                    .font(.largeTitle)

                ForEach(audio.songs.indices, id: \.self) { i in
                    NavigationLink {
                        PlayerView(audio: audio, startIndex: i)
                    } label: {
                        Text(audio.songs[i])
                            .font(.title2)
                            .padding()
                            .frame(maxWidth: 600)
                            .background(.gray.opacity(0.3))
                            .cornerRadius(12)
                    }
                    .buttonStyle(.borderless) // lets tvOS focus nicely
                }

                Spacer()
            }
            .padding(.top, 60)
        }
    }
}
