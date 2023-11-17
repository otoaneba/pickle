//
//  FileManager.swift
//  pickle
//
//  Created by Naoto Abe on 11/16/23.
//

import Foundation
import SwiftUI

class LocalFileManager {
    static let instance = LocalFileManager()
    let folderName: String = "Pickle_Entries"
    
    init() {
        createFolderIfNeeded()
    }
    
    func saveImage(image: UIImage, name: String) -> String {
        guard
            let data = image.jpegData(compressionQuality: 1.0),
            let path = getPathForImage(name: name) else {
            return "Error getting image"
        }
        do {
            try data.write(to: path)
            return "Success"
        } catch let error {
            return "Error saving image with error: \(error)."
        }
    }
    
    func getImage(name: String)-> UIImage? {
        guard
            let path = getPathForImage(name: name)?.path,
            FileManager
                .default
                .fileExists(atPath: path) else {
            print("Error getting path.")
            return nil
        }
        return UIImage(contentsOfFile: path)
    }
    
    func deleteImage(name: String) -> String {
        guard
            let path = getPathForImage(name: name)?.path,
            FileManager.default.fileExists(atPath: path) else {
            return "Error getting path."
        }
        do {
            try FileManager.default.removeItem(atPath: path)
            return "Successfully deleted."
        } catch let error {
            return "Error deleting image: \(error)"
        }
    }

    func createFolderIfNeeded() {
        guard
            let path = FileManager
                .default
                .urls(for: .documentDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .path else {
            return
        }
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                print("Success creating folder.")
            } catch let error {
                print("Error creating folder. \(error)")
            }
        }
    }
    
    func deleteFolder() {
        guard
            let path = FileManager
                .default
                .urls(for: .documentDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .path else {
            return
        }
        do {
            try FileManager.default.removeItem(atPath: path)
            print("Successfully deleted folder.")
        } catch let error {
            print("Error deleting folder. \(error)")
        }
    
    }

    func getPathForImage(name: String) -> URL? {
        guard
            let path = FileManager
                .default
                .urls(for: .documentDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .appendingPathComponent("\(name).jpg") else {
            print("Error getting path to image.")
            return nil
        }
        return path
    }
}
