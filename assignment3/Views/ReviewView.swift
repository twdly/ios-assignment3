//
//  ReviewView.swift
//  assignment3
//
//  Created by Tai Woodley on 27/4/2025.
//

import SwiftUI

struct ReviewView: View {
    @StateObject var reviewsDb: ReviewDb = ReviewDb()
    @State var errorMessage: String = ""
    
    var body: some View {
        NavigationStack {
            if reviewsDb.reviews.isEmpty {
                Text(errorMessage.isEmpty ? "No reviews could be found" : errorMessage)
            } else {
                List {
                    ForEach(reviewsDb.reviews) { review in
                        VStack(alignment: .leading) {
                            Text(review.teaName).font(.title2)
                            Text("\(review.rating) / 10")
                            Text(review.message)
                            if !review.url.isEmpty {
                                Link(destination: URL(string: review.url)!) {
                                    Image(systemName: "link")
                                }
                            }
                        }
                    }
                }.navigationTitle("Reviews")
            }
        }.onAppear(perform: {
            Task {
                await reviewsDb.loadReviews()
            }
        })
    }
}

#Preview {
    ReviewView()
}
