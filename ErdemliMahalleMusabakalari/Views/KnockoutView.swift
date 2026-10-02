import SwiftUI

struct KnockoutView: View {
    @StateObject private var viewModel = KnockoutViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                // üst kısım aşama isimleri (Son 16, Çeyrek Final vs.)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(viewModel.stages) { stage in
                            Text(stage.stageName)
                                .font(.system(size: 16, weight: viewModel.selectedStageId == stage.id ? .bold : .medium))
                                .foregroundColor(viewModel.selectedStageId == stage.id ? .cyan : .gray)
                                .padding(.vertical, 10)
                                .onTapGesture {
                                    withAnimation(.easeInOut) {
                                        viewModel.selectedStageId = stage.id
                                    }
                                }
                        }
                    }
                    .padding(.horizontal)
                }
                .background(Color.white)
                .shadow(color: .black.opacity(0.05), radius: 3, y: 3)
                
                // alt kısım yatay kaydırılabilir (SWIPE) maç listeleri
                TabView(selection: $viewModel.selectedStageId) {
                    ForEach(viewModel.stages) { stage in
                        ScrollView {
                            VStack(spacing: 15) {
                                ForEach(stage.matches) { match in
                                    MatchCardView(match: match)
                                }
                            }
                            .padding()
                        }
                        .tag(stage.id as UUID?)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
            }
            .navigationTitle("Elemeler")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.systemGray6))
        }
    }
}

#Preview {
    KnockoutView()
}
