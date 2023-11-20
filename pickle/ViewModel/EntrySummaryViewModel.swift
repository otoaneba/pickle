//
//  EntrySummaryViewModel.swift
//  pickle
//
//  Created by Naoto Abe on 11/16/23.
//

import Foundation
import SwiftUI
import UIKit

class EntrySummaryViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var imageMessage: String = ""
    let manager = LocalFileManager.instance
    let imageName: String = "test"
    private var context = PersistenceController.shared.container.viewContext
    
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
        imageMessage = manager.saveImage(image: image, name: imageName).status
        
        let photo = DailyEntry(context: self.context)
        photo.date = .now
    }
}
