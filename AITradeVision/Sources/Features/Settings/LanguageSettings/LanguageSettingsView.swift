//
//  LanguageSettingsView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 07/04/25.
//

import SwiftUI

struct LanguageSettingsView: View {
    @EnvironmentObject var coordinator: SettingsCoordinator
    
    var body: some View {
        VStack {
            Text("🌍 Idioma")
                .font(.title)
            
            Text("Funcionalidade em construção.")
                .foregroundColor(.gray)
            
            Spacer()
            
            Button("Voltar") {
                coordinator.route = .settings
            }
        }
        .padding()
    }
}

//struct LanguageSettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        LanguageSettingsView()
//    }
//}
