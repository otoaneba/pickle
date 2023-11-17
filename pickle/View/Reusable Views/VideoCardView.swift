//
//  VideoCardView.swift
//  pickle
//
//  Created by Naoto Abe on 11/13/23.
//

import SwiftUI

struct VideoCardView: View {
//    let image: UIImage?
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
//                if let image = image {
//                    Image(uiImage: image)
//                        .resizable()
//                        .scaledToFill()
//                        .cornerRadius(30)
//                }
//                AsyncImage(url: URL(string: "file:///var/mobile/Containers/Data/Application/A9B4C85A-B1C3-4D56-903D-896CA587B206/Documents/test.jpg")!) { image in
//                    image.resizable()
//                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
//                        .frame(width: 390, height: 250)
//                        .cornerRadius(30)
//                } placeholder: {
//                    Rectangle()
//                        .foregroundColor(.gray.opacity(0.3))
//                        .frame(width: 390, height: 250)
//                        .cornerRadius(5)
//                }
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
