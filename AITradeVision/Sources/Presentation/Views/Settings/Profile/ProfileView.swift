//
//  ProfileView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 06/04/25.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject private var viewModel: ProfileViewModel
    
    @EnvironmentObject var coordinator: SettingsCoordinator

    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
        }
    }
}
