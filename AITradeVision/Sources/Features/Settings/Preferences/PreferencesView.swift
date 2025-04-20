//
//  PreferencesView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 07/04/25.
//

import SwiftUI
import TradeVisionUI

struct PreferencesView: View {
    @AppStorage("SELECTED_THEME") private var selectedTheme: TradeVisionColorScheme = .system

    @EnvironmentObject var coordinator: SettingsCoordinator
    
    public var body: some View {
            Form {
                Section(header: Text("Aparência")) {
                    Picker("Tema", selection: $selectedTheme) {
                        ForEach(TradeVisionColorScheme.allCases) { scheme in
                            Text(scheme.displayName).tag(scheme)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Button("Voltar") {
                    coordinator.route = .settings
                }
            }
            .navigationTitle("Configurações")
        }
}

//struct PreferencesView_Previews: PreviewProvider {
//    static var previews: some View {
//        PreferencesView()
//    }
//}
