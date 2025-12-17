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

    init(imageUrl: String) {
        self.imageURL = URL(string: imageUrl)
    }

    func load() {
        guard let url = imageURL, downloadedImage == nil else { return }

        dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self = self else { return }

            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.downloadedImage = image
                }
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
