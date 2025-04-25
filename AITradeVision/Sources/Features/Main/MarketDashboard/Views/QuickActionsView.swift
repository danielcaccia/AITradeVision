//
//  QuickActionsView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 08/04/25.
//

import SwiftUI
import TradeVisionUI

struct QuickActionsView: View {
    @EnvironmentObject var coordinator: MainCoordinator
    
    var body: some View {
        TradeVisionVStack(spacing: TradeVisionSpacing.md) {
            TradeVisionHStack(spacing: TradeVisionSpacing.md) {
                ActionButton(title: "Dividends", icon: Image(.dividendCalendar), action: { coordinator.route = .nextDividends })
                ActionButton(title: "IPOs", icon: Image(.ipoCalendar), action: { coordinator.route = .nextIPOs })
            }
            
            TradeVisionHStack(spacing: TradeVisionSpacing.md) {
                ActionButton(title: "Radar", icon: Image(systemName: "scope"), action: { coordinator.route = .technicalRadar })
                ActionButton(title: "AI Picks", icon: Image(.AI), action: { coordinator.route = .aiPicks })
            }
        }
    }

    struct ActionButton: View {
        let title: String
        let icon: Image
        let action: () -> Void

        var body: some View {
            TradeVisionLabelWithIcon(
                title,
                type: .subtitle,
                iconImage: icon,
                position: .top
            )
            .lineLimit(1)
            .minimumScaleFactor(0.7)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .tradeVisionCard()
            .contentShape(Rectangle())
            .onTapGesture {
                action()
            }
        }
    }
}
