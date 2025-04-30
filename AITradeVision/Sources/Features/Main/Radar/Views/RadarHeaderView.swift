//
//  RadarHeaderView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 08/04/25.
//

import SwiftUI
import TradeVisionUI

struct RadarHeaderView: View {
    var body: some View {
        TradeVisionHStack(spacing: TradeVisionSpacing.sm) {
            TradeVisionImage(Image(.technicalRadar), type: .headerIcon)
            TradeVisionLabel("Technical Radar", type: .header)
        }
    }
}
