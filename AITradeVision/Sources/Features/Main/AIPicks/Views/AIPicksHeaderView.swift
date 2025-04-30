//
//  AIPicksHeaderView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 08/04/25.
//

import SwiftUI
import TradeVisionUI

struct AIPicksHeaderView: View {
    var body: some View {
        TradeVisionHStack(spacing: TradeVisionSpacing.sm) {
            TradeVisionImage(Image(.aiPicks), type: .headerIcon)
            TradeVisionLabel("AI Picks", type: .header)
        }
    }
}
