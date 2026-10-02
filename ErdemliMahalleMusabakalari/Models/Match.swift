import Foundation

// İleride SwiftData için başına @Model eklenecek
struct Match: Identifiable {
    var id = UUID()
    var homeTeam: String
    var awayTeam: String
    var homeScore: Int?
    var awayScore: Int?
    var date: Date
    var isCompleted: Bool
    
    // Maçın durumunu string olarak döndüren küçük bir yardımcı (View'ı temiz tutmak için)
    var matchStatus: String {
        if isCompleted {
            return "MS"
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            return formatter.string(from: date)
        }
    }
}
