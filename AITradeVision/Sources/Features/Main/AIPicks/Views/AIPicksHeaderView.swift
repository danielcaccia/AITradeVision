//
//  AIPicksHeaderView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 08/04/25.
//

import SwiftUI
import TradeVisionUI

struct AIPicksHeaderView: View {
    let title: String
    
    var body: some View {
        TradeVisionHStack(spacing: TradeVisionSpacing.sm) {
            TradeVisionImage(Image(.aiPicks), type: .headerIcon)
            TradeVisionLabel(title, type: .header)
        }
    }
}
