//
//  CameraView.swift
//  pickle
//
//  Created by Naoto Abe on 11/10/23.
//

import SwiftUI
import SwiftyCam

struct CameraView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SwiftyCamViewController {
        let viewController = SwiftyCamViewController()
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: SwiftyCamViewController, context: Context) {
        
    }
}

#Preview {
    CameraView()
}
