import Foundation
import Combine
import SwiftUI

// 1. OYUNCU MODELİ
struct PlayerStat: Identifiable {
    var id = UUID()
    var name: String
    var team: String
    var goals: Int
    var assists: Int
}

// 2. VIEW MODEL
class StatsViewModel: ObservableObject {
    @Published var players: [PlayerStat] = []
    
    init() {
        loadMockData()
    }
    
    private func loadMockData() {
        self.players = [
            PlayerStat(name: "Ali Yılmaz", team: "Kargıpınarı", goals: 8, assists: 2),
            PlayerStat(name: "Mehmet Demir", team: "Tömük", goals: 5, assists: 6),
            PlayerStat(name: "Ahmet Çelik", team: "Çeşmeli", goals: 7, assists: 1),
            PlayerStat(name: "Caner Aydın", team: "Kocahasanlı", goals: 4, assists: 3),
            PlayerStat(name: "Burak Kılıç", team: "Limonlu", goals: 3, assists: 5),
            PlayerStat(name: "Okan Şahin", team: "Arpaçbahşiş", goals: 6, assists: 0),
            PlayerStat(name: "Emre Can", team: "Kızkalesi", goals: 2, assists: 4),
            PlayerStat(name: "Hakan Koç", team: "Türbe", goals: 1, assists: 7),
            PlayerStat(name: "Serkan Yıldız", team: "Elvanlı", goals: 9, assists: 2),
            PlayerStat(name: "Murat Taş", team: "Kumkuyu", goals: 4, assists: 4),
            PlayerStat(name: "Yasin Kurt", team: "Erdemli Merkez", goals: 2, assists: 1),
            PlayerStat(name: "Taha Aslan", team: "Koyuncu", goals: 5, assists: 3)
        ]
    }
    
    // Sadece Golleri büyükten küçüğe sıralayıp İLK 10'u alır
    var top10GoalScorers: [PlayerStat] {
        Array(players.sorted { $0.goals > $1.goals }.prefix(10))
    }
    
    // Sadece Asistleri büyükten küçüğe sıralayıp İLK 10'u alır
    var top10AssistProviders: [PlayerStat] {
        Array(players.sorted { $0.assists > $1.assists }.prefix(10))
    }
}
