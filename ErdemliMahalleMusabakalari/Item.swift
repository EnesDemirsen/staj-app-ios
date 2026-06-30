//
//  Item.swift
//  ErdemliMahalleMusabakalari
//
//  Created by ENES DEMİRŞEN on 30.06.2026.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
