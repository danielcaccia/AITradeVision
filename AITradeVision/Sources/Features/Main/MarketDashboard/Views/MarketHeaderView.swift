//
//  MarketHeaderView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 08/04/25.
//

import SwiftUI
import TradeVisionUI

struct MarketHeaderView: View {
    var body: some View {
        TradeVisionHStack(spacing: TradeVisionSpacing.sm) {
            TradeVisionImage(Image(.marketDashboardIcon), type: .headerIcon)
            TradeVisionLabel("Market Dashboard", type: .header)
        }
    }
}
