//
//  EntrySummaryViewModel.swift
//  pickle
//
//  Created by Naoto Abe on 11/16/23.
//

import SwiftUI

class EntrySummaryViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var imageMessage: String = ""
    let manager = LocalFileManager.instance
    let imageName: String = "test"

    
    init() {
        getImageFromAssetsFolder()
    }
    
    private func getImageFromAssetsFolder() {
        image = UIImage(named: imageName)
    }
    
    private func getImageFromFileManager() {
        image = manager.getImage(name: imageName)
    }
    
    private func deleteImage() {
        imageMessage = manager.deleteImage(name: imageName)
    }
    
    private func saveImage() {
        guard let image = image else { return }
        imageMessage = manager.saveImage(image: image, name: imageName)
    }
}
