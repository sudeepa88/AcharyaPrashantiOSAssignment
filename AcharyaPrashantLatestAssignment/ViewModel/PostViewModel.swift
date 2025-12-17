//
//  PostViewModel.swift
//  AcharyaPrashantLatestAssignment
//
//  Created by Sudeepa Pal on 17/12/25.
//

import Foundation
import SwiftUI
import Combine


class PostViewModel: ObservableObject {
    
    @Published var postStack: [ResponseModel] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let pageSize = 10
    private let totalLimit = 200
    private var currentLimit = 0
    private var canLoadMore = true

    func loadInitial() {
        postStack.removeAll()
        currentLimit = pageSize
        canLoadMore = true
        fetch()
    }

    func loadMore() {
        guard !isLoading, canLoadMore else { return }

        currentLimit += pageSize
        fetch()
    }

    private func fetch() {
        guard currentLimit <= totalLimit else {
            canLoadMore = false
            return
        }

        isLoading = true

        APICaller.getPostData(limit: currentLimit) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false

                switch result {
                case .success(let data):

                    
                    let existingIds = Set(self.postStack.compactMap { $0.id })
                    let newItems = data.filter {
                        guard let id = $0.id else { return false }
                        return !existingIds.contains(id)
                    }

                    self.postStack.append(contentsOf: newItems)

                    if data.count < self.currentLimit || self.currentLimit >= self.totalLimit {
                        self.canLoadMore = false
                    }

                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
