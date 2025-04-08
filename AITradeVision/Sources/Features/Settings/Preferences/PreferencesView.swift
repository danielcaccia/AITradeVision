//
//  PreferencesView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 07/04/25.
//

import SwiftUI

struct PreferencesView: View {
    @AppStorage("isDarkMode") var isDarkMode = false

    @EnvironmentObject var coordinator: SettingsCoordinator
    
    var body: some View {
        Form {
            Toggle("Modo Escuro", isOn: $isDarkMode)

            Button("Voltar") {
                coordinator.route = .settings
            }
        }
        .navigationTitle("Preferências")
    }
}

//struct PreferencesView_Previews: PreviewProvider {
//    static var previews: some View {
//        PreferencesView()
//    }
//}
