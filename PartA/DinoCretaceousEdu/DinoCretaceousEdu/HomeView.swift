import SwiftUI

struct HomeView: View {
    @EnvironmentObject var gameState: GameState

    var body: some View {
        VStack(spacing: 24) {
            Text("Cretaceous Dino Explorer")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.top, 40)

            Text("Learn about the Cretaceous era while playing a fun dinosaur game!")
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            NavigationLink {
                GameContainerView()
            } label: {
                Text("Start Game")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.green.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.horizontal)

            NavigationLink {
                HighScoresView()
            } label: {
                Text("View High Scores")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.orange.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.horizontal)

            NavigationLink {
                LearnView()
            } label: {
                Text("Learn About the Cretaceous")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.blue.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.horizontal)

            NavigationLink {
                SettingsView()
            } label: {
                Text("Settings")
                    .font(.subheadline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.gray.opacity(0.2))
                    .foregroundColor(.primary)
                    .cornerRadius(12)
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding(.bottom, 20)
    }
}
