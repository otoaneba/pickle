//
//  SwifyCamViewController.swift
//  pickle
//
//  Created by Naoto Abe on 11/24/23.
//

import Foundation
import SwiftyCam
import SwiftUI

class MyCamViewController : SwiftyCamViewController {
    
    // shutter button
    private let shutterButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button.layer.cornerRadius = 50
        button.layer.borderWidth = 10
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    let captureButton = SwiftyCamButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    var recordingVideo: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        captureButton.delegate = self
        //        view.layer.addSublayer(previewLayer)
//        view.addSubview(switchCameraButton)

//        shutterButton.addTarget(self, action: #selector(videoRecord), for: .touchUpInside)
//        switchCameraButton.addTarget(self, action: #selector(didTapTakePhoto), for: .touchUpInside)
    }

    @objc private func videoRecord() {
        recordingVideo.toggle()
        if recordingVideo {
            stopVideoRecording()
            print("recording ended")
        } else {
            startVideoRecording()
        }
    }
}

