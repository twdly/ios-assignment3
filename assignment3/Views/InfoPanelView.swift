//
//  InfoPanelView.swift
//  assignment3
//
//  Created by Tai Woodley on 8/5/2025.
//

import SwiftUI

struct InfoPanelView: View {
    let title: String
    let imageName: String
    let details: String
    let width: Int
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: imageName)
                Text(title)
            }
            Text(details).padding(.top)
        }
        .frame(width: CGFloat(width), height: 80)
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerSize: CGSize(width: 4, height: 4)))
    }
}

#Preview {
    InfoPanelView(title: "Temperature", imageName: "thermometer", details: "92°C", width: 140)
}
