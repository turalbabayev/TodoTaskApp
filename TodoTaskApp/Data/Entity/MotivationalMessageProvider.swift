//
//  MotivationMessage.swift
//  TodoTaskApp
//
//  Created by Tural Babayev on 11.10.2024.
//

import Foundation

class MotivationalMessageProvider {
    // Mesajları burada tanımlıyoruz
    private let motivationalMessages = [
        "Harika gidiyorsun! 💪",
        "Biraz daha çaba, başarı yakında! 🚀",
        "Görevinle ilgili önemli bir not ekleyebilirsin.",
        "Başarmaya bir adım daha yaklaştın!",
        "Zihin molası ver! ☕️",
        "Hedefine yaklaşıyorsun!",
        "Kendini ödüllendirmeyi unutma!"
    ]
    
    // Rastgele bir mesaj döndüren fonksiyon
    func getRandomMessage() -> String {
        return motivationalMessages.randomElement() ?? "Harika bir gün!"
    }
}
