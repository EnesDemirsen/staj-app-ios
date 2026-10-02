import SwiftUI

// 1. Dalga Şeklini Çizen Özel Yapı (Zemin)
struct DiagonalWave: Shape {
    var startY: CGFloat
    var endY: CGFloat
    var controlOffset: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Sol alt köşeden başla
        path.move(to: CGPoint(x: 0, y: rect.height))
        // Sol kenardan yukarı çık (Başlangıç Y noktası)
        path.addLine(to: CGPoint(x: 0, y: rect.height * startY))
        
        // Sağa doğru kavisli absürt dalgayı çiz
        path.addCurve(
            to: CGPoint(x: rect.width, y: rect.height * endY),
            control1: CGPoint(x: rect.width * 0.4, y: rect.height * startY + controlOffset),
            control2: CGPoint(x: rect.width * 0.6, y: rect.height * endY - controlOffset)
        )
        
        // Sağ alt köşeye in ve kapat
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.closeSubpath()
        
        return path
    }
}

struct WelcomeScreen: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // EN ALT KATMAN: BEYAZ (Ferahlık)
                Color.white.ignoresSafeArea()
                
                // ORTA KATMAN: MAVİ DALGA (Erdemli Denizi)
                // Sol üstten başlayıp sağ aşağı iniyor
                DiagonalWave(startY: 0.25, endY: 0.55, controlOffset: 150)
                    .fill(
                        LinearGradient(
                            colors: [Color.blue.opacity(0.8), Color.blue],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .ignoresSafeArea()
                
                // ÜST KATMAN: YEŞİL DALGA (Doğa/Narenciye)
                // Mavinin altından daha sert bir dalgayla geliyor
                DiagonalWave(startY: 0.55, endY: 0.85, controlOffset: 120)
                    .fill(
                        LinearGradient(
                            colors: [Color.green.opacity(0.8), Color.green.opacity(0.6)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .ignoresSafeArea()
                
                // İÇERİK KATMANI (Yazılar ve Butonlar)
                VStack(spacing: 0) {
                    
                    // Üst Kısım: Başlık
                    VStack(spacing: 12) {
                        Image(systemName: "sun.haze.fill") // Erdemli güneşi/denizi vibe'ı
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 70)
                            .foregroundColor(.orange)
                        
                        Text("Erdemli Mahalle\nMüsabakaları")
                            .font(.system(size: 32, weight: .black, design: .rounded))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black.opacity(0.8))
                    }
                    .padding(.top, 60)
                    
                    Spacer()
                    
                    // Alt Kısım: Butonlar
                    VStack(spacing: 25) {
                        // Ana Buton (Arkadaki maviden daha açık ve fresh bir mavi - Cyan)
                        NavigationLink(destination: SpectatorHomeView()) {
                            HStack {
                                Text("Turnuvayı Takip Et")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                Spacer()
                                Image(systemName: "arrow.right.circle.fill")
                                    .font(.title2)
                            }
                            .foregroundColor(.white)
                            .padding(.vertical, 18)
                            .padding(.horizontal, 24)
                            .background(Color.cyan) // Açık, fresh mavi
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            .shadow(color: .cyan.opacity(0.5), radius: 10, x: 0, y: 5)
                        }
                        .padding(.horizontal, 30)
                        
                        .padding(.bottom, 100)
                    }
                }
            }
        }
    }
}


#Preview {
    WelcomeScreen()
}
