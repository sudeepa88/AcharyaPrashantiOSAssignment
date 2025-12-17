//
//  ProductImageDownloader.swift
//  AcharyaPrashantLatestAssignment
//
//  Created by Sudeepa Pal on 17/12/25.
//

import Foundation
import Combine
import UIKit




final class ProductImageDownloader: ObservableObject {
    
    @Published var downloadedImage: UIImage?

    private var dataTask: URLSessionDataTask?
    private let imageURL: URL?
    private let cacheKey: String

    init(imageUrl: String) {
        self.imageURL = URL(string: imageUrl)
        self.cacheKey = imageUrl
    }

    func load() {
        // 1️⃣ MEMORY CACHE HIT
        if let cachedImage = ImageCache.shared.image(forKey: cacheKey) {
            self.downloadedImage = cachedImage
            return
        }

        guard let url = imageURL else { return }

        dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self = self,
                  let data = data,
                  let image = UIImage(data: data) else { return }

            // 2️⃣ SAVE TO CACHE
            ImageCache.shared.setImage(image, forKey: self.cacheKey)

            DispatchQueue.main.async {
                self.downloadedImage = image
            }
        }

        dataTask?.resume()
    }

    func cancel() {
        dataTask?.cancel()
        dataTask = nil
    }

    deinit {
        cancel()
    }
}
