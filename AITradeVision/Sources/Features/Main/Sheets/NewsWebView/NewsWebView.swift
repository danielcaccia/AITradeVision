//
//  NewsWebView.swift
//  AITradeVision
//
//  Created by Daniel Caccia on 20/04/25.
//

import SafariServices
import SwiftUI

struct NewsWebView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
}
