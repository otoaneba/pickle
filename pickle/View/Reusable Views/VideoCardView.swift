//
//  VideoCardView.swift
//  pickle
//
//  Created by Naoto Abe on 11/13/23.
//

import SwiftUI

struct VideoCardView: View {
    let url: URL?
    
    var body: some View {
        ZStack{
            ZStack(alignment: .bottomLeading) {
                if let data = try? Data(contentsOf: url ?? URL(string: "")!), let loaded = UIImage(data: data) {
                    Image(uiImage: loaded)
                        .resizable()
                        .scaledToFill()
                        .cornerRadius(30)
                }
                VStack(alignment: .leading) {
                    Text("Duration")
                    Text("")
                }
                .shadow(radius: 20)
                .padding()
            }
            Image(systemName: "play.fill")
                .foregroundColor(.white)
                .font(.title)
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(50)
            
        }
    }
}

#Preview {
    VideoCardView(url: URL(string: "")!)
}
