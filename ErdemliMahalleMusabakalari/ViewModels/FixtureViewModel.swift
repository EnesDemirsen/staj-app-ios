import Foundation
import SwiftUI
import Combine

class FixtureViewModel: ObservableObject {
    // Arayüzü güncelleyecek değişkenler
    @Published var selectedYear: Int = 2026
    @Published var selectedDate: Date = Date()
    @Published var matches: [Match] = []
    
    // Sabit veriler
    let availableYears = [2024, 2025, 2026]
    var horizontalDates: [Date] = []
    
    init() {
        setupHorizontalDates()
        fetchMatchesForSelectedDate()
    }
    
    // Yatay tarih bandı için son 3 ve gelecek 3 günü oluşturur
    private func setupHorizontalDates() {
        let today = Date()
        var dates: [Date] = []
        
        for i in -3...3 {
            if let date = Calendar.current.date(byAdding: .day, value: i, to: today) {
                dates.append(date)
            }
        }
        self.horizontalDates = dates
    }
    
    // Tarih veya yıl değiştiğinde bu fonksiyon tetiklenecek
        func fetchMatchesForSelectedDate() {
            let calendar = Calendar.current
            let day = calendar.component(.day, from: selectedDate)
            
            // 1. Durum: Eğer seçili tarih BUGÜN ise
            if calendar.isDateInToday(selectedDate) {
                self.matches = [
                    Match(homeTeam: "Karahıdırlı", awayTeam: "Kocahasanlı", homeScore: 2, awayScore: 1, date: selectedDate, isCompleted: true),
                    Match(homeTeam: "Tömük", awayTeam: "Limonlu", homeScore: nil, awayScore: nil, date: calendar.date(bySettingHour: 18, minute: 0, second: 0, of: selectedDate) ?? selectedDate, isCompleted: false)
                ]
            }
            // 2. Durum: Ayın çift günler
            else if day % 2 == 0 {
                self.matches = [
                    Match(homeTeam: "Çeşmeli", awayTeam: "Kızkalesi", homeScore: nil, awayScore: nil, date: calendar.date(bySettingHour: 19, minute: 30, second: 0, of: selectedDate) ?? selectedDate, isCompleted: false),
                    Match(homeTeam: "Türbe", awayTeam: "Alata", homeScore: nil, awayScore: nil, date: calendar.date(bySettingHour: 21, minute: 0, second: 0, of: selectedDate) ?? selectedDate, isCompleted: false)
                ]
            }
            // 3. Durum: Ayın tek günleri 
            else {
                self.matches = [
                    Match(homeTeam: "Arpaçbahşiş", awayTeam: "Kumkuyu", homeScore: 3, awayScore: 0, date: selectedDate, isCompleted: true),
                    Match(homeTeam: "Elvanlı", awayTeam: "Ayaş", homeScore: 1, awayScore: 1, date: selectedDate, isCompleted: true),
                    Match(homeTeam: "Erdemli Merkez", awayTeam: "Koyuncu", homeScore: nil, awayScore: nil, date: calendar.date(bySettingHour: 20, minute: 0, second: 0, of: selectedDate) ?? selectedDate, isCompleted: false)
                ]
            }
        }
    
    // Yıl değiştirme aksiyonu
    func changeYear(to year: Int) {
        self.selectedYear = year
        // Yeni yıla göre verileri çek
        fetchMatchesForSelectedDate()
    }
    
    // Gün değiştirme aksiyonu
    func changeDate(to date: Date) {
        self.selectedDate = date
        // Yeni güne göre maçları çek
        fetchMatchesForSelectedDate()
    }
}
