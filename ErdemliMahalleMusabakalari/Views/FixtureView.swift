import SwiftUI
import Foundation
import Combine

struct FixtureView: View {
    @StateObject private var viewModel = FixtureViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // YATAY TARİH SEÇİCİ
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(viewModel.horizontalDates, id: \.self) { date in
                            DateCellView(date: date, isSelected: Calendar.current.isDate(date, inSameDayAs: viewModel.selectedDate))
                                .onTapGesture {
                                    withAnimation { viewModel.changeDate(to: date) }
                                }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                }
                .background(Color(.systemGray6))
                
                // MAÇ LİSTESİ
                ScrollView {
                    VStack(spacing: 15) {
                        if viewModel.matches.isEmpty {
                            Text("Bu tarihte maç bulunmamaktadır.")
                                .foregroundColor(.gray)
                                .padding(.top, 50)
                        } else {
                            ForEach(viewModel.matches) { match in
                                MatchCardView(match: match)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Fikstür")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        ForEach(viewModel.availableYears, id: \.self) { year in
                            Button("\(year) Turnuvası") { viewModel.changeYear(to: year) }
                        }
                    } label: {
                        HStack {
                            Text("\(String(viewModel.selectedYear))").fontWeight(.bold)
                            Image(systemName: "calendar.badge.clock")
                        }
                        .foregroundColor(.cyan)
                    }
                }
            }
        }
    }
}

// YATAY TARİH HÜCRESİ
struct DateCellView: View {
    let date: Date
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 5) {
            Text(dayOfWeek(from: date))
                .font(.caption)
                .foregroundColor(isSelected ? .white : .gray)
            
            Text(dayOfMonth(from: date))
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(isSelected ? .white : .primary)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 15)
        .background(isSelected ? Color.cyan : Color.clear)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    func dayOfWeek(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        formatter.locale = Locale(identifier: "tr_TR")
        return formatter.string(from: date).uppercased()
    }
    
    func dayOfMonth(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        formatter.locale = Locale(identifier: "tr_TR")
        return formatter.string(from: date)
    }
}

// MAÇ KARTI
struct MatchCardView: View {
    var match: Match
    
    var body: some View {
        HStack {
            Text(match.homeTeam)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .trailing)
            
            VStack {
                if let hScore = match.homeScore, let aScore = match.awayScore {
                    Text("\(hScore) - \(aScore)").font(.title2).fontWeight(.black)
                } else {
                    Text("-").font(.title2).fontWeight(.black)
                }
                Text(match.matchStatus).font(.caption).foregroundColor(.gray)
            }
            .frame(width: 80)
            
            Text(match.awayTeam)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}



