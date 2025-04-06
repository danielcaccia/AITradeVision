//
//  RouteSwitcher.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 06/04/25.
//

import SwiftUI

struct RouteSwitcher<Route: Equatable, Content: View>: View {
    @Binding var route: Route
    let content: (Route) -> Content

    var body: some View {
        content(route)
    }
}

