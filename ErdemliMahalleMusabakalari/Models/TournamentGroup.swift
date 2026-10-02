import Foundation

// Takım İstatistikleri
struct TeamStats: Identifiable {
    var id = UUID()
    var name: String
    var played: Int    // O (Oynanan)
    var won: Int       // G (Galibiyet)
    var drawn: Int     // B (Beraberlik)
    var lost: Int      // M (Mağlubiyet)
    var goalsFor: Int  // AG (Atılan Gol)
    var goalsAgainst: Int // YG (Yenilen Gol)
    var isDisqualified: Bool // Diskalifiye durumu
    
    // Averaj ve Puanı otomatik hesaplıyoruz (İş yükünü azaltır)
    var goalDifference: Int { goalsFor - goalsAgainst }
    var points: Int { (won * 3) + drawn }
}

// Grup Yapısı
struct TournamentGroup: Identifiable {
    var id = UUID()
    var name: String // "A Grubu", "B Grubu" vb.
    var teams: [TeamStats]
    var recentMatches: [Match] // Önceki yazdığımız Match modelini kullanıyoruz
}

// Eleme Aşaması Modeli
struct KnockoutStage: Identifiable, Hashable {
    var id = UUID()
    var stageName: String // "Son 16", "Çeyrek Final" vb.
    var matches: [Match]  // Önceki Match modelimizi kullanıyoruz
    
    // Hashable protokolü için (TabView içinde kullanabilmek adına)
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func == (lhs: KnockoutStage, rhs: KnockoutStage) -> Bool {
        lhs.id == rhs.id
    }
}
