//
//  CameraView.swift
//  pickle
//
//  Created by Naoto Abe on 11/10/23.
//

import SwiftUI

struct CameraView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CameraViewController {
        let viewController = CameraViewController()
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {
        
    }
}

#Preview {
    CameraView()
}
