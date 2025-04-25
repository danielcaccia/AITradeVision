//
//  RadarHeaderView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 08/04/25.
//

import SwiftUI
import TradeVisionUI

struct RadarHeaderView: View {
    let title: String
    
    var body: some View {
        TradeVisionHStack(spacing: TradeVisionSpacing.sm) {
            TradeVisionImage(Image(systemName: "scope"), type: .headerIcon)
            TradeVisionLabel(title, type: .header)
        }
    }
}
