import SwiftUI

struct GroupsView: View {
    @StateObject private var viewModel = GroupsViewModel()
    // Sayfanın sağ üstündeki menü (Grup Aşaması / Elemeler)
    @State private var selectedStage: String = "Gruplar"
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(viewModel.groups) { group in
                            GroupAccordionCard(group: group)
                        }
                    }
                    .padding()
                }
                Spacer()
            }
            .navigationTitle("Grup Aşaması")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.systemGray6))
        }
    }
}
    
    
    // AKORDEON KART TASARIMI 
    struct GroupAccordionCard: View {
        let group: TournamentGroup
        @State private var isExpanded: Bool = false
        
        var body: some View {
            VStack(spacing: 0) {
                DisclosureGroup(isExpanded: $isExpanded) {
                    VStack(spacing: 15) {
                        Divider().padding(.top, 5)
                        
                        // 1. Puan Durumu Tablosu
                        GroupTableView(teams: group.teams)
                        
                        // 2. FIFA Tarzı Grup İçi Maç Skorları
                        if !group.recentMatches.isEmpty {
                            Divider()
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Grup Maçları")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 10) {
                                        ForEach(group.recentMatches) { match in
                                            MiniMatchCard(match: match)
                                        }
                                    }
                                }
                            }
                            .padding(.top, 5)
                        }
                    }
                    .padding(.bottom, 10)
                } label: {
                    Text(group.name)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.vertical, 8)
                }
                .tint(.cyan) // Ok işaretinin rengi
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 5)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
        }
    }
    
    // PUAN DURUMU TABLOSU
    struct GroupTableView: View {
        let teams: [TeamStats]
        
        var body: some View {
            VStack(spacing: 10) {
                // Tablo Başlıkları
                HStack {
                    Text("Takım").frame(maxWidth: .infinity, alignment: .leading)
                    Group {
                        Text("O").frame(width: 20)
                        Text("G").frame(width: 20)
                        Text("B").frame(width: 20)
                        Text("M").frame(width: 20)
                        Text("AG").frame(width: 22)
                        Text("YG").frame(width: 22)
                        Text("AV").frame(width: 22)
                        Text("P").frame(width: 25).fontWeight(.bold)
                    }
                    .font(.caption2)
                    .foregroundColor(.gray)
                }
                
                // Takım Satırları
                ForEach(Array(teams.enumerated()), id: \.element.id) { index, team in
                    HStack {
                        // Takım Adı ve Diskalifiye Kontrolü
                        HStack(spacing: 5) {
                            Text("\(index + 1).")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .frame(width: 15, alignment: .leading)
                            
                            if team.isDisqualified {
                                Image(systemName: "xmark.octagon.fill")
                                    .foregroundColor(.red)
                                    .font(.caption2)
                                Text(team.name)
                                    .strikethrough() // Üstünü çizme efekti
                                    .foregroundColor(.red.opacity(0.7))
                                    .lineLimit(1)
                            } else {
                                Text(team.name)
                                    .fontWeight(index < 2 ? .semibold : .regular) // İlk 2 takım kalın yazsın
                                    .lineLimit(1)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // İstatistikler (Ekrana sığması için sabit genişlikler verdik)
                        Group {
                            Text("\(team.played)").frame(width: 20)
                            Text("\(team.won)").frame(width: 20)
                            Text("\(team.drawn)").frame(width: 20)
                            Text("\(team.lost)").frame(width: 20)
                            Text("\(team.goalsFor)").frame(width: 22)
                            Text("\(team.goalsAgainst)").frame(width: 22)
                            Text("\(team.goalDifference)").frame(width: 22)
                            Text("\(team.points)").frame(width: 25).fontWeight(.bold)
                        }
                        .font(.caption)
                        .foregroundColor(team.isDisqualified ? .gray : .primary)
                    }
                }
            }
        }
    }
    
    // FİFA TARZI KÜÇÜK MAÇ KARTI
    struct MiniMatchCard: View {
        let match: Match
        
        var body: some View {
            VStack(spacing: 4) {
                HStack(spacing: 5) {
                    Text(match.homeTeam.prefix(4) + ".") // İsimleri kısaltıyoruz (Örn: Karg.)
                        .font(.caption2)
                        .frame(width: 40, alignment: .trailing)
                    
                    Text("\(match.homeScore ?? 0) - \(match.awayScore ?? 0)")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color.cyan)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    
                    Text(match.awayTeam.prefix(4) + ".")
                        .font(.caption2)
                        .frame(width: 40, alignment: .leading)
                }
            }
            .padding(8)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }

#Preview{
    GroupsView()
}
