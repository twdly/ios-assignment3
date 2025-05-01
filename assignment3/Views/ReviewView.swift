//
//  ReviewView.swift
//  assignment3
//
//  Created by Tai Woodley on 27/4/2025.
//

import SwiftUI

struct ReviewView: View {
    @State var reviews: [ReviewModel] = []
    @State var errorMessage: String = ""
    
    var body: some View {
        VStack {
            if reviews.isEmpty {
                Text(errorMessage.isEmpty ? "No reviews could be found" : errorMessage)
            } else {
                List {
                    ForEach(reviews) { review in
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
                }
            }
        }.onAppear(perform: {
            Task {
                await loadReviews()
            }
        })
    }
    
    func loadReviews() async {
        let url = URL(string: "https://teareview-fuaygvbagwfegda8.australiaeast-01.azurewebsites.net/")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        do {
            let result = try await URLSession.shared.data(for: request)
            reviews = try JSONDecoder().decode([ReviewModel].self, from: result.0)
        } catch {
            errorMessage = "Something went wrong, please try again later"
        }
    }
}

#Preview {
    ReviewView()
}
