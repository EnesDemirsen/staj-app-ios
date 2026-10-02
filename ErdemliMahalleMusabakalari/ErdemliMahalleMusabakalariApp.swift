//
//  ErdemliMahalleMusabakalariApp.swift
//  ErdemliMahalleMusabakalari
//
//  Created by ENES DEMİRŞEN on 30.06.2026.
//

import SwiftUI

@main // Uygulamanın buradan başlayacağını Xcode'a söyler (İşte _main hatasının çözümü)
struct ErdemliMahalleMusabakalariApp: App {
    var body: some Scene {
        WindowGroup {
            // Uygulama açıldığında ilk olarak bizim tasarladığımız dalgalı ekranı gösterecek
            WelcomeScreen()
        }
    }
}
