//
//  ProductImageListView.swift
//  AcharyaPrashantLatestAssignment
//
//  Created by Sudeepa Pal on 17/12/25.
//

import SwiftUI

struct ProductImageListView: View {
    
    @StateObject var viewModel = PostViewModel()

    var body: some View {

        ScrollView {
            LazyVStack(spacing: 18) {

                ForEach(viewModel.postStack.indices, id: \.self) { index in
                    let post = viewModel.postStack[index]

                    VStack(alignment: .leading, spacing: 10) {
                        ProductLazyImage(
                            imageUrl: post.thumbnail?.imageURL ?? ""
                        )
                        .frame(height: 200)
                        .cornerRadius(12)

                        Text(post.title ?? "")
                            .font(.headline)
                    }
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(.systemBackground))
                            .shadow(radius: 6)
                    )
                    .padding(.horizontal, 16)
                    .onAppear {
                        if index == viewModel.postStack.count - 2 {
                            viewModel.loadMore()
                        }
                    }
                }

                if viewModel.isLoading {
                    ProgressView().padding()
                }
            }
            .padding(.vertical, 16)
        }
        .background(Color(.systemGroupedBackground))
        .onAppear {
            viewModel.loadInitial()
        }
    }
}

#Preview {
    ProductImageListView()
}
