//
//  MarketHeaderView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 08/04/25.
//

import SwiftUI
import TradeVisionUI

struct MarketHeaderView: View {
    let title: String
    
    var body: some View {
        TradeVisionHStack(spacing: TradeVisionSpacing.sm) {
            TradeVisionImage(Image(.marketDashboardIcon), type: .headerIcon)
            TradeVisionLabel(title, type: .header)
//            Spacer()
//            
//            Button(action: action) {
//                Image(systemName: "bell")
//            }
//            .buttonStyle(TradeVisionIconButtonStyle())
        }
    }
}
