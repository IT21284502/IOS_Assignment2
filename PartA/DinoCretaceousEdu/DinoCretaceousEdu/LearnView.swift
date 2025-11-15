import SwiftUI

struct LearnView: View {
    @EnvironmentObject var gameState: GameState

    var body: some View {
        List {
            Section("About the Cretaceous Era") {
                Text("The Cretaceous period was the last period of the Mesozoic era, lasting from about 145 to 66 million years ago. It ended with a mass extinction event that wiped out most non-avian dinosaurs and many marine species.")
                    .fixedSize(horizontal: false, vertical: true)
            }

            Section("Dinosaur & Era Facts") {
                ForEach(gameState.facts, id: \.self) { fact in
                    Text("• \(fact)")
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
        .navigationTitle("Learn")
    }
}
