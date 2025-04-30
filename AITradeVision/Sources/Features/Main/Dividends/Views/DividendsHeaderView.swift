//
//  DividendsHeaderView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 08/04/25.
//

import SwiftUI
import TradeVisionUI

struct DividendsHeaderView: View {
    var body: some View {
        TradeVisionHStack(spacing: TradeVisionSpacing.sm) {
            TradeVisionImage(Image(.nextDividends), type: .headerIcon)
            TradeVisionLabel("Next Dividends", type: .header)
        }
    }
}
