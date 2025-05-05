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
    @State var showAlert: Bool = false
    
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
            TextField("Share your thoughts...", text: $reviewText, axis: .vertical)
                .lineLimit(2...10)
                .frame(width: 300, alignment: .top)
                .border(.gray)
            Button {
                Task {
                    await submitReview()
                }
            } label: {
                Text("Submit")
            }.padding()
            Text(errorMessage).foregroundStyle(.red)
        }
        .navigationTitle("Review \(tea.name)")
        .alert("Success!", isPresented: $showAlert, actions: {}, message: {
            Text("Thank you for your review!")
        })
    }
    
    func submitReview() async {
        let review = ReviewModel(id: -1, teaName: tea.name, rating: rating + 1, message: reviewText, url: tea.url ?? "")
        
        showAlert = await ReviewDb.postReview(review)
        
        errorMessage = showAlert ? "" : "Something went wrong, please try again."
    }
}

#Preview {
    WriteReviewView(tea: TeaDb().teas[0])
}
