import Foundation
import SwiftUI
import Combine

class GroupsViewModel: ObservableObject {
    @Published var groups: [TournamentGroup] = []
    
    init() {
        loadMockGroups()
    }
    
    private func loadMockGroups() {
        // A GRUBU (Normal Senaryo)
        let groupATeams = [
            TeamStats(name: "Kargıpınarı", played: 3, won: 2, drawn: 1, lost: 0, goalsFor: 6, goalsAgainst: 2, isDisqualified: false),
            TeamStats(name: "Tömük", played: 3, won: 1, drawn: 2, lost: 0, goalsFor: 4, goalsAgainst: 3, isDisqualified: false),
            TeamStats(name: "Kocahasanlı", played: 3, won: 1, drawn: 0, lost: 2, goalsFor: 3, goalsAgainst: 5, isDisqualified: false),
            TeamStats(name: "Limonlu", played: 3, won: 0, drawn: 1, lost: 2, goalsFor: 1, goalsAgainst: 4, isDisqualified: false)
        ]
        
        let groupAMatches = [
            Match(homeTeam: "Kargıpınarı", awayTeam: "Tömük", homeScore: 1, awayScore: 1, date: Date(), isCompleted: true),
            Match(homeTeam: "Kocahasanlı", awayTeam: "Limonlu", homeScore: 2, awayScore: 0, date: Date(), isCompleted: true)
        ]
        
        // B GRUBU (Diskalifiye Senaryosu)
        let groupBTeams = [
            TeamStats(name: "Çeşmeli", played: 3, won: 3, drawn: 0, lost: 0, goalsFor: 8, goalsAgainst: 1, isDisqualified: false),
            TeamStats(name: "Kızkalesi", played: 3, won: 2, drawn: 0, lost: 1, goalsFor: 5, goalsAgainst: 4, isDisqualified: false),
            TeamStats(name: "Türbe", played: 3, won: 1, drawn: 0, lost: 2, goalsFor: 2, goalsAgainst: 6, isDisqualified: false),
            // Kural ihlali yapan takım örneği:
            TeamStats(name: "Alata", played: 3, won: 0, drawn: 0, lost: 3, goalsFor: 0, goalsAgainst: 4, isDisqualified: true)
        ]
        
        let groupBMatches = [
            Match(homeTeam: "Çeşmeli", awayTeam: "Kızkalesi", homeScore: 3, awayScore: 1, date: Date(), isCompleted: true)
        ]
        
        self.groups = [
            TournamentGroup(name: "A Grubu", teams: groupATeams.sorted(by: { $0.points > $1.points }), recentMatches: groupAMatches),
            TournamentGroup(name: "B Grubu", teams: groupBTeams.sorted(by: { $0.points > $1.points }), recentMatches: groupBMatches)
        ]
    }
}
