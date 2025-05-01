//
//  WriteReviewView.swift
//  assignment3
//
//  Created by Tai Woodley on 1/5/2025.
//

import SwiftUI

struct WriteReviewView: View {
    @StateObject var tea: TeaModel
    @State var rating: Int = 0
    @State var reviewText: String = ""
    @State var errorMessage: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("Rating:")
                Picker("Rating", selection: $rating) {
                    ForEach(1..<11) { num in
                        Text("\(num)")
                    }
                }
                Text("/ 10")
            }
            TextField("Share your thoughts...", text: $reviewText).frame(width: 300, height: 150, alignment: .top).border(.gray)
            Button {
                Task {
                    await submit()
                }
            } label: {
                Text("Submit")
            }.padding()
            Text(errorMessage).foregroundStyle(.red)
        }.navigationTitle("Review \(tea.name)")
    }
    
    func submit() async {
        let review = ReviewModel(id: -1, teaName: tea.name, rating: rating + 1, message: reviewText, url: tea.url ?? "")
        
        // This URL is a web server used to store and read reviews in json format
        // https://github.com/twdly/tea-reviews
        let url = URL(string: "https://teareview-fuaygvbagwfegda8.australiaeast-01.azurewebsites.net/")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        do {
            _ = try await URLSession.shared.upload(for: request, from: JSONEncoder().encode(review))
        } catch {
            errorMessage = "Something went wrong, please try again later"
        }
    }
}

#Preview {
    WriteReviewView(tea: TeaDb().teas[0])
}
