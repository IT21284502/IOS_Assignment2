import Foundation
import CoreML

final class DifficultyPredictor {
    
    // NOTE:
    // Later, when you have a real ML model (e.g. DinoDifficulty.mlmodel),
    // you can create it here and call it inside predictDifficulty(...)
    //
    // private let model = DinoDifficulty()
    
    /// Predict a difficulty value between 1 and 3.
    /// This is currently rule-based to simulate ML behaviour.
    func predictDifficulty(score: Int,
                           lives: Int,
                           orbsCollected: Int,
                           hazardHits: Int,
                           elapsedTime: TimeInterval,
                           baseDifficulty: Double) -> Double? {
        
        var difficulty = baseDifficulty
        
        // If player is doing very well (high score, many orbs, few hits) → increase difficulty
        if score > 100 && hazardHits == 0 && orbsCollected > 5 {
            difficulty += 0.5
        }
        
        // If player is struggling (lots of hits, low score) → decrease difficulty
        if hazardHits >= 3 && score < 80 {
            difficulty -= 0.5
        }
        
        // If they survive a long time with good performance → slowly ramp up
        if elapsedTime > 60 && score > 150 {
            difficulty += 0.5
        }
        
        // If lives are very low → maybe gently reduce difficulty
        if lives == 1 {
            difficulty -= 0.25
        }
        
        // Clamp between 1 and 3
        difficulty = max(1.0, min(3.0, difficulty))
        
        return difficulty
    }
}
