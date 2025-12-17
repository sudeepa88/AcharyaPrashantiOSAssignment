//
//  ProductLazyImage.swift
//  AcharyaPrashantLatestAssignment
//
//  Created by Sudeepa Pal on 17/12/25.
//

import SwiftUI

struct ProductLazyImage: View {
    
    @StateObject private var downloader: ProductImageDownloader

    init(imageUrl: String) {
        _downloader = StateObject(
            wrappedValue: ProductImageDownloader(imageUrl: imageUrl)
        )
    }

    var body: some View {
        ZStack {
            if let image = downloader.downloadedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                Color.gray.opacity(0.15)
            }
        }
        .onAppear {
            downloader.load()   
        }
        .onDisappear {
            downloader.cancel()
        }
        .clipped()
    }
}


