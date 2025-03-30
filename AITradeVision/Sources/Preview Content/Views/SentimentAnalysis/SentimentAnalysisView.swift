//
//  SentimentAnalysisView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 31/03/25.
//

import SwiftUI

struct SentimentAnalysisView: View {
    var body: some View {
        VStack {
            Text("Análise de Sentimento")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            Text("Aqui, você verá as análises de sentimento de notícias sobre o mercado.")
                .padding()

            Spacer()
        }
        .navigationTitle("Sentiment Analysis")
    }
}

struct SentimentAnalysisView_Previews: PreviewProvider {
    static var previews: some View {
        SentimentAnalysisView()
    }
}
