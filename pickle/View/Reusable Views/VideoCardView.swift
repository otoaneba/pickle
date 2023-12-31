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
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 500, height: 200)
                }
            }
        }
    }
}

#Preview {
    VideoCardView(url: URL(string: "")!)
}
