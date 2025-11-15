import Foundation
import CoreData
import SwiftUI
import Combine

final class GameState: ObservableObject {
    // Game runtime state
    @Published var score: Int = 0
    @Published var lives: Int = 3
    
    /// User-selected baseline difficulty (1–3)
    @Published var baseDifficulty: Double = 1.0
    
    /// Current difficulty (can be adjusted by "CoreML" logic)
    @Published var currentDifficulty: Double = 1.0
    
    /// Stats for this session
    @Published var totalOrbsCollected: Int = 0
    @Published var totalHazardHits: Int = 0
    @Published var sessionStartTime: Date? = nil

    // Static educational facts – expanded list
    let facts: [String] = [
        "The Cretaceous period lasted from about 145 to 66 million years ago.",
        "The Cretaceous was the final period of the Mesozoic Era.",
        "Flowering plants (angiosperms) became common and diverse during the Cretaceous.",
        "Many famous dinosaurs like Triceratops, Tyrannosaurus rex, and Velociraptor lived in the late Cretaceous.",
        "During the Cretaceous, sea levels were higher and large shallow seas covered parts of continents.",
        "Some birds in the Cretaceous were already very similar to modern birds.",
        "Pterosaurs were flying reptiles that lived alongside dinosaurs but were not dinosaurs.",
        "The Cretaceous ended with a mass extinction event likely triggered by an asteroid impact near modern-day Yucatán.",
        "Ancient crocodilians and turtles survived the Cretaceous extinction and still exist today.",
        "Herbivorous dinosaurs like hadrosaurs dominated many Cretaceous ecosystems.",
        "The climate during much of the Cretaceous was warmer than today, with little or no polar ice.",
        "Early mammals also lived during the Cretaceous, but they were generally small and not dominant."
    ]

    func randomFact() -> String {
        facts.randomElement() ?? "The Cretaceous was the final period of the Mesozoic Era."
    }
    
    func currentSessionDuration() -> TimeInterval {
        guard let start = sessionStartTime else { return 0 }
        return Date().timeIntervalSince(start)
    }

    func resetGame() {
        score = 0
        lives = 3
        
        // Use the base difficulty chosen in Settings
        currentDifficulty = baseDifficulty
        
        totalOrbsCollected = 0
        totalHazardHits = 0
        sessionStartTime = Date()
    }

    // MARK: - Core Data: Save High Score

    func saveHighScore(context: NSManagedObjectContext) {
        guard score > 0 else { return }

        let highScore = HighScore(context: context)
        highScore.id = UUID()
        highScore.score = Int64(score)
        highScore.date = Date()
        
        // Store the user-selected base difficulty (1–3)
        highScore.difficulty = baseDifficulty

        do {
            try context.save()
            print("High score saved: \(score) at difficulty \(baseDifficulty)")
        } catch {
            print("Failed to save high score: \(error)")
        }
    }
}
