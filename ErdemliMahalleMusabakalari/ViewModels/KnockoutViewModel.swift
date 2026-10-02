import Foundation
import SwiftUI
import Combine

class KnockoutViewModel: ObservableObject {
    @Published var stages: [KnockoutStage] = []
    
    // Hangi aşamada olduğumuzu takip etmek için (Animasyonlu geçişler için lazım)
    @Published var selectedStageId: UUID?
    
    init() {
        loadMockKnockoutData()
    }
    
    private func loadMockKnockoutData() {
        let son16Matches = [
            Match(homeTeam: "Kargıpınarı", awayTeam: "Kızkalesi", homeScore: 2, awayScore: 1, date: Date(), isCompleted: true),
            Match(homeTeam: "Çeşmeli", awayTeam: "Tömük", homeScore: 3, awayScore: 0, date: Date(), isCompleted: true),
            Match(homeTeam: "Arpaçbahşiş", awayTeam: "Limonlu", homeScore: nil, awayScore: nil, date: Date(), isCompleted: false),
            Match(homeTeam: "Elvanlı", awayTeam: "Kocahasanlı", homeScore: nil, awayScore: nil, date: Date(), isCompleted: false)
        ]
        
        let ceyrekFinalMatches = [
            Match(homeTeam: "Kargıpınarı", awayTeam: "Çeşmeli", homeScore: nil, awayScore: nil, date: Date(), isCompleted: false),
            Match(homeTeam: "Bilinmiyor", awayTeam: "Bilinmiyor", homeScore: nil, awayScore: nil, date: Date(), isCompleted: false)
        ]
        
        let yariFinalMatches = [
            Match(homeTeam: "Bilinmiyor", awayTeam: "Bilinmiyor", homeScore: nil, awayScore: nil, date: Date(), isCompleted: false)
        ]
        
        let finalMatch = [
            Match(homeTeam: "Bilinmiyor", awayTeam: "Bilinmiyor", homeScore: nil, awayScore: nil, date: Date(), isCompleted: false)
        ]
        
        self.stages = [
            KnockoutStage(stageName: "Son 16", matches: son16Matches),
            KnockoutStage(stageName: "Çeyrek Final", matches: ceyrekFinalMatches),
            KnockoutStage(stageName: "Yarı Final", matches: yariFinalMatches),
            KnockoutStage(stageName: "Final", matches: finalMatch)
        ]
        
        // İlk açılışta ilk aşamayı seçili yapıyoruz
        self.selectedStageId = self.stages.first?.id
    }
}
