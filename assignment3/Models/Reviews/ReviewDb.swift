//
//  ReviewDb.swift
//  assignment3
//
//  Created by Tai Woodley on 2/5/2025.
//

import Foundation

class ReviewDb: ObservableObject {
    @Published var reviews: [ReviewModel] = []
    
    func loadReviews() async -> String {
        let url = URL(string: "https://teareview-fuaygvbagwfegda8.australiaeast-01.azurewebsites.net/")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        do {
            let result = try await URLSession.shared.data(for: request)
            let decodedReviews = try JSONDecoder().decode([ReviewModel].self, from: result.0)
            await MainActor.run {
                reviews = decodedReviews
            }
            return ""
        } catch {
            return "Something went wrong, please try again later"
        }
    }
    
    static func postReview(_ review: ReviewModel) async -> Bool {
        // This URL is a web server used to store and read reviews in json format
        // https://github.com/twdly/tea-reviews
        let url = URL(string: "https://teareview-fuaygvbagwfegda8.australiaeast-01.azurewebsites.net/")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        do {
            _ = try await URLSession.shared.upload(for: request, from: JSONEncoder().encode(review))
            return true
        } catch {
            return false
        }
    }
}
