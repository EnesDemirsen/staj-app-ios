import SwiftUI

struct StatsView: View {
    @StateObject private var viewModel = StatsViewModel()
    
    // 0: Gol Krallığı, 1: Asist Krallığı
    @State private var selectedStatTab = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                // ÜST KISIM: SEKME SEÇİCİ (Picker)
                Picker("İstatistik Tipi", selection: $selectedStatTab) {
                    Text("Gol Krallığı").tag(0)
                    Text("Asist Krallığı").tag(1)
                }
                .pickerStyle(.segmented)
                .padding()
                
                // ALT KISIM: İLK 10 LİSTESİ
                ScrollView {
                    VStack(spacing: 12) {
                        // Hangi sekme seçiliyse o listeyi getiriyoruz
                        let currentList = selectedStatTab == 0 ? viewModel.top10GoalScorers : viewModel.top10AssistProviders
                        
                        // Array.enumerated() ile hem oyuncuyu hem de kaçıncı sırada (index) olduğunu alıyoruz
                        ForEach(Array(currentList.enumerated()), id: \.element.id) { index, player in
                            StatRowView(index: index, player: player, isGoalTab: selectedStatTab == 0)
                        }
                    }
                    .padding(.horizontal)
                }
                Spacer()
            }
            .navigationTitle("İstatistikler")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.systemGray6))
        }
    }
}

// ---------------------------------------------------------
// ALT BİLEŞEN: TEK BİR OYUNCU SATIRININ TASARIMI
// ---------------------------------------------------------
struct StatRowView: View {
    let index: Int
    let player: PlayerStat
    let isGoalTab: Bool // Gol mü yoksa asist sekmesinde miyiz?
    
    var body: some View {
        HStack {
            // 1. SIRA NUMARASI VE MADALYA KARESI
            Text("\(index + 1)")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(medalTextColor(for: index))
                .frame(width: 35, height: 35)
                .background(medalBackgroundColor(for: index))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            // 2. OYUNCU ADI VE TAKIMI
            VStack(alignment: .leading, spacing: 4) {
                Text(player.name)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Text(player.team)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.leading, 5)
            
            Spacer()
            
            // 3. İSTATİSTİK SKORU (Gol veya Asist sayısı)
            VStack {
                Text(isGoalTab ? "\(player.goals)" : "\(player.assists)")
                    .font(.title3)
                    .fontWeight(.heavy)
                    .foregroundColor(isGoalTab ? .cyan : .green)
                
                Text(isGoalTab ? "Gol" : "Asist")
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.05), radius: 3, y: 2)
    }
    
    // --- TASARIM YARDIMCI FONKSİYONLARI ---
    
    // İlk 3 sıranın arka plan rengini belirler (Altın, Gümüş, Bronz)
    private func medalBackgroundColor(for index: Int) -> Color {
        switch index {
        case 0: return Color.yellow.opacity(0.2)
        case 1: return Color.gray.opacity(0.2)
        case 2: return Color.orange.opacity(0.2)
        default: return Color(.systemGray5)
        }
    }
    
    // İlk 3 sıranın yazı rengini belirler
    private func medalTextColor(for index: Int) -> Color {
        switch index {
        case 0: return Color.orange 
        case 1: return Color(white: 0.1)
        case 2: return Color.brown
        default: return Color.gray
        }
    }
}

#Preview{
    StatsView()
}
