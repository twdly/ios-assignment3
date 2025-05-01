//
//  WriteReviewView.swift
//  assignment3
//
//  Created by Tai Woodley on 1/5/2025.
//

import SwiftUI

struct WriteReviewView: View {
    @StateObject var tea: TeaModel
    @State var rating: Int = 1
    @State var reviewText: String = ""
    
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
            Button(action: submit) {
                Text("Submit")
            }.padding()
        }.navigationTitle("Review \(tea.name)")
    }
    
    func submit() {
        
    }
}

#Preview {
    WriteReviewView(tea: TeaDb().teas[0])
}
