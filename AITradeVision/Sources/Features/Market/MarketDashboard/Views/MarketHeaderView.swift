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
    let action: @MainActor () -> Void
    
    var body: some View {
        TradeVisionHStack {
            TradeVisionLabel(title, type: .header)
            
            Spacer()
            
            Button(action: action) {
                Image(systemName: "bell")
            }
            .buttonStyle(TradeVisionIconButtonStyle())
        }
        .padding(.horizontal)
    }
}
