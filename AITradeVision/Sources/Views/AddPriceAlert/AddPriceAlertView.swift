//
//  AddPriceAlertView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 05/04/25.
//

import SwiftUI

struct AddPriceAlertView: View {
    @StateObject private var viewModel = AddPriceAlertViewModel()
    
    @ObservedObject var manager = PriceAlertManager()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            Form {
                TextField("Símbolo (ex: AAPL)", text: $viewModel.symbol)
                    .autocapitalization(.allCharacters)

                TextField("Preço alvo", text: $viewModel.targetPrice)
                    .keyboardType(.decimalPad)

                Picker("Condição", selection: $viewModel.isGreaterThan) {
                    Text("Acima de").tag(true)
                    Text("Abaixo de").tag(false)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .navigationTitle("Novo Alerta")
            .alert("Verifique os dados", isPresented: $viewModel.showError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Símbolo e preço devem estar preenchidos corretamente.")
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salvar") {
                        if viewModel.createAlert(manager: manager) {
                            dismiss()
                        }
                    }
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
