//
//  ContentView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 31/03/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("AITradeVision Dashboard")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()

                // Mocked market list
                List {
                    HStack {
                        Text("Ação: Apple Inc.")
                        Spacer()
                        Text("$150.00")
                            .foregroundColor(.green)
                    }
                    HStack {
                        Text("Ação: Tesla Inc.")
                        Spacer()
                        Text("$700.00")
                            .foregroundColor(.red)
                    }
                    HStack {
                        Text("Bitcoin")
                        Spacer()
                        Text("$45,000")
                            .foregroundColor(.green)
                    }
                }
                .padding()

                Spacer()
                
                // Navigation to sentiment analysis or prediction
                NavigationLink(destination: SentimentAnalysisView()) {
                    Text("Análise de Sentimento")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("Market Dashboard")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
